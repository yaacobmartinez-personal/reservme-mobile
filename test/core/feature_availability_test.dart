import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/config/app_config.dart';
import 'package:reservme/core/config/feature_availability.dart';
import 'package:reservme/core/network/api_error.dart';

void main() {
  group('feature gating', () {
    test('fake mode has everything, because the fakes are the server', () {
      for (final feature in Feature.values) {
        expect(
          isAvailable(feature, ApiMode.fake),
          isTrue,
          reason: '${feature.name} should work in fake mode',
        );
      }
    });

    test('exactly the endpoints that exist are live', () {
      // Auth shipped 2026-09-25; the rest of the backend is still to come.
      // This list is the tripwire: flipping a flag without an endpoint behind
      // it fails here rather than on somebody's phone.
      const live = {
        Feature.venueLogin,
        Feature.deleteAccount,
        Feature.signup,
        Feature.onboarding,
        Feature.venueSettings,
        Feature.today,
        Feature.calendar,
        Feature.customers,
        Feature.venueWaitlist,
      };

      final shipped = {
        for (final feature in Feature.values)
          if (isAvailable(feature, ApiMode.real)) feature,
      };

      expect(
        shipped,
        live,
        reason: 'A flag moved. Anything claiming to be live needs its '
            'endpoints deployed and its Real* repository working against them.',
      );
    });

    test('the space editor stays shut while #29 is missing', () {
      // `Feature.spaces` gates every method on RealSpacesRepository, pricing
      // rules and closures included. Those are #29. Opening the editor would
      // put two refusing buttons on it — the same wall sign-up used to be.
      expect(isAvailable(Feature.spaces, ApiMode.real), isFalse);
    });

    test('onboarding now hands over to a working run sheet', () {
      // O7 sends the new owner to Today. Both ends of that handover are live.
      expect(isAvailable(Feature.onboarding, ApiMode.real), isTrue);
      expect(isAvailable(Feature.today, ApiMode.real), isTrue);
    });

    test('all four venue tabs are open', () {
      // Today, Calendar, Customers and the waitlist behind More: a venue can
      // run a whole day on the app without a web dashboard anywhere.
      for (final feature in [
        Feature.today,
        Feature.calendar,
        Feature.customers,
        Feature.venueWaitlist,
      ]) {
        expect(isAvailable(feature, ApiMode.real), isTrue, reason: feature.name);
      }
    });

    test('every feature has an explicit entry, not a default', () {
      // `isAvailable` falls back to false for a missing key, which would
      // silently gate a feature nobody meant to gate.
      for (final feature in Feature.values) {
        expect(
          () => isAvailable(feature, ApiMode.real),
          returnsNormally,
          reason: feature.name,
        );
      }
    });
  });

  group('the refusal a gated feature gives', () {
    test('is a 501 the UI can tell apart from a real failure', () {
      final error = ApiError.notAvailable();
      expect(error.status, 501);
      // Not a network error: retrying will not help, and the retry policy
      // must not treat it as transient.
      expect(error.isNetwork, isFalse);
      expect(error.message, isNotEmpty);
    });
  });
}
