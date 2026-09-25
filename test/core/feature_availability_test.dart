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
      const live = {Feature.venueLogin, Feature.deleteAccount};

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

    test('sign-up stays shut until a new owner can create a venue', () {
      // #25 and #26 are live, but sign-up leads into "name your venue" (#27),
      // which is not. Opening the door without the room behind it walks a new
      // owner into a wall on the third screen.
      expect(isAvailable(Feature.signup, ApiMode.real), isFalse);
      expect(isAvailable(Feature.onboarding, ApiMode.real), isFalse);
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
