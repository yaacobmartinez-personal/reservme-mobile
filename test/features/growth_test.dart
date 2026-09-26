import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/config/app_config.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/core/time/app_time.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/customer/booking/domain/booking.dart';
import 'package:reservme/features/customer/customer_providers.dart';
import 'package:reservme/features/venue/growth/data/real_growth_repository.dart';
import 'package:reservme/features/venue/growth/domain/growth.dart';
import 'package:reservme/features/venue/venue_providers.dart';

import '../helpers/fakes.dart';
import '../helpers/stub_adapter.dart';

void main() {
  const slug = FakeVenues.katipunan;
  const zone = 'Asia/Manila';

  Future<ProviderContainer> signedIn(TestWorld world, String email) async {
    final container = world.container();
    await container
        .read(authControllerProvider.notifier)
        .signIn(email: email, password: FakeAccounts.password);
    return container;
  }

  group('plans', () {
    test('a plan needs credits or a discount, in the server\'s words', () {
      expect(
        const PlanInput(name: 'Nothing', price: '500').validate()['credits'],
        'A plan needs either credits or a discount (or both).',
      );
      expect(const PlanInput(name: 'Club', price: '999', discountPct: '120').validate(),
          containsPair('discountPct', 'A discount must be between 1 and 100.'));
      expect(const PlanInput(name: '10-pack', price: '4500', credits: '10').validate(), isEmpty);
    });

    test('whole pesos in, centavos stored, and the kind decides the period', () async {
      final container = await signedIn(TestWorld(), FakeAccounts.ownerEmail);
      final repo = container.read(growthRepositoryProvider);

      final club = await repo.createPlan(
        slug,
        const PlanInput(name: 'Morning club', kind: PlanKind.membership, price: '1200', discountPct: '10'),
      );
      expect(club.priceCents, 120000);
      expect(club.period, 'monthly');
      expect(club.benefits, '10% off · monthly');
    });

    test('the front desk can read plans but not make them', () async {
      final container = await signedIn(TestWorld(), FakeAccounts.staffEmail);
      final repo = container.read(growthRepositoryProvider);

      expect(await repo.plans(slug), isNotEmpty);
      await expectLater(
        repo.createPlan(slug, const PlanInput(name: 'Nope', price: '1', credits: '1')),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 403)),
      );
    });
  });

  group('granting a plan', () {
    test('seeds the credits and expiry, and the profile shows it', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final repo = container.read(growthRepositoryProvider);
      final venue = world.store.venueBySlug(slug)!;
      final customer = world.store.customers.firstWhere((c) => c.venueId == venue.id);
      final pass = (await repo.plans(slug)).firstWhere((p) => p.kind == PlanKind.pass);

      final holdings = await repo.grantPlan(slug, customer.id, pass.id);

      final granted = holdings.firstWhere((h) => h.planId == pass.id);
      expect(granted.creditsRemaining, pass.credits);
      expect(granted.expiresAt!.difference(world.now).inDays, pass.validDays);

      final profile = await container.read(customersRepositoryProvider).detail(slug, customer.id);
      expect(profile.holdings.map((h) => h.planId), contains(pass.id));
    });

    test('a paused plan is refused', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final repo = container.read(growthRepositoryProvider);
      final venue = world.store.venueBySlug(slug)!;
      final customer = world.store.customers.firstWhere((c) => c.venueId == venue.id);
      final plan = (await repo.plans(slug)).first;
      await repo.setPlanActive(slug, plan.id, false);

      await expectLater(
        repo.grantPlan(slug, customer.id, plan.id),
        throwsA(isA<ApiError>().having((e) => e.reason, 'reason', 'plan_unavailable')),
      );
    });

    test('the profile carries loyalty points', () async {
      final world = TestWorld();
      final container = await signedIn(world, FakeAccounts.ownerEmail);
      final venue = world.store.venueBySlug(slug)!;
      final customer = world.store.customers.firstWhere((c) => c.venueId == venue.id && c.loyaltyPoints > 0);

      final profile = await container.read(customersRepositoryProvider).detail(slug, customer.id);
      expect(profile.customer.loyaltyPoints, customer.loyaltyPoints);
    });
  });

  group('promo codes', () {
    test('upper-cased, unique, a peso amount in centavos', () async {
      final container = await signedIn(TestWorld(), FakeAccounts.ownerEmail);
      final repo = container.read(growthRepositoryProvider);

      final code = await repo.createPromo(
        slug,
        const PromoInput(code: 'save50', kind: PromoKind.amount, value: '50'),
      );
      expect(code.code, 'SAVE50');
      expect(code.amountCents, 5000);

      await expectLater(
        repo.createPromo(slug, const PromoInput(code: 'Save50', value: '5')),
        throwsA(isA<ApiError>().having((e) => e.message, 'message', 'You already have a code named SAVE50.')),
      );
    });

    test('expires at the end of the day in the venue\'s zone', () async {
      final container = await signedIn(TestWorld(), FakeAccounts.ownerEmail);
      final code = await container.read(growthRepositoryProvider).createPromo(
            slug,
            const PromoInput(code: 'NEWYEAR', value: '10', expiresAt: '2031-01-01'),
          );
      // 23:59:59 in Manila is 15:59:59 UTC — the server shipped this eight
      // hours early once; the fake must not.
      expect(code.expiresAt, DateTime.utc(2031, 1, 1, 15, 59, 59));
    });

    test('a code comes off a booking, and a bad one is refused in its own words', () async {
      final world = TestWorld();
      final container = world.container();
      final bookings = container.read(bookingRepositoryProvider);
      final venue = await container.read(venuesRepositoryProvider).bySlug(slug);
      final court = venue.spaces.firstWhere((s) => s.name == 'Court 1');
      final tomorrow = AppTime.addDays(AppTime.today(world.now, zone), 1, zone);
      final day = await bookings.availability(venueSlug: slug, spaceId: court.id, date: tomorrow);
      final open = day.slots.where((s) => s.available).toList();

      BookingInput at(int i, String? promo) => BookingInput(
            spaceId: court.id,
            startsAt: open[i].startsAt,
            endsAt: open[i].endsAt,
            name: 'New Customer',
            email: 'new$i@example.com',
            promo: promo,
          );

      final bad = await bookings.book(venueSlug: slug, input: at(0, 'NOPE'));
      expect(bad, isA<BookingInvalid>());
      expect((bad as BookingInvalid).fieldErrors['promo'], "That promo code isn't recognised.");

      final seeded = world.store.promos.firstWhere((p) => p.code == 'WELCOME10');
      final usesBefore = seeded.uses;
      final booked = await bookings.book(venueSlug: slug, input: at(0, 'welcome10'));
      expect(booked, isA<Booked>());
      expect((booked as Booked).booking.amountCents, open[0].priceCents - open[0].priceCents ~/ 10);
      expect(seeded.uses, usesBefore + 1);
    });

    test('a pass credit covers the slot for a returning holder', () async {
      final world = TestWorld();
      final container = world.container();
      final bookings = container.read(bookingRepositoryProvider);
      final venue = await container.read(venuesRepositoryProvider).bySlug(slug);
      final court = venue.spaces.firstWhere((s) => s.name == 'Court 1');
      final holding = world.store.holdings.first;
      final holder = world.store.customers.firstWhere((c) => c.id == holding.customerId);
      final before = holding.creditsRemaining;
      final tomorrow = AppTime.addDays(AppTime.today(world.now, zone), 1, zone);
      final slot = (await bookings.availability(venueSlug: slug, spaceId: court.id, date: tomorrow))
          .slots
          .firstWhere((s) => s.available);

      final booked = await bookings.book(
        venueSlug: slug,
        input: BookingInput(
          spaceId: court.id,
          startsAt: slot.startsAt,
          endsAt: slot.endsAt,
          name: holder.name,
          email: holder.email,
        ),
      );

      expect((booked as Booked).booking.amountCents, 0);
      expect(holding.creditsRemaining, before - 1);
    });
  });

  group('marketing', () {
    test('a review link must be a full link', () {
      expect(reviewUrlProblem('g.page/x'), 'Enter a full link, e.g. https://g.page/…');
      expect(reviewUrlProblem('https://g.page/x'), isNull);
      expect(reviewUrlProblem(''), isNull, reason: 'empty turns review emails off');
    });
  });

  group('integrations', () {
    test('front-desk staff cannot see them', () async {
      final container = await signedIn(TestWorld(), FakeAccounts.staffEmail);
      await expectLater(
        container.read(growthRepositoryProvider).integrations(slug),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 403)),
      );
    });

    test('an API key is whole once, then only its prefix', () async {
      final container = await signedIn(TestWorld(), FakeAccounts.ownerEmail);
      final repo = container.read(growthRepositoryProvider);

      final created = await repo.createApiKey(slug, 'Accounting');
      final listed = await repo.integrations(slug);

      expect(listed.apiKeys.single.prefix, created.key.substring(0, 14));
      expect(listed.toString(), isNot(contains(created.key)));
    });

    test('rotating the calendar feed changes its link', () async {
      final container = await signedIn(TestWorld(), FakeAccounts.ownerEmail);
      final repo = container.read(growthRepositoryProvider);
      final before = (await repo.integrations(slug)).icalUrl;
      final after = (await repo.rotateCalendarFeed(slug)).icalUrl;
      expect(after, isNot(before));
    });

    test('a webhook must be https', () async {
      final container = await signedIn(TestWorld(), FakeAccounts.ownerEmail);
      await expectLater(
        container.read(growthRepositoryProvider).addWebhook(
              slug,
              url: 'http://insecure.test/hook',
              events: const ['booking.created'],
            ),
        throwsA(isA<ApiError>().having((e) => e.fieldErrors['url'], 'url', 'Enter a valid https URL.')),
      );
    });
  });

  test('an export is CSV with CRLF lines, in the venue\'s time', () async {
    final container = await signedIn(TestWorld(), FakeAccounts.ownerEmail);
    final csv = await container.read(growthRepositoryProvider).export(slug, ExportKind.transactions);
    expect(csv.split('\r\n').first, 'Date,Reference,Customer,Space,Status,Gross,Discount,Net');
    expect(csv.endsWith('\r\n'), isTrue);
  });

  group('over HTTP', () {
    test('a plan and a code go in the shape the server parses', () async {
      final (:client, :stub) = stubbedClient([
        const Reply(201, {
          'plan': {'id': 'p1', 'name': 'Club', 'kind': 'membership', 'priceCents': 99900, 'period': 'monthly'},
        }),
        const Reply(201, {
          'code': {'id': 'c1', 'code': 'SAVE50', 'kind': 'amount', 'amountCents': 5000, 'uses': 0, 'active': true},
        }),
      ]);
      final repo = RealGrowthRepository(client, ApiMode.real);

      final plan = await repo.createPlan(
        slug,
        const PlanInput(name: ' Club ', kind: PlanKind.membership, price: '999', discountPct: '15'),
      );
      expect(stub.requests.first.path, '/mobile/venues/$slug/membership-plans');
      expect(stub.requests.first.body, {'name': 'Club', 'kind': 'membership', 'price': 999.0, 'discountPct': 15});
      expect(plan.kind, PlanKind.membership);

      final code = await repo.createPromo(
        slug,
        const PromoInput(code: 'save50', kind: PromoKind.amount, value: '50', expiresAt: '2031-01-01'),
      );
      expect(stub.requests.last.body, {'code': 'save50', 'kind': 'amount', 'value': 50, 'expiresAt': '2031-01-01'});
      expect(code.amountCents, 5000);
    });

    test('a new API key comes back whole beside the refreshed list', () async {
      final (:client, stub: _) = stubbedClient([
        const Reply(201, {
          'key': 'rk_live_abcdefghijklmnop',
          'icalUrl': 'https://app.test/api/calendar/t',
          'apiKeys': [
            {'id': 'k1', 'name': 'Accounting', 'prefix': 'rk_live_abcdef', 'createdAt': '2026-09-27T00:00:00.000Z'},
          ],
        }),
      ]);
      final created = await RealGrowthRepository(client, ApiMode.real).createApiKey(slug, 'Accounting');
      expect(created.key, 'rk_live_abcdefghijklmnop');
      expect(created.integrations.apiKeys.single.prefix, 'rk_live_abcdef');
    });
  });
}
