import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/customer/venues/application/venue_controller.dart';
import 'package:reservme/features/venue/settings/application/venue_settings_controller.dart';
import 'package:reservme/features/venue/settings/domain/venue_settings.dart';

import '../helpers/fakes.dart';

void main() {
  const slug = FakeVenues.katipunan;

  Future<void> signIn(ProviderContainer container, String email) => container
      .read(authControllerProvider.notifier)
      .signIn(email: email, password: FakeAccounts.password);

  VenueSettingsInput input({
    String name = 'Katipunan Courts',
    String timezone = 'Asia/Manila',
    String currency = 'PHP',
    int notice = 60,
    int horizon = 60,
    int grace = 24,
    String tagline = '',
    String refundTerms = '',
  }) =>
      VenueSettingsInput(
        name: name,
        timezone: timezone,
        currency: currency,
        minNoticeMinutes: notice,
        maxHorizonDays: horizon,
        cancellationGraceHours: grace,
        tagline: tagline,
        refundTerms: refundTerms,
      );

  group('settings input', () {
    test('every bound is the schema\'s', () {
      expect(input().validate(), isNull);
      expect(input(name: '  ').validate(), 'Your venue needs a name.');
      expect(input(currency: 'PESO').validate(),
          'Use a three-letter currency code.');
      expect(input(notice: 30000).validate(),
          'Notice is between none and two weeks.');
      expect(input(horizon: 0).validate(),
          'Bookings open between 1 and 365 days ahead.');
      expect(input(grace: 800).validate(),
          'A grace window is between 0 and 720 hours.');
      expect(input(tagline: 'x' * 201).validate(), 'Keep the tagline short.');
      expect(
        input(refundTerms: 'x' * 1001).validate(),
        'Keep the refund terms short.',
      );
    });

    test('an empty optional goes over the wire as nothing, not as blank', () {
      final json = input(tagline: '   ').toJson();
      expect(json['tagline'], isNull);
      expect(json['refundTerms'], isNull);
      expect(json['currency'], 'PHP');
    });
  });

  group('the settings screen', () {
    test('loads the venue with its policy and booking address', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final venue =
          await container.read(venueSettingsControllerProvider(slug).future);

      expect(venue.slug, slug);
      expect(venue.bookingUrl, endsWith('/$slug'));
      expect(venue.timezone, 'Asia/Manila');
    });

    test('saving writes the whole form at once', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final notifier =
          container.read(venueSettingsControllerProvider(slug).notifier);
      await container.read(venueSettingsControllerProvider(slug).future);

      await notifier.save(input(
        name: 'Katipunan Sports',
        tagline: 'Four covered courts',
        notice: 120,
        horizon: 30,
        grace: 48,
      ).copyWith(cancellationMode: CancellationMode.grace));

      final after = container.read(venueSettingsControllerProvider(slug)).value!;
      expect(after.name, 'Katipunan Sports');
      expect(after.tagline, 'Four covered courts');
      expect(after.minNoticeMinutes, 120);
      expect(after.maxHorizonDays, 30);
      expect(after.cancellationGraceHours, 48);
    });

    test('a timezone the app cannot resolve is refused', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      await container.read(venueSettingsControllerProvider(slug).future);

      await expectLater(
        container
            .read(venueSettingsControllerProvider(slug).notifier)
            .save(input(timezone: 'Mars/Olympus')),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 400)),
      );
    });

    test('front desk cannot change the venue', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.staffEmail);
      // Reading is fine — staff see the policy they have to explain.
      await container.read(venueSettingsControllerProvider(slug).future);

      await expectLater(
        container
            .read(venueSettingsControllerProvider(slug).notifier)
            .save(input(name: 'Nope')),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 403)),
      );
    });

    test('the policy the owner saves is the one customers are held to',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      await container.read(venueSettingsControllerProvider(slug).future);

      await container
          .read(venueSettingsControllerProvider(slug).notifier)
          .save(input(horizon: 7).copyWith(
            cancellationMode: CancellationMode.never,
          ));

      // The public venue page reads the same row.
      final public = await container.read(venueProvider(slug).future);
      expect(public.maxHorizonDays, 7);
      expect(public.cancellationMode, CancellationMode.never);
    });
  });
}
