import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/venue/billing/application/billing_controller.dart';
import 'package:reservme/features/venue/billing/domain/billing.dart';
import 'package:reservme/features/venue/spaces/application/spaces_controller.dart';

import '../helpers/fakes.dart';

void main() {
  const slug = FakeVenues.katipunan;

  Future<void> signIn(ProviderContainer container, String email) => container
      .read(authControllerProvider.notifier)
      .signIn(email: email, password: FakeAccounts.password);

  group('plan bands', () {
    test('a venue is banded by how many spaces it runs', () {
      expect(PlanBand.forSpaces(1).id, 'solo');
      expect(PlanBand.forSpaces(2).id, 'club');
      expect(PlanBand.forSpaces(6).id, 'club');
      expect(PlanBand.forSpaces(7).id, 'complex');
      expect(PlanBand.forSpaces(15).id, 'complex');
      expect(PlanBand.forSpaces(16).id, 'multi');
      expect(PlanBand.forSpaces(400).id, 'multi');
    });

    test('a venue with nothing on sale sits in the entry band', () {
      // The web's `activeSpaces === 0 ? PLANS[0] : planForSpaces(...)`: zero
      // matches no band's minSpaces, and falling off the table would be worse
      // than showing the cheapest one.
      expect(PlanBand.forSpaces(0).id, 'solo');
    });

    test('the top band is quoted, not priced', () {
      expect(PlanBand.forSpaces(16).pricePesos, isNull);
      expect(PlanBand.forSpaces(16).spread, '16 or more spaces');
      expect(PlanBand.forSpaces(1).spread, '1 space');
      expect(PlanBand.forSpaces(3).spread, '2–6 spaces');
    });
  });

  group('payment proof input', () {
    test('needs a reference and a date, in the server\'s words', () {
      expect(
        const PaymentProofInput(reference: 'ab', paidAt: '2026-09-24')
            .validate(),
        'Enter the InstaPay reference number.',
      );
      expect(
        const PaymentProofInput(reference: 'ABC123', paidAt: '24/09/2026')
            .validate(),
        'Pick the date you paid.',
      );
      expect(
        const PaymentProofInput(reference: 'ABC123', paidAt: '2026-09-24')
            .validate(),
        isNull,
      );
    });
  });

  group('the billing screen', () {
    test('derives the band from active spaces, never from a stored plan',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final before = await container.read(billingControllerProvider(slug).future);
      expect(before.activeSpaces, greaterThan(1));
      expect(before.band.id, 'club');
      expect(before.amountDueCents, 99900);

      // Pause everything but one court, and the band drops on the next read
      // with no billing write anywhere.
      final spaces = await container.read(spacesProvider(slug).future);
      final active = spaces.where((s) => s.isActive).toList();
      for (final space in active.skip(1)) {
        await container
            .read(spacesProvider(slug).notifier)
            .setActive(space.id, false);
      }
      container.invalidate(billingControllerProvider(slug));

      final after = await container.read(billingControllerProvider(slug).future);
      expect(after.activeSpaces, 1);
      expect(after.band.id, 'solo');
      expect(after.amountDueCents, 49900);
    });

    test('a trialing venue counts down whole days and owes nothing yet',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final billing = await container.read(billingControllerProvider(slug).future);

      expect(billing.status, BillingStatus.trialing);
      expect(billing.daysLeftInTrial, isNotNull);
      expect(billing.daysLeftInTrial, greaterThanOrEqualTo(0));
      expect(billing.dueNow, isFalse);
      expect(billing.suspended, isFalse);
    });

    test('an overdue venue is due now and switched off', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final billing = await container
          .read(billingControllerProvider(FakeVenues.marikinaFutsal).future);

      expect(billing.status, BillingStatus.pastDue);
      // Its trial ended weeks ago.
      expect(billing.dueNow, isTrue);
      expect(billing.daysLeftInTrial, isNull);
      // And the seed suspends it for exactly the reason billing keys off.
      expect(billing.suspended, isTrue);
    });

    test('a suspension billing did not create is not billing\'s to lift',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      // An abuse suspension, not an overdue one.
      world.store.venueBySlug(FakeVenues.marikinaFutsal)!.suspendedReason =
          'Reported for fraud';

      final billing = await container
          .read(billingControllerProvider(FakeVenues.marikinaFutsal).future);

      expect(billing.suspended, isFalse);
    });

    test('submitting a payment takes the amount from the band, not the form',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final notifier = container.read(billingControllerProvider(slug).notifier);
      final before = await container.read(billingControllerProvider(slug).future);

      await notifier.submitProof(
        const PaymentProofInput(reference: 'INSTA-9931', paidAt: '2026-09-24'),
      );

      final after = container.read(billingControllerProvider(slug)).value!;
      expect(after.pendingPayment, isNotNull);
      expect(after.pendingPayment!.amountCents, before.amountDueCents);
      expect(after.pendingPayment!.reference, 'INSTA-9931');
      expect(after.pendingPayment!.status, PaymentStatus.submitted);
      expect(after.history, hasLength(1));
    });

    test('a second payment is refused while one is under review', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final notifier = container.read(billingControllerProvider(slug).notifier);
      await container.read(billingControllerProvider(slug).future);

      await notifier.submitProof(
        const PaymentProofInput(reference: 'INSTA-1', paidAt: '2026-09-24'),
      );
      await expectLater(
        notifier.submitProof(
          const PaymentProofInput(reference: 'INSTA-2', paidAt: '2026-09-24'),
        ),
        throwsA(isA<ApiError>()
            .having((e) => e.status, 'status', 409)
            .having((e) => e.message, 'message',
                'You already have a payment under review.')),
      );
    });

    test('front desk cannot see billing at all', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.staffEmail);

      await expectLater(
        container.read(billingControllerProvider(slug).future),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 403)),
      );
    });
  });
}
