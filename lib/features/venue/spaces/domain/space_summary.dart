import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';
import '../../../../core/model/opening_hours.dart';
import 'space_detail.dart';
import 'space_input.dart';

part 'space_summary.freezed.dart';
part 'space_summary.g.dart';

/// A row on V14 · Spaces (API-CONTRACT #24).
///
/// Active spaces set the venue's billing band, which is why the screen says
/// so: pausing one is a money decision as well as an availability one.
@freezed
abstract class SpaceSummary with _$SpaceSummary {
  const SpaceSummary._();

  const factory SpaceSummary({
    required String id,
    required String name,
    @Default(SpaceKind.court) SpaceKind kind,
    @Default(60) int slotMinutes,
    @Default(0) int priceCents,

    /// The highest price any rule charges, when it beats the base price.
    int? peakPriceCents,
    @Default(true) bool isActive,
    String? imageUrl,

    /// "open play Tue/Thu" — the sessions this space runs, if any.
    String? sessionSummary,
    @Default(0) int upcomingBookings,
  }) = _SpaceSummary;

  factory SpaceSummary.fromJson(Map<String, dynamic> json) =>
      _$SpaceSummaryFromJson(json);

  bool get hasPeak => peakPriceCents != null && peakPriceCents! > priceCents;
}

abstract class SpacesRepository {
  Future<List<SpaceSummary>> list(String venueSlug);

  /// Owner and admin only; a member gets a 403 with the server's wording.
  Future<SpaceSummary> setActive(String venueSlug, String spaceId, bool active);

  /// G1 · everything the editor shows for one space (contract #28).
  Future<SpaceDetail> detail(String venueSlug, String spaceId);

  Future<SpaceDetail> create(String venueSlug, SpaceInput input);

  Future<SpaceDetail> update(String venueSlug, String spaceId, SpaceInput input);

  /// Refused while the space still has bookings ahead of it — pausing is the
  /// reversible thing to do, and the screen offers that instead.
  Future<void> remove(String venueSlug, String spaceId);

  /// Replaces the whole week at once, like `setOpeningHours`: a closed day
  /// simply has no row.
  Future<SpaceDetail> setHours(String venueSlug, String spaceId, HoursInput hours);

  /// [image] is the bytes of an already-resized JPEG, or null to clear.
  Future<SpaceDetail> setImage(String venueSlug, String spaceId, List<int>? image);

  Future<SpaceDetail> addPricingRule(
    String venueSlug,
    String spaceId,
    PricingRuleInput input,
  );

  Future<SpaceDetail> removePricingRule(
    String venueSlug,
    String spaceId,
    String ruleId,
  );

  /// [spaceId] is the space whose editor is open — what to return. The
  /// closure's own scope comes from [ClosureInput.spaceId], which is null for
  /// a whole-venue shutdown.
  Future<SpaceDetail> addClosure(
    String venueSlug,
    String spaceId,
    ClosureInput input,
  );

  Future<SpaceDetail> removeClosure(
    String venueSlug,
    String spaceId,
    String closureId,
  );
}
