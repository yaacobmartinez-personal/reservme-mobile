// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpaceSummary _$SpaceSummaryFromJson(Map<String, dynamic> json) =>
    _SpaceSummary(
      id: json['id'] as String,
      name: json['name'] as String,
      kind:
          $enumDecodeNullable(_$SpaceKindEnumMap, json['kind']) ??
          SpaceKind.court,
      slotMinutes: (json['slotMinutes'] as num?)?.toInt() ?? 60,
      priceCents: (json['priceCents'] as num?)?.toInt() ?? 0,
      peakPriceCents: (json['peakPriceCents'] as num?)?.toInt(),
      isActive: json['isActive'] as bool? ?? true,
      imageUrl: json['imageUrl'] as String?,
      sessionSummary: json['sessionSummary'] as String?,
      upcomingBookings: (json['upcomingBookings'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SpaceSummaryToJson(_SpaceSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kind': _$SpaceKindEnumMap[instance.kind]!,
      'slotMinutes': instance.slotMinutes,
      'priceCents': instance.priceCents,
      'peakPriceCents': instance.peakPriceCents,
      'isActive': instance.isActive,
      'imageUrl': instance.imageUrl,
      'sessionSummary': instance.sessionSummary,
      'upcomingBookings': instance.upcomingBookings,
    };

const _$SpaceKindEnumMap = {
  SpaceKind.court: 'court',
  SpaceKind.room: 'room',
  SpaceKind.studio: 'studio',
  SpaceKind.table: 'table',
  SpaceKind.tour: 'tour',
  SpaceKind.other: 'other',
};
