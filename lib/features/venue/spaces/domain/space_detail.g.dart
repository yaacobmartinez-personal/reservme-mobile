// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpaceDetail _$SpaceDetailFromJson(Map<String, dynamic> json) => _SpaceDetail(
  id: json['id'] as String,
  name: json['name'] as String,
  slug: json['slug'] as String,
  kind:
      $enumDecodeNullable(_$SpaceKindEnumMap, json['kind']) ?? SpaceKind.court,
  capacity: (json['capacity'] as num?)?.toInt() ?? 1,
  slotMinutes: (json['slotMinutes'] as num?)?.toInt() ?? 60,
  bufferMinutes: (json['bufferMinutes'] as num?)?.toInt() ?? 0,
  priceCents: (json['priceCents'] as num?)?.toInt() ?? 0,
  isActive: json['isActive'] as bool? ?? true,
  imageUrl: json['imageUrl'] as String?,
  hours:
      (json['hours'] as List<dynamic>?)
          ?.map((e) => DayHoursView.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DayHoursView>[],
  pricingRules:
      (json['pricingRules'] as List<dynamic>?)
          ?.map((e) => PricingRuleView.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PricingRuleView>[],
  closures:
      (json['closures'] as List<dynamic>?)
          ?.map((e) => ClosureView.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ClosureView>[],
  sessions:
      (json['sessions'] as List<dynamic>?)
          ?.map((e) => SpaceSessionView.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SpaceSessionView>[],
  upcomingBookings: (json['upcomingBookings'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SpaceDetailToJson(_SpaceDetail instance) =>
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
      'imageUrl': instance.imageUrl,
      'hours': instance.hours,
      'pricingRules': instance.pricingRules,
      'closures': instance.closures,
      'sessions': instance.sessions,
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

_DayHoursView _$DayHoursViewFromJson(Map<String, dynamic> json) =>
    _DayHoursView(
      weekday: (json['weekday'] as num).toInt(),
      opensAt: json['opensAt'] as String,
      closesAt: json['closesAt'] as String,
    );

Map<String, dynamic> _$DayHoursViewToJson(_DayHoursView instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'opensAt': instance.opensAt,
      'closesAt': instance.closesAt,
    };

_PricingRuleView _$PricingRuleViewFromJson(Map<String, dynamic> json) =>
    _PricingRuleView(
      id: json['id'] as String,
      label: json['label'] as String?,
      weekdays:
          (json['weekdays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      startsAt: json['startsAt'] as String,
      endsAt: json['endsAt'] as String,
      priceCents: (json['priceCents'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PricingRuleViewToJson(_PricingRuleView instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'weekdays': instance.weekdays,
      'startsAt': instance.startsAt,
      'endsAt': instance.endsAt,
      'priceCents': instance.priceCents,
    };

_ClosureView _$ClosureViewFromJson(Map<String, dynamic> json) => _ClosureView(
  id: json['id'] as String,
  spaceId: json['spaceId'] as String?,
  spaceName: json['spaceName'] as String?,
  startsAt: DateTime.parse(json['startsAt'] as String),
  endsAt: DateTime.parse(json['endsAt'] as String),
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$ClosureViewToJson(_ClosureView instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spaceId': instance.spaceId,
      'spaceName': instance.spaceName,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'reason': instance.reason,
    };

_SpaceSessionView _$SpaceSessionViewFromJson(Map<String, dynamic> json) =>
    _SpaceSessionView(
      id: json['id'] as String,
      title: json['title'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      capacity: (json['capacity'] as num?)?.toInt() ?? 0,
      bookedSpots: (json['bookedSpots'] as num?)?.toInt() ?? 0,
      cancelled: json['cancelled'] as bool? ?? false,
    );

Map<String, dynamic> _$SpaceSessionViewToJson(_SpaceSessionView instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'capacity': instance.capacity,
      'bookedSpots': instance.bookedSpots,
      'cancelled': instance.cancelled,
    };
