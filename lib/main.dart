import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'app.dart';
import 'core/network/retry_policy.dart';
import 'core/storage/boot_data.dart';
import 'core/storage/prefs.dart';
import 'core/storage/secure_store.dart';
import 'core/time/app_time.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final boot = await _bootstrap();
  runApp(
    ProviderScope(
      retry: appRetryPolicy,
      overrides: [bootDataProvider.overrideWithValue(boot)],
      child: const ReservMeApp(),
    ),
  );
}

/// Work that must finish before the first frame: the timezone database, the
/// device zone, and the persisted session so the router never needs a splash
/// screen. Every read is defensive; a broken store reads as signed out.
///
/// Each platform call is also given a deadline. A channel that never answers
/// would otherwise hold the first frame forever and leave the launch screen
/// on display with no way out — which is exactly what
/// `flutter_secure_storage` does on Android after the app's data is cleared
/// while its keystore entry is being regenerated. A slow read is worth
/// waiting a moment for; a hung one is not worth the whole app.
Future<BootData> _bootstrap() async {
  AppTime.ensureInitialized();
  try {
    final zone = await FlutterTimezone.getLocalTimezone().timeout(_deadline);
    if (AppTime.isValidTimeZone(zone.identifier)) {
      AppTime.deviceZone = zone.identifier;
    }
  } catch (_) {
    // Keep the UTC fallback; the device zone only seeds the venue form.
  }
  try {
    return await BootData.load(SecureStore(), Prefs()).timeout(_deadline);
  } catch (_) {
    // Signed out, with everything else at its default. The session is read
    // again on the next launch.
    return BootData.empty;
  }
}

/// Long enough for a cold platform channel on a slow device, short enough
/// that nobody is left staring at a launch screen.
const _deadline = Duration(seconds: 5);
