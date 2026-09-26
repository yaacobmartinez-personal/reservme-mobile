// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomerSummary _$CustomerSummaryFromJson(Map<String, dynamic> json) =>
    _CustomerSummary(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      bookings: (json['bookings'] as num?)?.toInt() ?? 0,
      lifetimeValueCents: (json['lifetimeValueCents'] as num?)?.toInt() ?? 0,
      noShowCount: (json['noShowCount'] as num?)?.toInt() ?? 0,
      lastVisitDays: (json['lastVisitDays'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      loyaltyPoints: (json['loyaltyPoints'] as num?)?.toInt() ?? 0,
      marketingOptIn: json['marketingOptIn'] as bool? ?? false,
    );

Map<String, dynamic> _$CustomerSummaryToJson(_CustomerSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'tags': instance.tags,
      'bookings': instance.bookings,
      'lifetimeValueCents': instance.lifetimeValueCents,
      'noShowCount': instance.noShowCount,
      'lastVisitDays': instance.lastVisitDays,
      'createdAt': instance.createdAt.toIso8601String(),
      'loyaltyPoints': instance.loyaltyPoints,
      'marketingOptIn': instance.marketingOptIn,
    };

_CustomerBooking _$CustomerBookingFromJson(Map<String, dynamic> json) =>
    _CustomerBooking(
      id: json['id'] as String,
      spaceName: json['spaceName'] as String,
      whenLabel: json['whenLabel'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      status:
          $enumDecodeNullable(_$ReservationStatusEnumMap, json['status']) ??
          ReservationStatus.confirmed,
      kind:
          $enumDecodeNullable(_$ReservationKindEnumMap, json['kind']) ??
          ReservationKind.rental,
      amountCents: (json['amountCents'] as num?)?.toInt() ?? 0,
      reference: json['reference'] as String,
      checkedInAt: json['checkedInAt'] == null
          ? null
          : DateTime.parse(json['checkedInAt'] as String),
    );

Map<String, dynamic> _$CustomerBookingToJson(_CustomerBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spaceName': instance.spaceName,
      'whenLabel': instance.whenLabel,
      'startsAt': instance.startsAt.toIso8601String(),
      'status': _$ReservationStatusEnumMap[instance.status]!,
      'kind': _$ReservationKindEnumMap[instance.kind]!,
      'amountCents': instance.amountCents,
      'reference': instance.reference,
      'checkedInAt': instance.checkedInAt?.toIso8601String(),
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

_CustomerNote _$CustomerNoteFromJson(Map<String, dynamic> json) =>
    _CustomerNote(
      id: json['id'] as String,
      body: json['body'] as String,
      authorName: json['authorName'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CustomerNoteToJson(_CustomerNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'authorName': instance.authorName,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_CustomerProfile _$CustomerProfileFromJson(Map<String, dynamic> json) =>
    _CustomerProfile(
      customer: CustomerSummary.fromJson(
        json['customer'] as Map<String, dynamic>,
      ),
      upcoming:
          (json['upcoming'] as List<dynamic>?)
              ?.map((e) => CustomerBooking.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      past:
          (json['past'] as List<dynamic>?)
              ?.map((e) => CustomerBooking.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      notes:
          (json['notes'] as List<dynamic>?)
              ?.map((e) => CustomerNote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastVisit: json['lastVisit'] == null
          ? null
          : DateTime.parse(json['lastVisit'] as String),
      holdings:
          (json['holdings'] as List<dynamic>?)
              ?.map((e) => Holding.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Holding>[],
    );

Map<String, dynamic> _$CustomerProfileToJson(_CustomerProfile instance) =>
    <String, dynamic>{
      'customer': instance.customer,
      'upcoming': instance.upcoming,
      'past': instance.past,
      'notes': instance.notes,
      'lastVisit': instance.lastVisit?.toIso8601String(),
      'holdings': instance.holdings,
    };

_CustomerPage _$CustomerPageFromJson(Map<String, dynamic> json) =>
    _CustomerPage(
      rows:
          (json['rows'] as List<dynamic>?)
              ?.map((e) => CustomerSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CustomerPageToJson(_CustomerPage instance) =>
    <String, dynamic>{'rows': instance.rows, 'total': instance.total};
