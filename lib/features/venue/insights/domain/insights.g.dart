// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insights.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Insights _$InsightsFromJson(Map<String, dynamic> json) => _Insights(
  range:
      $enumDecodeNullable(_$InsightsRangeEnumMap, json['range']) ??
      InsightsRange.month,
  bookedValueCents: json['bookedValueCents'] == null
      ? const Kpi()
      : Kpi.fromJson(json['bookedValueCents'] as Map<String, dynamic>),
  bookings: json['bookings'] == null
      ? const Kpi()
      : Kpi.fromJson(json['bookings'] as Map<String, dynamic>),
  utilisationPct: json['utilisationPct'] == null
      ? const Kpi()
      : Kpi.fromJson(json['utilisationPct'] as Map<String, dynamic>),
  noShowRatePct: json['noShowRatePct'] == null
      ? const Kpi()
      : Kpi.fromJson(json['noShowRatePct'] as Map<String, dynamic>),
  bookedByDay:
      (json['bookedByDay'] as List<dynamic>?)
          ?.map((e) => DayPoint.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DayPoint>[],
  peakHours:
      (json['peakHours'] as List<dynamic>?)
          ?.map(
            (e) => (e as List<dynamic>).map((e) => (e as num).toInt()).toList(),
          )
          .toList() ??
      const <List<int>>[],
  mix: json['mix'] == null
      ? const BookingMix()
      : BookingMix.fromJson(json['mix'] as Map<String, dynamic>),
  bySpace:
      (json['bySpace'] as List<dynamic>?)
          ?.map((e) => SpaceValue.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SpaceValue>[],
  customers: json['customers'] == null
      ? const CustomerMix()
      : CustomerMix.fromJson(json['customers'] as Map<String, dynamic>),
  needsYou: json['needsYou'] == null
      ? const NeedsYou()
      : NeedsYou.fromJson(json['needsYou'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InsightsToJson(_Insights instance) => <String, dynamic>{
  'range': _$InsightsRangeEnumMap[instance.range]!,
  'bookedValueCents': instance.bookedValueCents,
  'bookings': instance.bookings,
  'utilisationPct': instance.utilisationPct,
  'noShowRatePct': instance.noShowRatePct,
  'bookedByDay': instance.bookedByDay,
  'peakHours': instance.peakHours,
  'mix': instance.mix,
  'bySpace': instance.bySpace,
  'customers': instance.customers,
  'needsYou': instance.needsYou,
};

const _$InsightsRangeEnumMap = {
  InsightsRange.today: 'today',
  InsightsRange.week: '7d',
  InsightsRange.month: '30d',
  InsightsRange.quarter: '90d',
};

_Kpi _$KpiFromJson(Map<String, dynamic> json) => _Kpi(
  value: json['value'] as num? ?? 0,
  previous: json['previous'] as num? ?? 0,
  deltaPct: (json['deltaPct'] as num?)?.toDouble(),
  series:
      (json['series'] as List<dynamic>?)?.map((e) => e as num).toList() ??
      const <num>[],
);

Map<String, dynamic> _$KpiToJson(_Kpi instance) => <String, dynamic>{
  'value': instance.value,
  'previous': instance.previous,
  'deltaPct': instance.deltaPct,
  'series': instance.series,
};

_DayPoint _$DayPointFromJson(Map<String, dynamic> json) => _DayPoint(
  day: json['day'] as String,
  cents: (json['cents'] as num?)?.toInt() ?? 0,
  utilisationPct: (json['utilisationPct'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$DayPointToJson(_DayPoint instance) => <String, dynamic>{
  'day': instance.day,
  'cents': instance.cents,
  'utilisationPct': instance.utilisationPct,
};

_BookingMix _$BookingMixFromJson(Map<String, dynamic> json) => _BookingMix(
  confirmed: (json['confirmed'] as num?)?.toInt() ?? 0,
  cancelled: (json['cancelled'] as num?)?.toInt() ?? 0,
  noShow: (json['noShow'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$BookingMixToJson(_BookingMix instance) =>
    <String, dynamic>{
      'confirmed': instance.confirmed,
      'cancelled': instance.cancelled,
      'noShow': instance.noShow,
    };

_SpaceValue _$SpaceValueFromJson(Map<String, dynamic> json) => _SpaceValue(
  spaceId: json['spaceId'] as String,
  name: json['name'] as String,
  cents: (json['cents'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SpaceValueToJson(_SpaceValue instance) =>
    <String, dynamic>{
      'spaceId': instance.spaceId,
      'name': instance.name,
      'cents': instance.cents,
    };

_CustomerMix _$CustomerMixFromJson(Map<String, dynamic> json) => _CustomerMix(
  newCount: (json['newCount'] as num?)?.toInt() ?? 0,
  returningCount: (json['returningCount'] as num?)?.toInt() ?? 0,
  repeatRatePct: (json['repeatRatePct'] as num?)?.toInt() ?? 0,
  top:
      (json['top'] as List<dynamic>?)
          ?.map((e) => TopCustomer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TopCustomer>[],
);

Map<String, dynamic> _$CustomerMixToJson(_CustomerMix instance) =>
    <String, dynamic>{
      'newCount': instance.newCount,
      'returningCount': instance.returningCount,
      'repeatRatePct': instance.repeatRatePct,
      'top': instance.top,
    };

_TopCustomer _$TopCustomerFromJson(Map<String, dynamic> json) => _TopCustomer(
  customerId: json['customerId'] as String,
  name: json['name'] as String,
  bookings: (json['bookings'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TopCustomerToJson(_TopCustomer instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'name': instance.name,
      'bookings': instance.bookings,
    };

_NeedsYou _$NeedsYouFromJson(Map<String, dynamic> json) => _NeedsYou(
  toCheckIn: (json['toCheckIn'] as num?)?.toInt() ?? 0,
  halfEmptySessions:
      (json['halfEmptySessions'] as List<dynamic>?)
          ?.map((e) => HalfEmptySession.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HalfEmptySession>[],
);

Map<String, dynamic> _$NeedsYouToJson(_NeedsYou instance) => <String, dynamic>{
  'toCheckIn': instance.toCheckIn,
  'halfEmptySessions': instance.halfEmptySessions,
};

_HalfEmptySession _$HalfEmptySessionFromJson(Map<String, dynamic> json) =>
    _HalfEmptySession(
      id: json['id'] as String,
      title: json['title'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      spotsLeft: (json['spotsLeft'] as num?)?.toInt() ?? 0,
      capacity: (json['capacity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$HalfEmptySessionToJson(_HalfEmptySession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startsAt': instance.startsAt.toIso8601String(),
      'spotsLeft': instance.spotsLeft,
      'capacity': instance.capacity,
    };
