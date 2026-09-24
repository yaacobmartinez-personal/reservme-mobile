import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/model/enums.dart';

part 'venue_settings.freezed.dart';
part 'venue_settings.g.dart';

/// G2 · everything `updateVenueSettings` can change, plus the read-only facts
/// the screen needs around it (API-CONTRACT #30).
@freezed
abstract class VenueSettings with _$VenueSettings {
  const VenueSettings._();

  const factory VenueSettings({
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
    @Default(CancellationMode.grace) CancellationMode cancellationMode,
    @Default(24) int cancellationGraceHours,
    String? refundTerms,
    String? gcashName,
    @Default(false) bool suspended,
    String? suspendedReason,
  }) = _VenueSettings;

  factory VenueSettings.fromJson(Map<String, dynamic> json) =>
      _$VenueSettingsFromJson(json);

  /// What a customer types, or scans, to reach the booking page.
  String get bookingUrl => '${AppConfig.publicOrigin}/$slug';
}

/// The half of the settings form that `updateVenueSettings` validates. Every
/// bound is the web's; the copy is ours.
class VenueSettingsInput {
  const VenueSettingsInput({
    required this.name,
    this.tagline = '',
    this.address = '',
    required this.timezone,
    required this.currency,
    this.theme = VenueTheme.pine,
    this.minNoticeMinutes = 60,
    this.maxHorizonDays = 60,
    this.cancellationMode = CancellationMode.grace,
    this.cancellationGraceHours = 24,
    this.refundTerms = '',
    this.gcashName = '',
  });

  factory VenueSettingsInput.from(VenueSettings v) => VenueSettingsInput(
        name: v.name,
        tagline: v.tagline ?? '',
        address: v.address ?? '',
        timezone: v.timezone,
        currency: v.currency,
        theme: v.theme,
        minNoticeMinutes: v.minNoticeMinutes,
        maxHorizonDays: v.maxHorizonDays,
        cancellationMode: v.cancellationMode,
        cancellationGraceHours: v.cancellationGraceHours,
        refundTerms: v.refundTerms ?? '',
        gcashName: v.gcashName ?? '',
      );

  final String name;
  final String tagline;
  final String address;
  final String timezone;
  final String currency;
  final VenueTheme theme;
  final int minNoticeMinutes;
  final int maxHorizonDays;
  final CancellationMode cancellationMode;
  final int cancellationGraceHours;
  final String refundTerms;
  final String gcashName;

  String? validate() {
    if (name.trim().isEmpty) return 'Your venue needs a name.';
    if (name.trim().length > 120) return 'That name is too long.';
    if (tagline.trim().length > 200) return 'Keep the tagline short.';
    if (address.trim().length > 200) return 'Keep the address short.';
    if (timezone.trim().isEmpty) return 'Pick a timezone.';
    if (currency.trim().length != 3) return 'Use a three-letter currency code.';
    if (minNoticeMinutes < 0 || minNoticeMinutes > 20160) {
      return 'Notice is between none and two weeks.';
    }
    if (maxHorizonDays < 1 || maxHorizonDays > 365) {
      return 'Bookings open between 1 and 365 days ahead.';
    }
    if (cancellationGraceHours < 0 || cancellationGraceHours > 720) {
      return 'A grace window is between 0 and 720 hours.';
    }
    if (refundTerms.trim().length > 1000) return 'Keep the refund terms short.';
    if (gcashName.trim().length > 120) return 'That name is too long.';
    return null;
  }

  bool get isValid => validate() == null;

  VenueSettingsInput copyWith({
    String? name,
    String? tagline,
    String? address,
    String? timezone,
    String? currency,
    VenueTheme? theme,
    int? minNoticeMinutes,
    int? maxHorizonDays,
    CancellationMode? cancellationMode,
    int? cancellationGraceHours,
    String? refundTerms,
    String? gcashName,
  }) =>
      VenueSettingsInput(
        name: name ?? this.name,
        tagline: tagline ?? this.tagline,
        address: address ?? this.address,
        timezone: timezone ?? this.timezone,
        currency: currency ?? this.currency,
        theme: theme ?? this.theme,
        minNoticeMinutes: minNoticeMinutes ?? this.minNoticeMinutes,
        maxHorizonDays: maxHorizonDays ?? this.maxHorizonDays,
        cancellationMode: cancellationMode ?? this.cancellationMode,
        cancellationGraceHours:
            cancellationGraceHours ?? this.cancellationGraceHours,
        refundTerms: refundTerms ?? this.refundTerms,
        gcashName: gcashName ?? this.gcashName,
      );

  /// Empty strings go over the wire as null, the way `?? null` does on the
  /// server — an empty tagline is no tagline, not a blank one.
  String? _orNull(String v) => v.trim().isEmpty ? null : v.trim();

  Map<String, dynamic> toJson() => {
        'name': name.trim(),
        'tagline': _orNull(tagline),
        'address': _orNull(address),
        'timezone': timezone,
        'currency': currency.toUpperCase(),
        'theme': theme.wire,
        'minNoticeMinutes': minNoticeMinutes,
        'maxHorizonDays': maxHorizonDays,
        'cancellationMode': cancellationMode.wire,
        'cancellationGraceHours': cancellationGraceHours,
        'refundTerms': _orNull(refundTerms),
        'gcashName': _orNull(gcashName),
      };
}

abstract class SettingsRepository {
  Future<VenueSettings> get(String venueSlug);

  /// Owner and admin only, like every other structural write.
  Future<VenueSettings> update(String venueSlug, VenueSettingsInput input);

  /// [image] is an already-resized JPEG, or null to clear.
  Future<VenueSettings> setBranding(
    String venueSlug,
    BrandingSlot slot,
    List<int>? image,
  );
}

enum BrandingSlot {
  logo('logo'),
  cover('cover');

  const BrandingSlot(this.wire);
  final String wire;

  String get label => switch (this) {
        BrandingSlot.logo => 'Logo',
        BrandingSlot.cover => 'Cover photo',
      };
}
