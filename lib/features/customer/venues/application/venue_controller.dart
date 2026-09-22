import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/local_store.dart';
import '../../../../core/time/clock.dart';
import '../../customer_providers.dart';
import '../domain/public_venue.dart';
import '../domain/recent_venue.dart';

part 'venue_controller.g.dart';

/// The public venue page. Opening one records it in Recent venues, which is
/// the only "history" a customer has on the Find screen.
@riverpod
Future<PublicVenue> venue(Ref ref, String slug) async {
  final venue = await ref.watch(venuesRepositoryProvider).bySlug(slug);
  await ref.read(localStoreProvider).touchVenue(
        RecentVenue(
          slug: venue.slug,
          name: venue.name,
          theme: venue.theme,
          tagline: venue.tagline,
          coverUrl: venue.coverUrl,
          openedAt: ref.read(clockProvider)(),
        ),
      );
  return venue;
}

/// Venues this phone has opened, newest first.
@riverpod
Stream<List<RecentVenue>> recentVenues(Ref ref) =>
    ref.watch(localStoreProvider).watchRecentVenues();

/// Validates a typed venue code before we bother the server, using the same
/// slug rules as the web (`src/lib/slug.ts`).
abstract final class VenueCode {
  static final _slug = RegExp(r'^[a-z0-9](?:[a-z0-9-]{0,62}[a-z0-9])?$');

  /// Accepts a bare code, or a pasted `reservme.pro/<slug>` URL.
  static String? normalize(String input) {
    var value = input.trim().toLowerCase();
    if (value.isEmpty) return null;
    if (value.contains('/')) {
      final uri = Uri.tryParse(value.startsWith('http') ? value : 'https://$value');
      final segments = uri?.pathSegments.where((s) => s.isNotEmpty).toList() ?? const [];
      if (segments.isEmpty) return null;
      value = segments.first;
    }
    return _slug.hasMatch(value) ? value : null;
  }
}
