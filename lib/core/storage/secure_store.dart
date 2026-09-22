import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_store.g.dart';

/// Secrets and personal data: the bearer token, the cached user and org list,
/// the server address, and the cached venue list. Keys are
/// namespaced `reservme.*`.
///
/// Every read is wrapped: on Android a key-store reset or a restore from
/// backup can make the store empty or throw, and that must read as
/// "signed out", never as a crash.
class SecureStore {
  SecureStore([FlutterSecureStorage? storage])
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock_this_device,
              ),
            );

  final FlutterSecureStorage _storage;

  static const keyToken = 'reservme.token';
  static const keyUser = 'reservme.user';
  static const keyVenues = 'reservme.venues';

  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (_) {
      return null;
    }
  }

  Future<void> write(String key, String? value) async {
    try {
      if (value == null) {
        await _storage.delete(key: key);
      } else {
        await _storage.write(key: key, value: value);
      }
    } catch (_) {
      // Best effort: a failed write means the next launch asks to sign in.
    }
  }

  Future<Map<String, dynamic>?> readJson(String key) async {
    final raw = await read(key);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  Future<List<dynamic>?> readJsonList(String key) async {
    final raw = await read(key);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw);
      return decoded is List ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  Future<void> writeJson(String key, Object? value) =>
      write(key, value == null ? null : jsonEncode(value));

  /// Everything tied to a session. The server address is kept.
  Future<void> clearSession() async {
    await write(keyToken, null);
    await write(keyUser, null);
    await write(keyVenues, null);
  }
}

@Riverpod(keepAlive: true)
SecureStore secureStore(Ref ref) => SecureStore();
