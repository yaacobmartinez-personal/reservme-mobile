import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/boot_data.dart';
import '../../../../core/storage/prefs.dart';
import '../../../auth/application/auth_controller.dart';
import '../domain/venue_membership.dart';

part 'selected_venue_controller.g.dart';

/// Which of the user's venues the venue shell is showing. Persisted by slug.
/// A slug that no longer appears in the memberships reads as "none", and a
/// single membership selects itself, so the picker only appears when there
/// is a real choice.
@Riverpod(keepAlive: true)
class SelectedVenueSlug extends _$SelectedVenueSlug {
  @override
  String? build() {
    final venues = ref.watch(authControllerProvider).venuesOrEmpty;
    final persisted = ref.watch(bootDataProvider).selectedVenueSlug;
    if (persisted != null && venues.any((v) => v.slug == persisted)) return persisted;
    if (venues.length == 1) return venues.single.slug;
    return null;
  }

  void set(String? slug) {
    state = slug;
    ref.read(prefsProvider).setString(Prefs.keySelectedVenue, slug);
  }
}

/// The selected membership, or null when nothing is selected.
@riverpod
VenueMembership? selectedVenue(Ref ref) {
  final slug = ref.watch(selectedVenueSlugProvider);
  if (slug == null) return null;
  return ref
      .watch(authControllerProvider)
      .venuesOrEmpty
      .where((v) => v.slug == slug)
      .firstOrNull;
}
