import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../venue_providers.dart';
import '../domain/venue_settings.dart';

part 'venue_settings_controller.g.dart';

/// G2 · Venue settings. One save for the whole form, because that is what
/// `updateVenueSettings` is: a single transaction over the organization and
/// the venue rows.
@riverpod
class VenueSettingsController extends _$VenueSettingsController {
  @override
  Future<VenueSettings> build(String venueSlug) =>
      ref.watch(settingsRepositoryProvider).get(venueSlug);

  Future<void> save(VenueSettingsInput input) async {
    state = AsyncData(
      await ref.read(settingsRepositoryProvider).update(venueSlug, input),
    );
  }

  Future<void> setBranding(BrandingSlot slot, List<int>? image) async {
    state = AsyncData(
      await ref
          .read(settingsRepositoryProvider)
          .setBranding(venueSlug, slot, image),
    );
  }
}
