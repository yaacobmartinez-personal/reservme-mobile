// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Slot _$SlotFromJson(Map<String, dynamic> json) => _Slot(
  startsAt: DateTime.parse(json['startsAt'] as String),
  endsAt: DateTime.parse(json['endsAt'] as String),
  label: json['label'] as String,
  available: json['available'] as bool,
  reason: $enumDecode(_$SlotReasonEnumMap, json['reason']),
  priceCents: (json['priceCents'] as num).toInt(),
  peak: json['peak'] as bool? ?? false,
);

Map<String, dynamic> _$SlotToJson(_Slot instance) => <String, dynamic>{
  'startsAt': instance.startsAt.toIso8601String(),
  'endsAt': instance.endsAt.toIso8601String(),
  'label': instance.label,
  'available': instance.available,
  'reason': _$SlotReasonEnumMap[instance.reason]!,
  'priceCents': instance.priceCents,
  'peak': instance.peak,
};

const _$SlotReasonEnumMap = {
  SlotReason.open: 'open',
  SlotReason.taken: 'taken',
  SlotReason.closed: 'closed',
  SlotReason.tooSoon: 'too_soon',
  SlotReason.tooFarAhead: 'too_far_ahead',
};

_SessionSummary _$SessionSummaryFromJson(Map<String, dynamic> json) =>
    _SessionSummary(
      id: json['id'] as String,
      title: json['title'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      label: json['label'] as String,
      capacity: (json['capacity'] as num).toInt(),
      bookedSpots: (json['bookedSpots'] as num).toInt(),
      pricePerPersonCents: (json['pricePerPersonCents'] as num).toInt(),
    );

Map<String, dynamic> _$SessionSummaryToJson(_SessionSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'label': instance.label,
      'capacity': instance.capacity,
      'bookedSpots': instance.bookedSpots,
      'pricePerPersonCents': instance.pricePerPersonCents,
    };

_DayAvailability _$DayAvailabilityFromJson(Map<String, dynamic> json) =>
    _DayAvailability(
      date: json['date'] as String,
      slots:
          (json['slots'] as List<dynamic>?)
              ?.map((e) => Slot.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sessions:
          (json['sessions'] as List<dynamic>?)
              ?.map((e) => SessionSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DayAvailabilityToJson(_DayAvailability instance) =>
    <String, dynamic>{
      'date': instance.date,
      'slots': instance.slots,
      'sessions': instance.sessions,
    };
