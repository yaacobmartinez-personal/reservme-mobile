/// Build-time configuration, supplied with `--dart-define`.
///
/// `API_MODE` picks the data layer:
///  - `fake`: every repository is an in-memory fake seeded from `core/fake/seed.dart`.
///    This is the development default so the whole app can be exercised before
///    the backend has every endpoint.
///  - `real`: every repository talks to the ReservMe API over HTTPS. Endpoints
///    the server does not have yet are hidden by `Feature` gates.
enum ApiMode {
  real,
  fake;

  static ApiMode parse(String raw) => switch (raw.trim().toLowerCase()) {
        'real' => ApiMode.real,
        'fake' || '' => ApiMode.fake,
        final other => throw ArgumentError.value(
            other,
            'API_MODE',
            'Expected "real" or "fake".',
          ),
      };
}

abstract final class AppConfig {
  static const String _apiModeRaw =
      String.fromEnvironment('API_MODE', defaultValue: 'fake');

  static final ApiMode apiMode = ApiMode.parse(_apiModeRaw);

  /// The API host. The app host serves `/api/*`; the apex (`reservme.pro`)
  /// 404s it. `--dart-define=SERVER_URL=http://10.0.2.2:3000` for a laptop
  /// backend from the Android emulator.
  static const String defaultServerUrl = String.fromEnvironment(
    'SERVER_URL',
    defaultValue: 'https://app.reservme.pro',
  );

  /// Where public booking pages live: `https://reservme.pro/<venue>`. Also the
  /// host of manage links (`/<venue>/manage/<token>`) and the QR posters.
  static const String publicOrigin = String.fromEnvironment(
    'PUBLIC_ORIGIN',
    defaultValue: 'https://reservme.pro',
  );

  /// The (parked) web dashboard host. Only used for legal pages.
  static const String appOrigin = String.fromEnvironment(
    'APP_ORIGIN',
    defaultValue: 'https://app.reservme.pro',
  );

  /// Custom URL scheme used as the deep-link fallback before App Links /
  /// Universal Links are verified.
  static const String customScheme = 'reservme';

  static const String appName = 'ReservMe';

  /// Reported in the X-Client header. Keep in step with pubspec.yaml.
  static const String appVersion = '0.1.0';

  /// Venue defaults that mirror the web schema (`venue` table).
  static const String defaultTimezone = 'Asia/Manila';
  static const String defaultCurrency = 'PHP';
}
