import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/domain/user.dart';
import '../../features/venue/venues/domain/venue_membership.dart';
import 'prefs.dart';
import 'secure_store.dart';

part 'boot_data.g.dart';

/// Everything persisted that the first frame needs, read once in `main()` so
/// auth state and app mode are known synchronously and the router never has
/// to show a splash screen.
class BootData {
  const BootData({
    this.token,
    this.user,
    this.venues = const [],
    this.appMode,
    this.selectedVenueSlug,
    this.appearance,
    this.welcomeSeen = false,
  });

  static const empty = BootData();

  final String? token;
  final User? user;
  final List<VenueMembership> venues;
  final String? appMode;
  final String? selectedVenueSlug;

  /// 'system' | 'light' | 'dark'; null = system.
  final String? appearance;

  /// The venue-owner welcome screen has been dismissed once.
  final bool welcomeSeen;

  static Future<BootData> load(SecureStore secure, Prefs prefs) async {
    final token = await secure.read(SecureStore.keyToken);
    final userJson = await secure.readJson(SecureStore.keyUser);
    final venuesJson = await secure.readJsonList(SecureStore.keyVenues);

    User? user;
    try {
      if (userJson != null) user = User.fromJson(userJson);
    } catch (_) {
      user = null;
    }

    var venues = const <VenueMembership>[];
    try {
      if (venuesJson != null) {
        venues = venuesJson
            .whereType<Map<String, dynamic>>()
            .map(VenueMembership.fromJson)
            .toList(growable: false);
      }
    } catch (_) {
      venues = const [];
    }

    return BootData(
      token: token,
      user: user,
      venues: venues,
      appMode: await prefs.getString(Prefs.keyAppMode),
      selectedVenueSlug: await prefs.getString(Prefs.keySelectedVenue),
      appearance: await prefs.getString(Prefs.keyAppearance),
      welcomeSeen: (await prefs.getString(Prefs.keyWelcomeSeen)) == 'true',
    );
  }
}

/// Overridden in `main()` with the loaded snapshot; tests override it with
/// whatever starting state they need.
@Riverpod(keepAlive: true)
BootData bootData(Ref ref) => BootData.empty;
