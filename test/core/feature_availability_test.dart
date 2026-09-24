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

    test('nothing has shipped on the real server yet', () {
      // The backend is a separate plan. When an endpoint lands, flip its
      // entry in `_shippedOnRealServer` and this test tells you which.
      final shipped = [
        for (final feature in Feature.values)
          if (isAvailable(feature, ApiMode.real)) feature.name,
      ];
      expect(
        shipped,
        isEmpty,
        reason: 'These claim to be live on the real server: $shipped. If that '
            'is true, the matching Real* repository has to work against it.',
      );
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
