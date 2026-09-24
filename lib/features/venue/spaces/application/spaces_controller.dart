import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../venue_providers.dart';
import '../domain/space_summary.dart';

part 'spaces_controller.g.dart';

/// V14 · Spaces. The toggle takes a space off sale immediately, which also
/// changes the venue's billing band — so it is owner/admin only, and the
/// repository refuses rather than the button hiding the truth.
@riverpod
class Spaces extends _$Spaces {
  @override
  Future<List<SpaceSummary>> build(String venueSlug) =>
      ref.watch(spacesRepositoryProvider).list(venueSlug);

  Future<void> setActive(String spaceId, bool active) async {
    final updated =
        await ref.read(spacesRepositoryProvider).setActive(venueSlug, spaceId, active);
    final current = state.value;
    if (current != null) {
      state = AsyncData([
        for (final s in current) if (s.id == updated.id) updated else s,
      ]);
    }
  }
}
