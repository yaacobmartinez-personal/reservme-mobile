// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VenueSpace _$VenueSpaceFromJson(Map<String, dynamic> json) => _VenueSpace(
  id: json['id'] as String,
  name: json['name'] as String,
  slug: json['slug'] as String,
  kind:
      $enumDecodeNullable(_$SpaceKindEnumMap, json['kind']) ?? SpaceKind.other,
  capacity: (json['capacity'] as num?)?.toInt() ?? 1,
  slotMinutes: (json['slotMinutes'] as num?)?.toInt() ?? 60,
  bufferMinutes: (json['bufferMinutes'] as num?)?.toInt() ?? 0,
  priceCents: (json['priceCents'] as num).toInt(),
  isActive: json['isActive'] as bool? ?? true,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  imageUrl: json['imageUrl'] as String?,
  peakPriceCents: (json['peakPriceCents'] as num?)?.toInt(),
  openToday: (json['openToday'] as num?)?.toInt(),
);

Map<String, dynamic> _$VenueSpaceToJson(_VenueSpace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'kind': _$SpaceKindEnumMap[instance.kind]!,
      'capacity': instance.capacity,
      'slotMinutes': instance.slotMinutes,
      'bufferMinutes': instance.bufferMinutes,
      'priceCents': instance.priceCents,
      'isActive': instance.isActive,
      'sortOrder': instance.sortOrder,
      'imageUrl': instance.imageUrl,
      'peakPriceCents': instance.peakPriceCents,
      'openToday': instance.openToday,
    };

const _$SpaceKindEnumMap = {
  SpaceKind.court: 'court',
  SpaceKind.room: 'room',
  SpaceKind.studio: 'studio',
  SpaceKind.table: 'table',
  SpaceKind.tour: 'tour',
  SpaceKind.other: 'other',
};

_PublicVenue _$PublicVenueFromJson(Map<String, dynamic> json) => _PublicVenue(
  id: json['id'] as String,
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
      CancellationMode.anytime,
  cancellationGraceHours:
      (json['cancellationGraceHours'] as num?)?.toInt() ?? 24,
  refundTerms: json['refundTerms'] as String?,
  gcashName: json['gcashName'] as String?,
  suspended: json['suspended'] as bool? ?? false,
  spaces:
      (json['spaces'] as List<dynamic>?)
          ?.map((e) => VenueSpace.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$PublicVenueToJson(_PublicVenue instance) =>
    <String, dynamic>{
      'id': instance.id,
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
      'spaces': instance.spaces,
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
