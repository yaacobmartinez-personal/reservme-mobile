// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cancellation _$CancellationFromJson(Map<String, dynamic> json) =>
    _Cancellation(
      canCancel: json['canCancel'] as bool? ?? false,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$CancellationToJson(_Cancellation instance) =>
    <String, dynamic>{
      'canCancel': instance.canCancel,
      'reason': instance.reason,
    };

_BookingVenue _$BookingVenueFromJson(Map<String, dynamic> json) =>
    _BookingVenue(
      slug: json['slug'] as String,
      name: json['name'] as String,
      theme:
          $enumDecodeNullable(_$VenueThemeEnumMap, json['theme']) ??
          VenueTheme.pine,
      timezone: json['timezone'] as String? ?? 'Asia/Manila',
      currency: json['currency'] as String? ?? 'PHP',
      address: json['address'] as String?,
    );

Map<String, dynamic> _$BookingVenueToJson(_BookingVenue instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
      'theme': _$VenueThemeEnumMap[instance.theme]!,
      'timezone': instance.timezone,
      'currency': instance.currency,
      'address': instance.address,
    };

const _$VenueThemeEnumMap = {
  VenueTheme.pine: 'pine',
  VenueTheme.ocean: 'ocean',
  VenueTheme.violet: 'violet',
  VenueTheme.sunset: 'sunset',
  VenueTheme.rose: 'rose',
  VenueTheme.slate: 'slate',
};

_BookingSpace _$BookingSpaceFromJson(Map<String, dynamic> json) =>
    _BookingSpace(
      id: json['id'] as String,
      name: json['name'] as String,
      kind:
          $enumDecodeNullable(_$SpaceKindEnumMap, json['kind']) ??
          SpaceKind.other,
      slotMinutes: (json['slotMinutes'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$BookingSpaceToJson(_BookingSpace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kind': _$SpaceKindEnumMap[instance.kind]!,
      'slotMinutes': instance.slotMinutes,
    };

const _$SpaceKindEnumMap = {
  SpaceKind.court: 'court',
  SpaceKind.room: 'room',
  SpaceKind.studio: 'studio',
  SpaceKind.table: 'table',
  SpaceKind.tour: 'tour',
  SpaceKind.other: 'other',
};

_Booking _$BookingFromJson(Map<String, dynamic> json) => _Booking(
  id: json['id'] as String?,
  reference: json['reference'] as String,
  venue: BookingVenue.fromJson(json['venue'] as Map<String, dynamic>),
  space: BookingSpace.fromJson(json['space'] as Map<String, dynamic>),
  startsAt: DateTime.parse(json['startsAt'] as String),
  endsAt: DateTime.parse(json['endsAt'] as String),
  whenLabel: json['whenLabel'] as String,
  kind:
      $enumDecodeNullable(_$ReservationKindEnumMap, json['kind']) ??
      ReservationKind.rental,
  partySize: (json['partySize'] as num?)?.toInt() ?? 1,
  amountCents: (json['amountCents'] as num?)?.toInt() ?? 0,
  status:
      $enumDecodeNullable(_$ReservationStatusEnumMap, json['status']) ??
      ReservationStatus.confirmed,
  checkedInAt: json['checkedInAt'] == null
      ? null
      : DateTime.parse(json['checkedInAt'] as String),
  notes: json['notes'] as String?,
  cancellation: json['cancellation'] == null
      ? const Cancellation()
      : Cancellation.fromJson(json['cancellation'] as Map<String, dynamic>),
  manageToken: json['manageToken'] as String?,
);

Map<String, dynamic> _$BookingToJson(_Booking instance) => <String, dynamic>{
  'id': instance.id,
  'reference': instance.reference,
  'venue': instance.venue,
  'space': instance.space,
  'startsAt': instance.startsAt.toIso8601String(),
  'endsAt': instance.endsAt.toIso8601String(),
  'whenLabel': instance.whenLabel,
  'kind': _$ReservationKindEnumMap[instance.kind]!,
  'partySize': instance.partySize,
  'amountCents': instance.amountCents,
  'status': _$ReservationStatusEnumMap[instance.status]!,
  'checkedInAt': instance.checkedInAt?.toIso8601String(),
  'notes': instance.notes,
  'cancellation': instance.cancellation,
  'manageToken': instance.manageToken,
};

const _$ReservationKindEnumMap = {
  ReservationKind.rental: 'rental',
  ReservationKind.sessionBlock: 'session_block',
  ReservationKind.sessionSeat: 'session_seat',
};

const _$ReservationStatusEnumMap = {
  ReservationStatus.held: 'held',
  ReservationStatus.confirmed: 'confirmed',
  ReservationStatus.cancelled: 'cancelled',
  ReservationStatus.noShow: 'no_show',
};

_BookingInput _$BookingInputFromJson(Map<String, dynamic> json) =>
    _BookingInput(
      spaceId: json['spaceId'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      promo: json['promo'] as String?,
      partySize: (json['partySize'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$BookingInputToJson(_BookingInput instance) =>
    <String, dynamic>{
      'spaceId': instance.spaceId,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'promo': instance.promo,
      'partySize': instance.partySize,
    };
