import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

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
}
