// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarItem _$CalendarItemFromJson(Map<String, dynamic> json) =>
    _CalendarItem(
      id: json['id'] as String,
      kind: $enumDecode(_$CalendarItemKindEnumMap, json['kind']),
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      label: json['label'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      customerId: json['customerId'] as String?,
      reference: json['reference'] as String?,
      status:
          $enumDecodeNullable(_$ReservationStatusEnumMap, json['status']) ??
          ReservationStatus.confirmed,
      checkedInAt: json['checkedInAt'] == null
          ? null
          : DateTime.parse(json['checkedInAt'] as String),
      amountCents: (json['amountCents'] as num?)?.toInt() ?? 0,
      partySize: (json['partySize'] as num?)?.toInt() ?? 1,
      noShowCount: (json['noShowCount'] as num?)?.toInt() ?? 0,
      sessionCapacity: (json['sessionCapacity'] as num?)?.toInt(),
      sessionBooked: (json['sessionBooked'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CalendarItemToJson(_CalendarItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': _$CalendarItemKindEnumMap[instance.kind]!,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'label': instance.label,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'customerId': instance.customerId,
      'reference': instance.reference,
      'status': _$ReservationStatusEnumMap[instance.status]!,
      'checkedInAt': instance.checkedInAt?.toIso8601String(),
      'amountCents': instance.amountCents,
      'partySize': instance.partySize,
      'noShowCount': instance.noShowCount,
      'sessionCapacity': instance.sessionCapacity,
      'sessionBooked': instance.sessionBooked,
    };

const _$CalendarItemKindEnumMap = {
  CalendarItemKind.booking: 'booking',
  CalendarItemKind.block: 'block',
  CalendarItemKind.session: 'session',
};

const _$ReservationStatusEnumMap = {
  ReservationStatus.held: 'held',
  ReservationStatus.confirmed: 'confirmed',
  ReservationStatus.cancelled: 'cancelled',
  ReservationStatus.noShow: 'no_show',
};

_CalendarLane _$CalendarLaneFromJson(Map<String, dynamic> json) =>
    _CalendarLane(
      spaceId: json['spaceId'] as String,
      spaceName: json['spaceName'] as String,
      slotMinutes: (json['slotMinutes'] as num?)?.toInt() ?? 60,
      isActive: json['isActive'] as bool? ?? true,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => CalendarItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CalendarLaneToJson(_CalendarLane instance) =>
    <String, dynamic>{
      'spaceId': instance.spaceId,
      'spaceName': instance.spaceName,
      'slotMinutes': instance.slotMinutes,
      'isActive': instance.isActive,
      'items': instance.items,
    };

_CalendarDay _$CalendarDayFromJson(Map<String, dynamic> json) => _CalendarDay(
  date: json['date'] as String,
  rows:
      (json['rows'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  lanes:
      (json['lanes'] as List<dynamic>?)
          ?.map((e) => CalendarLane.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CalendarDayToJson(_CalendarDay instance) =>
    <String, dynamic>{
      'date': instance.date,
      'rows': instance.rows,
      'lanes': instance.lanes,
    };
