import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/onboarding/application/onboarding_controller.dart';
import 'package:reservme/features/onboarding/domain/onboarding_input.dart';
import 'package:reservme/features/venue/venues/application/selected_venue_controller.dart';

import '../helpers/fakes.dart';

void main() {
  const signup = SignupInput(
    name: 'Rafael Katipunan',
    email: 'rafael@katipunancourts.ph',
    password: 'a-good-long-password',
    acceptedTerms: true,
  );

  group('signup input', () {
    test('needs a name, a real email, ten characters and the terms', () {
      expect(signup.validate(), isNull);
      expect(
        SignupInput(name: ' ', email: signup.email, password: signup.password, acceptedTerms: true)
            .validate(),
        'What should we call you?',
      );
      expect(
        SignupInput(name: 'A', email: 'nope', password: signup.password, acceptedTerms: true)
            .validate(),
        "That email doesn't look right.",
      );
      expect(
        SignupInput(name: 'A', email: signup.email, password: 'short', acceptedTerms: true)
            .validate(),
        'Use at least 10 characters.',
      );
      expect(
        SignupInput(name: 'A', email: signup.email, password: signup.password)
            .validate(),
        'Please accept the terms to continue.',
      );
    });
  });

  group('venue input', () {
    test('slugify matches the web', () {
      expect(VenueInput.slugify('Katipunan Courts'), 'katipunan-courts');
      expect(VenueInput.slugify('Court 2 · Panoramic'), 'court-2-panoramic');
      expect(VenueInput.slugify('  --Hello--  '), 'hello');
      // An unusable name still produces something rather than an empty slug.
      expect(VenueInput.slugify('!!!'), startsWith('venue-'));
    });

    VenueInput venue(String slug) => VenueInput(
          name: 'Katipunan Courts',
          slug: slug,
          timezone: 'Asia/Manila',
          currency: 'PHP',
        );

    test('a reserved address is refused, because the apex owns it', () {
      expect(venue('privacy').validate(), 'That address is taken by ReservMe itself.');
      expect(venue('admin').validate(), isNotNull);
      expect(venue('katipunan').validate(), isNull);
    });

    test('the address is letters, numbers and dashes', () {
      expect(venue('katipunan-courts').validate(), isNull);
      expect(venue('Katipunan').validate(), 'Letters, numbers and dashes only.');
      expect(venue('kati punan').validate(), isNotNull);
      expect(venue('-katipunan').validate(), isNotNull);
      expect(venue('katipunan-').validate(), isNotNull);
      expect(venue('').validate(), 'Pick a booking-page address.');
    });
  });

  group('hours input', () {
    test('a week with nothing open is refused', () {
      final closed = HoursInput([
        for (var d = 0; d < 7; d++) DayHours(weekday: d, open: false),
      ]);
      expect(closed.validate(), 'Open on at least one day, or nobody can book.');
    });

    test('a day that closes before it opens is refused by name', () {
      final bad = HoursInput.initial().replacing(
        const DayHours(weekday: 1, open: true, opensAt: '22:00', closesAt: '09:00'),
      );
      expect(bad.validate(), 'Mon closes before it opens.');
    });

    test('copy and same-every-day do what they say', () {
      var hours = HoursInput.initial().replacing(
        const DayHours(weekday: 1, open: true, opensAt: '07:00', closesAt: '21:00'),
      );

      final copied = hours.copyFrom(1);
      expect(copied.days.every((d) => d.opensAt == '07:00'), isTrue);
      // Copying a window keeps which days are open - Sunday stays closed.
      expect(copied.days.firstWhere((d) => d.weekday == 0).open, isFalse);

      hours = hours.everyDay(1);
      expect(hours.days.every((d) => d.open), isTrue);
      expect(hours.days.every((d) => d.closesAt == '21:00'), isTrue);
    });

    test('the week reads Monday first but stores Sunday as zero', () {
      final order = HoursInput.initial().weekOrder.map((d) => d.weekday).toList();
      expect(order, [1, 2, 3, 4, 5, 6, 0]);
    });
  });

  group('the flow', () {
    test('signs up, creates a venue, a space, hours and goes live', () async {
      final world = TestWorld();
      final container = world.container();
      final onboarding = container.read(onboardingProvider.notifier);

      await onboarding.signUp(signup);
      expect(container.read(authControllerProvider).isSignedIn, isTrue);
      expect(container.read(onboardingProvider).step, OnboardingStep.verify);

      // The code is whatever the fake "emailed".
      final code = world.store.emailCodes[signup.email]!;
      await onboarding.verify(code);
      expect(container.read(onboardingProvider).emailVerified, isTrue);
      expect(container.read(onboardingProvider).step, OnboardingStep.venue);

      await onboarding.createVenue(const VenueInput(
        name: 'Rafael Courts',
        slug: 'rafael-courts',
        timezone: 'Asia/Manila',
        currency: 'PHP',
      ));
      final draft = container.read(onboardingProvider);
      expect(draft.step, OnboardingStep.space);
      expect(draft.venueSlug, 'rafael-courts');
      // The new venue is selected, so the shell opens on it.
      expect(container.read(selectedVenueSlugProvider), 'rafael-courts');
      expect(container.read(authControllerProvider).hasVenueAccess, isTrue);

      await onboarding.createSpace(const FirstSpaceInput(
        name: 'Court 1',
        kind: SpaceKind.court,
        priceCents: 35000,
      ));
      expect(container.read(onboardingProvider).step, OnboardingStep.hours);

      await onboarding.setHours(HoursInput.initial());
      expect(container.read(onboardingProvider).step, OnboardingStep.policy);

      final live = await onboarding.goLive(const PolicyInput());
      expect(live.bookingUrl, endsWith('/rafael-courts'));
      expect(live.spaceName, 'Court 1');
      expect(container.read(onboardingProvider).step, OnboardingStep.live);
    });

    test('a new space is bookable: hours are seeded, then replaced', () async {
      final world = TestWorld();
      final container = world.container();
      final onboarding = container.read(onboardingProvider.notifier);
      await onboarding.signUp(signup);
      await onboarding.skipVerification();
      await onboarding.createVenue(const VenueInput(
        name: 'Rafael Courts',
        slug: 'rafael-courts',
        timezone: 'Asia/Manila',
        currency: 'PHP',
      ));
      await onboarding.createSpace(const FirstSpaceInput(name: 'Court 1'));

      final spaceId = container.read(onboardingProvider).spaceId!;
      // createSpace seeds all seven days, like the web does.
      expect(world.store.hoursOf(spaceId), hasLength(7));

      // O5 replaces them wholesale: a closed day simply has no row.
      await onboarding.setHours(HoursInput.initial());
      final rows = world.store.hoursOf(spaceId).toList();
      expect(rows, hasLength(6));
      expect(rows.where((h) => h.weekday == 0), isEmpty);
    });

    test('an email that already exists is refused', () async {
      final world = TestWorld();
      final container = world.container();

      await expectLater(
        container.read(onboardingProvider.notifier).signUp(
              const SignupInput(
                name: 'Impostor',
                email: FakeAccounts.ownerEmail,
                password: 'a-good-long-password',
                acceptedTerms: true,
              ),
            ),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 409)),
      );
    });

    test('a wrong code is refused, and the right one still works', () async {
      final world = TestWorld();
      final container = world.container();
      final onboarding = container.read(onboardingProvider.notifier);
      await onboarding.signUp(signup);

      await expectLater(
        onboarding.verify('000000'),
        throwsA(isA<ApiError>()),
      );
      expect(container.read(onboardingProvider).step, OnboardingStep.verify);

      await onboarding.verify(world.store.emailCodes[signup.email]!);
      expect(container.read(onboardingProvider).step, OnboardingStep.venue);
    });

    test('skipping verification moves on without verifying', () async {
      final world = TestWorld();
      final container = world.container();
      final onboarding = container.read(onboardingProvider.notifier);
      await onboarding.signUp(signup);

      await onboarding.skipVerification();

      expect(container.read(onboardingProvider).step, OnboardingStep.venue);
      expect(container.read(onboardingProvider).emailVerified, isFalse);
      expect(world.store.userByEmail(signup.email)!.emailVerified, isFalse);
    });

    test('a taken address is refused before and during creation', () async {
      final world = TestWorld();
      final container = world.container();
      final onboarding = container.read(onboardingProvider.notifier);
      await onboarding.signUp(signup);
      await onboarding.skipVerification();

      final taken = await onboarding.checkSlug(FakeVenues.katipunan);
      expect(taken.available, isFalse);
      expect(taken.reason, 'Another venue has that address.');

      final free = await onboarding.checkSlug('somewhere-new');
      expect(free.available, isTrue);

      await expectLater(
        onboarding.createVenue(const VenueInput(
          name: 'Clash',
          slug: FakeVenues.katipunan,
          timezone: 'Asia/Manila',
          currency: 'PHP',
        )),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 409)),
      );
    });

    test('a reserved address never even reaches the server', () async {
      final world = TestWorld();
      final container = world.container();
      final onboarding = container.read(onboardingProvider.notifier);
      await onboarding.signUp(signup);

      final check = await onboarding.checkSlug('privacy');
      expect(check.available, isFalse);
      expect(check.reason, contains('ReservMe itself'));
    });
  });

  group('resuming', () {
    test('an interrupted flow comes back at the step it reached', () async {
      final world = TestWorld();
      final container = world.container();
      final onboarding = container.read(onboardingProvider.notifier);
      await onboarding.signUp(signup);
      await onboarding.skipVerification();
      await onboarding.createVenue(const VenueInput(
        name: 'Rafael Courts',
        slug: 'rafael-courts',
        timezone: 'Asia/Manila',
        currency: 'PHP',
      ));

      // Relaunching re-reads the session and the draft from storage.
      final next = await world.relaunch();
      final resumed = await next.read(onboardingProvider.notifier).resume();

      expect(resumed, OnboardingStep.space);
      expect(next.read(onboardingProvider).venueSlug, 'rafael-courts');
    });

    test('there is nothing to resume once the flow finishes', () async {
      final world = TestWorld();
      final container = world.container();
      final onboarding = container.read(onboardingProvider.notifier);
      await onboarding.signUp(signup);
      await onboarding.finish();

      expect(await container.read(onboardingProvider.notifier).resume(), isNull);
    });

    test('a draft whose account is gone is dropped, not resumed', () async {
      final world = TestWorld();
      final container = world.container();
      await container.read(onboardingProvider.notifier).signUp(signup);
      await container.read(authControllerProvider.notifier).signOut();

      final next = await world.relaunch();
      expect(await next.read(onboardingProvider.notifier).resume(), isNull);
    });
  });
}
