// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VenueSettings _$VenueSettingsFromJson(Map<String, dynamic> json) =>
    _VenueSettings(
      slug: json['slug'] as String,
      name: json['name'] as String,
      tagline: json['tagline'] as String?,
      address: json['address'] as String?,
      timezone: json['timezone'] as String? ?? 'Asia/Manila',
      currency: json['currency'] as String? ?? 'PHP',
      theme:
          $enumDecodeNullable(_$VenueThemeEnumMap, json['theme']) ??
          VenueTheme.pine,
      logoUrl: json['logoUrl'] as String?,
      coverUrl: json['coverUrl'] as String?,
      minNoticeMinutes: (json['minNoticeMinutes'] as num?)?.toInt() ?? 60,
      maxHorizonDays: (json['maxHorizonDays'] as num?)?.toInt() ?? 60,
      cancellationMode:
          $enumDecodeNullable(
            _$CancellationModeEnumMap,
            json['cancellationMode'],
          ) ??
          CancellationMode.grace,
      cancellationGraceHours:
          (json['cancellationGraceHours'] as num?)?.toInt() ?? 24,
      refundTerms: json['refundTerms'] as String?,
      gcashName: json['gcashName'] as String?,
      suspended: json['suspended'] as bool? ?? false,
      suspendedReason: json['suspendedReason'] as String?,
    );

Map<String, dynamic> _$VenueSettingsToJson(_VenueSettings instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
      'tagline': instance.tagline,
      'address': instance.address,
      'timezone': instance.timezone,
      'currency': instance.currency,
      'theme': _$VenueThemeEnumMap[instance.theme]!,
      'logoUrl': instance.logoUrl,
      'coverUrl': instance.coverUrl,
      'minNoticeMinutes': instance.minNoticeMinutes,
      'maxHorizonDays': instance.maxHorizonDays,
      'cancellationMode': _$CancellationModeEnumMap[instance.cancellationMode]!,
      'cancellationGraceHours': instance.cancellationGraceHours,
      'refundTerms': instance.refundTerms,
      'gcashName': instance.gcashName,
      'suspended': instance.suspended,
      'suspendedReason': instance.suspendedReason,
    };

const _$VenueThemeEnumMap = {
  VenueTheme.pine: 'pine',
  VenueTheme.ocean: 'ocean',
  VenueTheme.violet: 'violet',
  VenueTheme.sunset: 'sunset',
  VenueTheme.rose: 'rose',
  VenueTheme.slate: 'slate',
};

const _$CancellationModeEnumMap = {
  CancellationMode.anytime: 'anytime',
  CancellationMode.grace: 'grace',
  CancellationMode.never: 'never',
};
