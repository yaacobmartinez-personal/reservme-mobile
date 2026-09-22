import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/config/api_mode.dart';
import 'package:reservme/core/config/app_config.dart';
import 'package:reservme/core/connectivity/connectivity_provider.dart';
import 'package:reservme/core/fake/fake_latency.dart';
import 'package:reservme/core/fake/fake_providers.dart';
import 'package:reservme/core/fake/fake_store.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/retry_policy.dart';
import 'package:reservme/core/storage/boot_data.dart';
import 'package:reservme/core/storage/local_store.dart';
import 'package:reservme/core/storage/prefs.dart';
import 'package:reservme/core/storage/secure_store.dart';
import 'package:reservme/core/theme/motion.dart';
import 'package:reservme/core/time/app_time.dart';
import 'package:reservme/core/time/clock.dart';

import 'memory_local_store.dart';

/// Secure storage that never touches the platform.
class InMemorySecureStore extends SecureStore {
  final values = <String, String>{};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String? value) async {
    if (value == null) {
      values.remove(key);
    } else {
      values[key] = value;
    }
  }
}

class InMemoryPrefs extends Prefs {
  final values = <String, Object>{};

  @override
  Future<String?> getString(String key) async => values[key] as String?;

  @override
  Future<void> setString(String key, String? value) async {
    if (value == null) {
      values.remove(key);
    } else {
      values[key] = value;
    }
  }

  @override
  Future<List<String>> getStringList(String key) async =>
      (values[key] as List<String>?) ?? const [];

  @override
  Future<void> setStringList(String key, List<String> value) async {
    values[key] = value;
  }
}

/// A fixed "now" for deterministic seeds and expiries: Saturday 26 September
/// 2026, 10:00 in Manila (02:00 UTC) — the day the design canvas shows.
final testNow = DateTime.utc(2026, 9, 26, 2);

/// The standard test world: fake API mode, zero latency, a freshly seeded
/// store, in-memory storage, and a pinned clock.
class TestWorld {
  TestWorld({
    BootData boot = const BootData(welcomeSeen: true),
    DateTime? now,
    bool online = true,
    FakeLatency latency = FakeLatency.none,
    this.apiMode = ApiMode.fake,
  })  : now = now ?? testNow,
        secure = InMemorySecureStore(),
        prefs = InMemoryPrefs(),
        store = FakeStore(),
        local = MemoryLocalStore(),
        connectivity = StreamController<bool>.broadcast() {
    TestWidgetsFlutterBinding.ensureInitialized();
    AppTime.ensureInitialized();
    seedFakeStore(store, this.now);
    _online = online;
    overrides = [
      connectivityProvider.overrideWith((ref) async* {
        yield _online;
        yield* connectivity.stream;
      }),
      apiModeProvider.overrideWithValue(apiMode),
      clockProvider.overrideWithValue(() => this.now),
      fakeLatencyProvider.overrideWithValue(latency),
      fakeStoreProvider.overrideWithValue(store),
      localStoreProvider.overrideWithValue(local),
      secureStoreProvider.overrideWithValue(secure),
      prefsProvider.overrideWithValue(prefs),
      bootDataProvider.overrideWithValue(boot),
      // Looping animations would keep pumpAndSettle waiting forever.
      motionSettingsProvider.overrideWith(ReducedMotion.new),
    ];
  }

  final DateTime now;

  /// Real mode here still uses the fakes (every repository is overridden);
  /// it only changes what the feature gates and UI think the mode is.
  final ApiMode apiMode;
  final InMemorySecureStore secure;
  final InMemoryPrefs prefs;
  final FakeStore store;

  /// The phone's wallet and recents, in memory — no SQLite in tests.
  final MemoryLocalStore local;

  /// Push true/false to simulate the network coming and going.
  final StreamController<bool> connectivity;
  bool _online = true;
  late final List<Override> overrides;

  void setOnline(bool value) {
    _online = value;
    connectivity.add(value);
  }

  ProviderContainer container() {
    final c = ProviderContainer(overrides: overrides, retry: appRetryPolicy);
    addTearDown(() async {
      c.dispose();
      await connectivity.close();
      await local.dispose();
    });
    return c;
  }
}

/// Reduced motion for tests: no loops, no decorative animation.
class ReducedMotion extends MotionSettings {
  @override
  bool build() => false;
}
