import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/config/app_config.dart';
import 'package:reservme/core/fake/fake_store.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/core/router/guards.dart';
import 'package:reservme/core/router/routes.dart';
import 'package:reservme/features/admin/admin_providers.dart';
import 'package:reservme/features/admin/data/real_admin_repository.dart';
import 'package:reservme/features/admin/domain/admin.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/auth/application/auth_state.dart';
import 'package:reservme/features/auth/domain/user.dart';
import 'package:reservme/features/shell/application/app_mode_controller.dart';
import 'package:reservme/features/venue/venues/domain/venue_membership.dart';

import '../helpers/fakes.dart';
import '../helpers/stub_adapter.dart';

const testMembership = VenueMembership(
  orgId: 'v_1',
  slug: 'katipunan',
  name: 'Katipunan Courts',
  role: VenueRole.owner,
);

void main() {
  Future<ProviderContainer> signedIn(TestWorld world, String email) async {
    final container = world.container();
    await container
        .read(authControllerProvider.notifier)
        .signIn(email: email, password: FakeAccounts.password);
    return container;
  }

  FakeVenue venue(TestWorld world, String slug) => world.store.venueBySlug(slug)!;

  FakeBillingPayment submit(TestWorld world, FakeVenue v, String reference) {
    final pay = FakeBillingPayment(
      id: world.store.nextId('pay'),
      venueId: v.id,
      amountCents: 99900,
      reference: reference,
      paidAt: '2026-09-20',
      createdAt: world.now,
    );
    world.store.billingPayments.add(pay);
    return pay;
  }

  group('who reaches the console', () {
    test('/me says the demo owner is a platform admin, and staff are not', () async {
      final owner = await signedIn(TestWorld(), FakeAccounts.ownerEmail);
      expect(owner.read(authControllerProvider).isPlatformAdmin, isTrue);

      final staff = await signedIn(TestWorld(), FakeAccounts.staffEmail);
      expect(staff.read(authControllerProvider).isPlatformAdmin, isFalse);
    });

    test('a non-admin gets 404 from the console, not 403', () async {
      final container = await signedIn(TestWorld(), FakeAccounts.staffEmail);
      await expectLater(
        container.read(adminRepositoryProvider).overview(),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 404)),
      );
    });

    AuthState session({required bool admin, bool venues = true}) => AuthState.signedIn(
          user: const User(id: 'u', email: 'a@b.test'),
          token: 't',
          expiresAt: DateTime.utc(2030),
          platformAdmin: admin,
          venues: venues ? [testMembership] : const [],
        );

    test('the admin routes turn away anyone who is not an admin', () {
      for (final path in [Routes.admin, Routes.adminPayments, Routes.adminTenant('v_1')]) {
        expect(
          computeRedirect(
            uri: Uri.parse(path),
            auth: session(admin: false),
            mode: AppMode.venue,
            canOnboard: true,
          ),
          AppMode.venue.home,
          reason: path,
        );
        expect(
          computeRedirect(
            uri: Uri.parse(path),
            auth: session(admin: true),
            mode: AppMode.venue,
            canOnboard: true,
          ),
          isNull,
          reason: path,
        );
      }
    });

    test('signed out, the console sends you to sign in and back', () {
      final to = computeRedirect(
        uri: Uri.parse(Routes.adminPayments),
        auth: const AuthState.signedOut(),
        mode: AppMode.customer,
        canOnboard: true,
      );
      expect(to, startsWith(Routes.login));
      expect(Uri.decodeComponent(to!), contains(Routes.adminPayments));
    });

    test('an admin with no venue lands on the console, not venue setup', () {
      expect(
        afterSignInTarget(from: null, auth: session(admin: true, venues: false), canOnboard: true),
        Routes.admin,
      );
      expect(
        afterSignInTarget(from: null, auth: session(admin: false, venues: false), canOnboard: true),
        Routes.createVenue,
      );
      // And a console link survives the sign-in detour.
      expect(
        afterSignInTarget(from: Routes.adminPayments, auth: session(admin: true), canOnboard: true),
        Routes.adminPayments,
      );
    });
  });

  group('approving a payment', () {
    test('extends a month from the trial end when paid during the trial', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final v = venue(world, FakeVenues.katipunan);
      final sub = world.store.subscriptionOf(v.id)!;
      final trialEnds = sub.trialEndsAt;
      expect(trialEnds.isAfter(world.now), isTrue, reason: 'seeded mid-trial');

      await container.read(adminRepositoryProvider).approvePayment(submit(world, v, 'REF-1').id);

      expect(sub.status, BillingStatus.active);
      // Paying early never costs the venue days.
      expect(sub.paidUntil!.difference(trialEnds).inDays, inInclusiveRange(28, 31));
    });

    test('twice is refused, not a second month', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final v = venue(world, FakeVenues.katipunan);
      final pay = submit(world, v, 'REF-2');
      final repo = container.read(adminRepositoryProvider);

      await repo.approvePayment(pay.id);
      final paidUntil = world.store.subscriptionOf(v.id)!.paidUntil;

      await expectLater(
        repo.approvePayment(pay.id),
        throwsA(isA<ApiError>().having((e) => e.reason, 'reason', 'not_submitted')),
      );
      expect(world.store.subscriptionOf(v.id)!.paidUntil, paidUntil);
    });

    test('lifts a billing suspension and never a manual one', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final repo = container.read(adminRepositoryProvider);

      final marikina = venue(world, FakeVenues.marikinaFutsal);
      expect(marikina.suspendedReason, BillingPolicy.suspendReason, reason: 'seeded as billing-suspended');
      final norte = venue(world, FakeVenues.studioNorte)
        ..suspendedAt = world.now
        ..suspendedReason = 'Abuse report';

      await repo.approvePayment(submit(world, marikina, 'REF-3').id);
      await repo.approvePayment(submit(world, norte, 'REF-4').id);

      expect(marikina.suspended, isFalse);
      expect(norte.suspended, isTrue);
    });

    test('is written to the audit trail with the reference', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final repo = container.read(adminRepositoryProvider);

      await repo.approvePayment(submit(world, venue(world, FakeVenues.katipunan), 'REF-5').id);

      final entries = await repo.audit();
      expect(entries.first.action, 'admin.approved_payment');
      expect(entries.first.label, 'Approved payment');
      expect(entries.first.summary, 'Ref REF-5');
      expect(entries.first.organizationName, 'Katipunan Courts');
    });
  });

  group('billing overrides', () {
    test('mark paid is inclusive of the chosen day', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final v = venue(world, FakeVenues.katipunan);

      await container.read(adminRepositoryProvider).overrideBilling(v.id, const MarkPaid('2031-03-15'));

      expect(world.store.subscriptionOf(v.id)!.paidUntil, DateTime.utc(2031, 3, 16));
    });

    test('comping lifts a billing suspension', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final marikina = venue(world, FakeVenues.marikinaFutsal);

      await container.read(adminRepositoryProvider).overrideBilling(marikina.id, const Comp());

      expect(world.store.subscriptionOf(marikina.id)!.status, BillingStatus.comped);
      expect(marikina.suspended, isFalse);
    });

    test('the wire shape is what the server parses', () {
      expect(const MarkPaid('2031-03-15').toJson(), {'action': 'mark_paid', 'paidUntil': '2031-03-15'});
      expect(const Comp().toJson(), {'action': 'comp'});
      expect(const CancelSubscription().toJson(), {'action': 'cancel'});
    });
  });

  group('the overview', () {
    test('puts the billing-suspended venue on the radar and counts the queue', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      submit(world, venue(world, FakeVenues.katipunan), 'REF-6');

      final overview = await container.read(adminRepositoryProvider).overview();

      expect(overview.radar.suspended.map((t) => t.slug), contains(FakeVenues.marikinaFutsal));
      expect(overview.pendingPayments, greaterThanOrEqualTo(1));
      expect(overview.totals.tenants, 3);
      expect(overview.growth, hasLength(12));
      // A suspended venue bills nothing this month.
      final marikina = overview.radar.suspended.first;
      expect(
        overview.totals.runRateCents,
        lessThan(
          [
            for (final t in await container.read(adminRepositoryProvider).tenants())
              t.band.priceCents ?? 0,
          ].fold<int>(0, (a, b) => a + b),
        ),
        reason: '${marikina.name} is suspended',
      );
    });

    test('search finds a venue by name or slug', () async {
      final container = await signedIn(TestWorld(), FakeAccounts.ownerEmail);
      final repo = container.read(adminRepositoryProvider);
      expect((await repo.tenants(query: 'norte')).single.slug, FakeVenues.studioNorte);
      expect((await repo.tenants(query: 'marikina-futsal')).single.name, 'Marikina Futsal');
      expect(await repo.tenants(query: 'nowhere'), isEmpty);
    });
  });

  group('suspending and emailing', () {
    test('suspends with a reason and reactivates', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final repo = container.read(adminRepositoryProvider);
      final v = venue(world, FakeVenues.studioNorte);

      await repo.suspend(v.id, reason: 'Chargeback dispute');
      expect(v.suspendedReason, 'Chargeback dispute');
      expect((await repo.audit()).first.summary, '"Chargeback dispute"');

      await repo.reactivate(v.id);
      expect(v.suspended, isFalse);
    });

    test('emails the first owner, and refuses an empty message', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final repo = container.read(adminRepositoryProvider);
      final v = venue(world, FakeVenues.katipunan);

      await expectLater(
        repo.emailOwner(v.id, subject: 'Hi', body: ' '),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 400)),
      );
      await repo.emailOwner(v.id, subject: 'Your invoice', body: 'Please pay.');
      expect(world.store.outbox.last.to, FakeAccounts.ownerEmail);
      expect(world.store.outbox.last.kind, FakeEmailKind.adminMessage);
    });
  });

  group('admins', () {
    test('the last admin cannot be revoked', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final repo = container.read(adminRepositoryProvider);
      final self = (await repo.admins()).single;
      expect(self.isSelf, isTrue);

      await expectLater(
        repo.revokeAdmin(self.userId),
        throwsA(isA<ApiError>().having((e) => e.reason, 'reason', 'last_admin')),
      );
    });

    test('one of two can be', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final staff = world.store.users.firstWhere((u) => u.email == FakeAccounts.staffEmail);
      world.store.platformAdmins.add(staff.id);

      await container.read(adminRepositoryProvider).revokeAdmin(staff.id);
      expect(world.store.platformAdmins, isNot(contains(staff.id)));
    });
  });

  group('over HTTP', () {
    test('saving without a new QR sends the current one back', () async {
      // The server treats an empty field as "clear it", so keeping the QR
      // means re-sending it — the easy mistake is to send nothing.
      final (:client, :stub) = stubbedClient([
        const Reply.ok({'qrUrl': 'https://cdn.test/qr.png', 'payee': 'Old', 'configured': true}),
        const Reply.ok({'qrUrl': 'https://cdn.test/qr.png', 'payee': 'New', 'configured': true}),
      ]);
      final repo = RealAdminRepository(client, ApiMode.real);

      final saved = await repo.saveInstapay(payee: ' New ', account: '0917');

      expect(stub.requests.last.method, 'PUT');
      expect(stub.requests.last.path, '/mobile/admin/billing-config');
      expect(stub.requests.last.body, {
        'qrUrl': 'https://cdn.test/qr.png',
        'payee': 'New',
        'account': '0917',
      });
      expect(saved.payee, 'New');
    });

    test('a new QR travels as a data URL; removing it sends empty', () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({'configured': false}),
        const Reply.ok({'configured': false}),
      ]);
      final repo = RealAdminRepository(client, ApiMode.real);

      await repo.saveInstapay(payee: 'P', account: 'A', qrImage: [1, 2, 3]);
      expect(stub.requests.first.body['qrUrl'], 'data:image/jpeg;base64,AQID');

      await repo.saveInstapay(payee: 'P', account: 'A', clearQr: true);
      expect(stub.requests.last.body['qrUrl'], '');
      expect(stub.requests, hasLength(2), reason: 'no read-back needed either way');
    });

    test('reads the overview and the queue as the server writes them', () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({
          'totals': {'tenants': 2, 'runRateCents': 149800},
          'radar': {
            'suspended': [
              {
                'orgId': 'o1',
                'name': 'Marikina',
                'slug': 'marikina',
                'createdAt': '2026-01-01T00:00:00.000Z',
                'suspendedAt': '2026-09-01T00:00:00.000Z',
                'billingSuspended': true,
                'subscription': {'status': 'past_due', 'trialDaysLeft': 0, 'dueNow': true},
                'band': {'name': 'Solo', 'priceCents': 49900},
              },
            ],
          },
          'pendingPayments': 1,
          'growth': [
            {'month': '2026-09', 'signups': 1, 'cancellations': 0, 'cumulative': 2},
          ],
        }),
        const Reply.ok({
          'payments': [
            {
              'id': 'p1',
              'orgId': 'o1',
              'venueName': 'Marikina',
              'amountCents': 49900,
              'reference': 'REF',
              'paidAt': '2026-09-20T00:00:00.000Z',
              'receiptUrl': null,
              'createdAt': '2026-09-21T03:00:00.000Z',
            },
          ],
        }),
      ]);
      final repo = RealAdminRepository(client, ApiMode.real);

      final overview = await repo.overview();
      expect(overview.totals.runRateCents, 149800);
      expect(overview.radar.suspended.single.subscription.status, BillingStatus.pastDue);
      expect(overview.radar.suspended.single.billingSuspended, isTrue);

      final queue = await repo.paymentQueue();
      expect(queue.single.venueName, 'Marikina');
      expect(queue.single.createdAt.isUtc, isTrue);
    });
  });
}
