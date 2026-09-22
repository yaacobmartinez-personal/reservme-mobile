import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

part 'public_venue.freezed.dart';
part 'public_venue.g.dart';

/// A bookable space on a venue's public page (`GET /public/venues/{slug}`,
/// API-CONTRACT #1). Mirrors the web `VenueSpace`.
@freezed
abstract class VenueSpace with _$VenueSpace {
  const VenueSpace._();

  const factory VenueSpace({
    required String id,
    required String name,
    required String slug,
    @Default(SpaceKind.other) SpaceKind kind,
    @Default(1) int capacity,
    @Default(60) int slotMinutes,
    @Default(0) int bufferMinutes,
    required int priceCents,
    @Default(true) bool isActive,
    @Default(0) int sortOrder,
    String? imageUrl,

    /// Cheapest peak price, when the space has pricing rules.
    int? peakPriceCents,

    /// Open slots left today, for the "6 open today" chip. Null = unknown.
    int? openToday,
  }) = _VenueSpace;

  factory VenueSpace.fromJson(Map<String, dynamic> json) => _$VenueSpaceFromJson(json);

  bool get hasPhoto => imageUrl != null && imageUrl!.isNotEmpty;

  /// "60-min slots · up to 4 players"
  String get summary {
    final slot = '$slotMinutes-min slots';
    if (capacity <= 1) return slot;
    return '$slot · up to $capacity ${capacity == 1 ? 'person' : 'people'}';
  }
}

/// The public face of a venue. Everything a customer sees before booking.
@freezed
abstract class PublicVenue with _$PublicVenue {
  const PublicVenue._();

  const factory PublicVenue({
    required String id,
    required String slug,
    required String name,
    String? tagline,
    String? address,
    @Default('Asia/Manila') String timezone,
    @Default('PHP') String currency,
    @Default(VenueTheme.pine) VenueTheme theme,
    String? logoUrl,
    String? coverUrl,
    @Default(60) int minNoticeMinutes,
    @Default(60) int maxHorizonDays,
    @Default(CancellationMode.anytime) CancellationMode cancellationMode,
    @Default(24) int cancellationGraceHours,
    String? refundTerms,
    String? gcashName,
    @Default(false) bool suspended,
    @Default([]) List<VenueSpace> spaces,
  }) = _PublicVenue;

  factory PublicVenue.fromJson(Map<String, dynamic> json) => _$PublicVenueFromJson(json);

  /// How the cancellation policy reads on the venue page.
  String get policyLine => switch (cancellationMode) {
        CancellationMode.anytime => 'Free cancellation any time before the booking',
        CancellationMode.grace =>
          'Free cancellation up to $cancellationGraceHours hours before',
        CancellationMode.never => 'Cancellations are handled by the venue',
      };
}
