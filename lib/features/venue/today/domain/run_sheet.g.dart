// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_sheet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RunSheetEntry _$RunSheetEntryFromJson(Map<String, dynamic> json) =>
    _RunSheetEntry(
      id: json['id'] as String,
      reference: json['reference'] as String,
      spaceName: json['spaceName'] as String,
      customerId: json['customerId'] as String?,
      customerName: json['customerName'] as String?,
      customerPhone: json['customerPhone'] as String?,
      label: json['label'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      status:
          $enumDecodeNullable(_$ReservationStatusEnumMap, json['status']) ??
          ReservationStatus.confirmed,
      kind:
          $enumDecodeNullable(_$ReservationKindEnumMap, json['kind']) ??
          ReservationKind.rental,
      partySize: (json['partySize'] as num?)?.toInt() ?? 1,
      amountCents: (json['amountCents'] as num?)?.toInt() ?? 0,
      checkedInAt: json['checkedInAt'] == null
          ? null
          : DateTime.parse(json['checkedInAt'] as String),
      noShowCount: (json['noShowCount'] as num?)?.toInt() ?? 0,
      firstVisit: json['firstVisit'] as bool? ?? false,
      sessionCapacity: (json['sessionCapacity'] as num?)?.toInt(),
      sessionBooked: (json['sessionBooked'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RunSheetEntryToJson(_RunSheetEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reference': instance.reference,
      'spaceName': instance.spaceName,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'label': instance.label,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'status': _$ReservationStatusEnumMap[instance.status]!,
      'kind': _$ReservationKindEnumMap[instance.kind]!,
      'partySize': instance.partySize,
      'amountCents': instance.amountCents,
      'checkedInAt': instance.checkedInAt?.toIso8601String(),
      'noShowCount': instance.noShowCount,
      'firstVisit': instance.firstVisit,
      'sessionCapacity': instance.sessionCapacity,
      'sessionBooked': instance.sessionBooked,
    };

const _$ReservationStatusEnumMap = {
  ReservationStatus.held: 'held',
  ReservationStatus.confirmed: 'confirmed',
  ReservationStatus.cancelled: 'cancelled',
  ReservationStatus.noShow: 'no_show',
};

const _$ReservationKindEnumMap = {
  ReservationKind.rental: 'rental',
  ReservationKind.sessionBlock: 'session_block',
  ReservationKind.sessionSeat: 'session_seat',
};

_VenueStats _$VenueStatsFromJson(Map<String, dynamic> json) => _VenueStats(
  todayCount: (json['todayCount'] as num?)?.toInt() ?? 0,
  checkedIn: (json['checkedIn'] as num?)?.toInt() ?? 0,
  upcomingCount: (json['upcomingCount'] as num?)?.toInt() ?? 0,
  activeSpaces: (json['activeSpaces'] as num?)?.toInt() ?? 0,
  totalSpaces: (json['totalSpaces'] as num?)?.toInt() ?? 0,
  todayRevenueCents: (json['todayRevenueCents'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$VenueStatsToJson(_VenueStats instance) =>
    <String, dynamic>{
      'todayCount': instance.todayCount,
      'checkedIn': instance.checkedIn,
      'upcomingCount': instance.upcomingCount,
      'activeSpaces': instance.activeSpaces,
      'totalSpaces': instance.totalSpaces,
      'todayRevenueCents': instance.todayRevenueCents,
    };

_TodayView _$TodayViewFromJson(Map<String, dynamic> json) => _TodayView(
  date: json['date'] as String,
  stats: json['stats'] == null
      ? const VenueStats()
      : VenueStats.fromJson(json['stats'] as Map<String, dynamic>),
  runSheet:
      (json['runSheet'] as List<dynamic>?)
          ?.map((e) => RunSheetEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TodayViewToJson(_TodayView instance) =>
    <String, dynamic>{
      'date': instance.date,
      'stats': instance.stats,
      'runSheet': instance.runSheet,
    };
