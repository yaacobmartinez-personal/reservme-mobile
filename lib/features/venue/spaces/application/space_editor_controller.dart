import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/model/opening_hours.dart';
import '../../venue_providers.dart';
import '../domain/space_detail.dart';
import '../domain/space_input.dart';
import '../domain/space_summary.dart';

part 'space_editor_controller.g.dart';

/// G1 · the space editor. Every write returns the whole space, so the screen
/// never has to guess what a save did to the rest of it — adding a peak rule
/// changes the headline price, and closing a day can make the space
/// unbookable.
@riverpod
class SpaceEditor extends _$SpaceEditor {
  @override
  Future<SpaceDetail> build(String venueSlug, String spaceId) =>
      ref.watch(spacesRepositoryProvider).detail(venueSlug, spaceId);

  Future<void> _apply(Future<SpaceDetail> write) async {
    state = AsyncData(await write);
  }

  Future<void> saveBasics(SpaceInput input) =>
      _apply(_repo.update(venueSlug, spaceId, input));

  Future<void> saveHours(HoursInput hours) =>
      _apply(_repo.setHours(venueSlug, spaceId, hours));

  Future<void> setPhoto(List<int>? bytes) =>
      _apply(_repo.setImage(venueSlug, spaceId, bytes));

  Future<void> addPricingRule(PricingRuleInput input) =>
      _apply(_repo.addPricingRule(venueSlug, spaceId, input));

  Future<void> removePricingRule(String ruleId) =>
      _apply(_repo.removePricingRule(venueSlug, spaceId, ruleId));

  Future<void> addClosure(ClosureInput input) =>
      _apply(_repo.addClosure(venueSlug, spaceId, input));

  Future<void> removeClosure(String closureId) =>
      _apply(_repo.removeClosure(venueSlug, spaceId, closureId));

  /// Pausing is what the screen offers when a delete is refused, so it lives
  /// here too rather than making the editor reach for the list controller.
  Future<void> setActive(bool active) async {
    await _repo.setActive(venueSlug, spaceId, active);
    ref.invalidateSelf();
    await future;
  }

  Future<void> delete() => _repo.remove(venueSlug, spaceId);

  SpacesRepository get _repo => ref.read(spacesRepositoryProvider);
}
