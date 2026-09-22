// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'run_sheet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RunSheetEntry {

 String get id; String get reference; String get spaceName; String? get customerId; String? get customerName; String? get customerPhone;/// "18:00–19:00", already in the venue's timezone.
 String get label; DateTime get startsAt; DateTime get endsAt; ReservationStatus get status; ReservationKind get kind; int get partySize; int get amountCents; DateTime? get checkedInAt; int get noShowCount; bool get firstVisit;/// Session seats roll up into one line: "7 of 12".
 int? get sessionCapacity; int? get sessionBooked;
/// Create a copy of RunSheetEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RunSheetEntryCopyWith<RunSheetEntry> get copyWith => _$RunSheetEntryCopyWithImpl<RunSheetEntry>(this as RunSheetEntry, _$identity);

  /// Serializes this RunSheetEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RunSheetEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RunSheetEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.spaceName, _this.spaceName) || other.spaceName == _this.spaceName)&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.customerName, _this.customerName) || other.customerName == _this.customerName)&&(identical(other.customerPhone, _this.customerPhone) || other.customerPhone == _this.customerPhone)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.partySize, _this.partySize) || other.partySize == _this.partySize)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.checkedInAt, _this.checkedInAt) || other.checkedInAt == _this.checkedInAt)&&(identical(other.noShowCount, _this.noShowCount) || other.noShowCount == _this.noShowCount)&&(identical(other.firstVisit, _this.firstVisit) || other.firstVisit == _this.firstVisit)&&(identical(other.sessionCapacity, _this.sessionCapacity) || other.sessionCapacity == _this.sessionCapacity)&&(identical(other.sessionBooked, _this.sessionBooked) || other.sessionBooked == _this.sessionBooked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RunSheetEntry;
  return Object.hash(runtimeType,_this.id,_this.reference,_this.spaceName,_this.customerId,_this.customerName,_this.customerPhone,_this.label,_this.startsAt,_this.endsAt,_this.status,_this.kind,_this.partySize,_this.amountCents,_this.checkedInAt,_this.noShowCount,_this.firstVisit,_this.sessionCapacity,_this.sessionBooked);
}

@override
String toString() {
  final _this = this as RunSheetEntry;
  return 'RunSheetEntry(id: ${_this.id}, reference: ${_this.reference}, spaceName: ${_this.spaceName}, customerId: ${_this.customerId}, customerName: ${_this.customerName}, customerPhone: ${_this.customerPhone}, label: ${_this.label}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, status: ${_this.status}, kind: ${_this.kind}, partySize: ${_this.partySize}, amountCents: ${_this.amountCents}, checkedInAt: ${_this.checkedInAt}, noShowCount: ${_this.noShowCount}, firstVisit: ${_this.firstVisit}, sessionCapacity: ${_this.sessionCapacity}, sessionBooked: ${_this.sessionBooked})';
}


}

/// @nodoc
abstract mixin class $RunSheetEntryCopyWith<$Res>  {
  factory $RunSheetEntryCopyWith(RunSheetEntry value, $Res Function(RunSheetEntry) _then) = _$RunSheetEntryCopyWithImpl;
@useResult
$Res call({
 String id, String reference, String spaceName, String? customerId, String? customerName, String? customerPhone, String label, DateTime startsAt, DateTime endsAt, ReservationStatus status, ReservationKind kind, int partySize, int amountCents, DateTime? checkedInAt, int noShowCount, bool firstVisit, int? sessionCapacity, int? sessionBooked
});




}
/// @nodoc
class _$RunSheetEntryCopyWithImpl<$Res>
    implements $RunSheetEntryCopyWith<$Res> {
  _$RunSheetEntryCopyWithImpl(this._self, this._then);

  final RunSheetEntry _self;
  final $Res Function(RunSheetEntry) _then;

/// Create a copy of RunSheetEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? spaceName = null,Object? customerId = freezed,Object? customerName = freezed,Object? customerPhone = freezed,Object? label = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,Object? kind = null,Object? partySize = null,Object? amountCents = null,Object? checkedInAt = freezed,Object? noShowCount = null,Object? firstVisit = null,Object? sessionCapacity = freezed,Object? sessionBooked = freezed,}) {
  return _then(RunSheetEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,spaceName: null == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerPhone: freezed == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReservationKind,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,noShowCount: null == noShowCount ? _self.noShowCount : noShowCount // ignore: cast_nullable_to_non_nullable
as int,firstVisit: null == firstVisit ? _self.firstVisit : firstVisit // ignore: cast_nullable_to_non_nullable
as bool,sessionCapacity: freezed == sessionCapacity ? _self.sessionCapacity : sessionCapacity // ignore: cast_nullable_to_non_nullable
as int?,sessionBooked: freezed == sessionBooked ? _self.sessionBooked : sessionBooked // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RunSheetEntry].
extension RunSheetEntryPatterns on RunSheetEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RunSheetEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RunSheetEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RunSheetEntry value)  $default,){
final _that = this;
switch (_that) {
case _RunSheetEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RunSheetEntry value)?  $default,){
final _that = this;
switch (_that) {
case _RunSheetEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reference,  String spaceName,  String? customerId,  String? customerName,  String? customerPhone,  String label,  DateTime startsAt,  DateTime endsAt,  ReservationStatus status,  ReservationKind kind,  int partySize,  int amountCents,  DateTime? checkedInAt,  int noShowCount,  bool firstVisit,  int? sessionCapacity,  int? sessionBooked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RunSheetEntry() when $default != null:
return $default(_that.id,_that.reference,_that.spaceName,_that.customerId,_that.customerName,_that.customerPhone,_that.label,_that.startsAt,_that.endsAt,_that.status,_that.kind,_that.partySize,_that.amountCents,_that.checkedInAt,_that.noShowCount,_that.firstVisit,_that.sessionCapacity,_that.sessionBooked);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reference,  String spaceName,  String? customerId,  String? customerName,  String? customerPhone,  String label,  DateTime startsAt,  DateTime endsAt,  ReservationStatus status,  ReservationKind kind,  int partySize,  int amountCents,  DateTime? checkedInAt,  int noShowCount,  bool firstVisit,  int? sessionCapacity,  int? sessionBooked)  $default,) {final _that = this;
switch (_that) {
case _RunSheetEntry():
return $default(_that.id,_that.reference,_that.spaceName,_that.customerId,_that.customerName,_that.customerPhone,_that.label,_that.startsAt,_that.endsAt,_that.status,_that.kind,_that.partySize,_that.amountCents,_that.checkedInAt,_that.noShowCount,_that.firstVisit,_that.sessionCapacity,_that.sessionBooked);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reference,  String spaceName,  String? customerId,  String? customerName,  String? customerPhone,  String label,  DateTime startsAt,  DateTime endsAt,  ReservationStatus status,  ReservationKind kind,  int partySize,  int amountCents,  DateTime? checkedInAt,  int noShowCount,  bool firstVisit,  int? sessionCapacity,  int? sessionBooked)?  $default,) {final _that = this;
switch (_that) {
case _RunSheetEntry() when $default != null:
return $default(_that.id,_that.reference,_that.spaceName,_that.customerId,_that.customerName,_that.customerPhone,_that.label,_that.startsAt,_that.endsAt,_that.status,_that.kind,_that.partySize,_that.amountCents,_that.checkedInAt,_that.noShowCount,_that.firstVisit,_that.sessionCapacity,_that.sessionBooked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RunSheetEntry extends RunSheetEntry {
  const _RunSheetEntry({required this.id, required this.reference, required this.spaceName, this.customerId, this.customerName, this.customerPhone, required this.label, required this.startsAt, required this.endsAt, this.status = ReservationStatus.confirmed, this.kind = ReservationKind.rental, this.partySize = 1, this.amountCents = 0, this.checkedInAt, this.noShowCount = 0, this.firstVisit = false, this.sessionCapacity, this.sessionBooked}): super._();
  factory _RunSheetEntry.fromJson(Map<String, dynamic> json) => _$RunSheetEntryFromJson(json);

@override final  String id;
@override final  String reference;
@override final  String spaceName;
@override final  String? customerId;
@override final  String? customerName;
@override final  String? customerPhone;
/// "18:00–19:00", already in the venue's timezone.
@override final  String label;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override@JsonKey() final  ReservationStatus status;
@override@JsonKey() final  ReservationKind kind;
@override@JsonKey() final  int partySize;
@override@JsonKey() final  int amountCents;
@override final  DateTime? checkedInAt;
@override@JsonKey() final  int noShowCount;
@override@JsonKey() final  bool firstVisit;
/// Session seats roll up into one line: "7 of 12".
@override final  int? sessionCapacity;
@override final  int? sessionBooked;

/// Create a copy of RunSheetEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RunSheetEntryCopyWith<_RunSheetEntry> get copyWith => __$RunSheetEntryCopyWithImpl<_RunSheetEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RunSheetEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RunSheetEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.spaceName, spaceName) || other.spaceName == spaceName)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.label, label) || other.label == label)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.partySize, partySize) || other.partySize == partySize)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.checkedInAt, checkedInAt) || other.checkedInAt == checkedInAt)&&(identical(other.noShowCount, noShowCount) || other.noShowCount == noShowCount)&&(identical(other.firstVisit, firstVisit) || other.firstVisit == firstVisit)&&(identical(other.sessionCapacity, sessionCapacity) || other.sessionCapacity == sessionCapacity)&&(identical(other.sessionBooked, sessionBooked) || other.sessionBooked == sessionBooked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,reference,spaceName,customerId,customerName,customerPhone,label,startsAt,endsAt,status,kind,partySize,amountCents,checkedInAt,noShowCount,firstVisit,sessionCapacity,sessionBooked);
}

@override
String toString() {
    return 'RunSheetEntry(id: $id, reference: $reference, spaceName: $spaceName, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, label: $label, startsAt: $startsAt, endsAt: $endsAt, status: $status, kind: $kind, partySize: $partySize, amountCents: $amountCents, checkedInAt: $checkedInAt, noShowCount: $noShowCount, firstVisit: $firstVisit, sessionCapacity: $sessionCapacity, sessionBooked: $sessionBooked)';
}


}

/// @nodoc
abstract mixin class _$RunSheetEntryCopyWith<$Res> implements $RunSheetEntryCopyWith<$Res> {
  factory _$RunSheetEntryCopyWith(_RunSheetEntry value, $Res Function(_RunSheetEntry) _then) = __$RunSheetEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference, String spaceName, String? customerId, String? customerName, String? customerPhone, String label, DateTime startsAt, DateTime endsAt, ReservationStatus status, ReservationKind kind, int partySize, int amountCents, DateTime? checkedInAt, int noShowCount, bool firstVisit, int? sessionCapacity, int? sessionBooked
});




}
/// @nodoc
class __$RunSheetEntryCopyWithImpl<$Res>
    implements _$RunSheetEntryCopyWith<$Res> {
  __$RunSheetEntryCopyWithImpl(this._self, this._then);

  final _RunSheetEntry _self;
  final $Res Function(_RunSheetEntry) _then;

/// Create a copy of RunSheetEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? spaceName = null,Object? customerId = freezed,Object? customerName = freezed,Object? customerPhone = freezed,Object? label = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,Object? kind = null,Object? partySize = null,Object? amountCents = null,Object? checkedInAt = freezed,Object? noShowCount = null,Object? firstVisit = null,Object? sessionCapacity = freezed,Object? sessionBooked = freezed,}) {
  return _then(_RunSheetEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,spaceName: null == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerPhone: freezed == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReservationKind,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,noShowCount: null == noShowCount ? _self.noShowCount : noShowCount // ignore: cast_nullable_to_non_nullable
as int,firstVisit: null == firstVisit ? _self.firstVisit : firstVisit // ignore: cast_nullable_to_non_nullable
as bool,sessionCapacity: freezed == sessionCapacity ? _self.sessionCapacity : sessionCapacity // ignore: cast_nullable_to_non_nullable
as int?,sessionBooked: freezed == sessionBooked ? _self.sessionBooked : sessionBooked // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$VenueStats {

 int get todayCount; int get checkedIn; int get upcomingCount; int get activeSpaces; int get totalSpaces; int get todayRevenueCents;
/// Create a copy of VenueStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueStatsCopyWith<VenueStats> get copyWith => _$VenueStatsCopyWithImpl<VenueStats>(this as VenueStats, _$identity);

  /// Serializes this VenueStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VenueStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueStats&&(identical(other.todayCount, _this.todayCount) || other.todayCount == _this.todayCount)&&(identical(other.checkedIn, _this.checkedIn) || other.checkedIn == _this.checkedIn)&&(identical(other.upcomingCount, _this.upcomingCount) || other.upcomingCount == _this.upcomingCount)&&(identical(other.activeSpaces, _this.activeSpaces) || other.activeSpaces == _this.activeSpaces)&&(identical(other.totalSpaces, _this.totalSpaces) || other.totalSpaces == _this.totalSpaces)&&(identical(other.todayRevenueCents, _this.todayRevenueCents) || other.todayRevenueCents == _this.todayRevenueCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VenueStats;
  return Object.hash(runtimeType,_this.todayCount,_this.checkedIn,_this.upcomingCount,_this.activeSpaces,_this.totalSpaces,_this.todayRevenueCents);
}

@override
String toString() {
  final _this = this as VenueStats;
  return 'VenueStats(todayCount: ${_this.todayCount}, checkedIn: ${_this.checkedIn}, upcomingCount: ${_this.upcomingCount}, activeSpaces: ${_this.activeSpaces}, totalSpaces: ${_this.totalSpaces}, todayRevenueCents: ${_this.todayRevenueCents})';
}


}

/// @nodoc
abstract mixin class $VenueStatsCopyWith<$Res>  {
  factory $VenueStatsCopyWith(VenueStats value, $Res Function(VenueStats) _then) = _$VenueStatsCopyWithImpl;
@useResult
$Res call({
 int todayCount, int checkedIn, int upcomingCount, int activeSpaces, int totalSpaces, int todayRevenueCents
});




}
/// @nodoc
class _$VenueStatsCopyWithImpl<$Res>
    implements $VenueStatsCopyWith<$Res> {
  _$VenueStatsCopyWithImpl(this._self, this._then);

  final VenueStats _self;
  final $Res Function(VenueStats) _then;

/// Create a copy of VenueStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todayCount = null,Object? checkedIn = null,Object? upcomingCount = null,Object? activeSpaces = null,Object? totalSpaces = null,Object? todayRevenueCents = null,}) {
  return _then(VenueStats(
todayCount: null == todayCount ? _self.todayCount : todayCount // ignore: cast_nullable_to_non_nullable
as int,checkedIn: null == checkedIn ? _self.checkedIn : checkedIn // ignore: cast_nullable_to_non_nullable
as int,upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,totalSpaces: null == totalSpaces ? _self.totalSpaces : totalSpaces // ignore: cast_nullable_to_non_nullable
as int,todayRevenueCents: null == todayRevenueCents ? _self.todayRevenueCents : todayRevenueCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueStats].
extension VenueStatsPatterns on VenueStats {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueStats() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueStats value)  $default,){
final _that = this;
switch (_that) {
case _VenueStats():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueStats value)?  $default,){
final _that = this;
switch (_that) {
case _VenueStats() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int todayCount,  int checkedIn,  int upcomingCount,  int activeSpaces,  int totalSpaces,  int todayRevenueCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueStats() when $default != null:
return $default(_that.todayCount,_that.checkedIn,_that.upcomingCount,_that.activeSpaces,_that.totalSpaces,_that.todayRevenueCents);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int todayCount,  int checkedIn,  int upcomingCount,  int activeSpaces,  int totalSpaces,  int todayRevenueCents)  $default,) {final _that = this;
switch (_that) {
case _VenueStats():
return $default(_that.todayCount,_that.checkedIn,_that.upcomingCount,_that.activeSpaces,_that.totalSpaces,_that.todayRevenueCents);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int todayCount,  int checkedIn,  int upcomingCount,  int activeSpaces,  int totalSpaces,  int todayRevenueCents)?  $default,) {final _that = this;
switch (_that) {
case _VenueStats() when $default != null:
return $default(_that.todayCount,_that.checkedIn,_that.upcomingCount,_that.activeSpaces,_that.totalSpaces,_that.todayRevenueCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VenueStats implements VenueStats {
  const _VenueStats({this.todayCount = 0, this.checkedIn = 0, this.upcomingCount = 0, this.activeSpaces = 0, this.totalSpaces = 0, this.todayRevenueCents = 0});
  factory _VenueStats.fromJson(Map<String, dynamic> json) => _$VenueStatsFromJson(json);

@override@JsonKey() final  int todayCount;
@override@JsonKey() final  int checkedIn;
@override@JsonKey() final  int upcomingCount;
@override@JsonKey() final  int activeSpaces;
@override@JsonKey() final  int totalSpaces;
@override@JsonKey() final  int todayRevenueCents;

/// Create a copy of VenueStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueStatsCopyWith<_VenueStats> get copyWith => __$VenueStatsCopyWithImpl<_VenueStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VenueStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueStats&&(identical(other.todayCount, todayCount) || other.todayCount == todayCount)&&(identical(other.checkedIn, checkedIn) || other.checkedIn == checkedIn)&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.activeSpaces, activeSpaces) || other.activeSpaces == activeSpaces)&&(identical(other.totalSpaces, totalSpaces) || other.totalSpaces == totalSpaces)&&(identical(other.todayRevenueCents, todayRevenueCents) || other.todayRevenueCents == todayRevenueCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,todayCount,checkedIn,upcomingCount,activeSpaces,totalSpaces,todayRevenueCents);
}

@override
String toString() {
    return 'VenueStats(todayCount: $todayCount, checkedIn: $checkedIn, upcomingCount: $upcomingCount, activeSpaces: $activeSpaces, totalSpaces: $totalSpaces, todayRevenueCents: $todayRevenueCents)';
}


}

/// @nodoc
abstract mixin class _$VenueStatsCopyWith<$Res> implements $VenueStatsCopyWith<$Res> {
  factory _$VenueStatsCopyWith(_VenueStats value, $Res Function(_VenueStats) _then) = __$VenueStatsCopyWithImpl;
@override @useResult
$Res call({
 int todayCount, int checkedIn, int upcomingCount, int activeSpaces, int totalSpaces, int todayRevenueCents
});




}
/// @nodoc
class __$VenueStatsCopyWithImpl<$Res>
    implements _$VenueStatsCopyWith<$Res> {
  __$VenueStatsCopyWithImpl(this._self, this._then);

  final _VenueStats _self;
  final $Res Function(_VenueStats) _then;

/// Create a copy of VenueStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todayCount = null,Object? checkedIn = null,Object? upcomingCount = null,Object? activeSpaces = null,Object? totalSpaces = null,Object? todayRevenueCents = null,}) {
  return _then(_VenueStats(
todayCount: null == todayCount ? _self.todayCount : todayCount // ignore: cast_nullable_to_non_nullable
as int,checkedIn: null == checkedIn ? _self.checkedIn : checkedIn // ignore: cast_nullable_to_non_nullable
as int,upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,totalSpaces: null == totalSpaces ? _self.totalSpaces : totalSpaces // ignore: cast_nullable_to_non_nullable
as int,todayRevenueCents: null == todayRevenueCents ? _self.todayRevenueCents : todayRevenueCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TodayView {

/// "2026-09-23", venue-local.
 String get date; VenueStats get stats; List<RunSheetEntry> get runSheet;
/// Create a copy of TodayView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayViewCopyWith<TodayView> get copyWith => _$TodayViewCopyWithImpl<TodayView>(this as TodayView, _$identity);

  /// Serializes this TodayView to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TodayView;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayView&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.stats, _this.stats) || other.stats == _this.stats)&&const DeepCollectionEquality().equals(other.runSheet, _this.runSheet));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TodayView;
  return Object.hash(runtimeType,_this.date,_this.stats,const DeepCollectionEquality().hash(_this.runSheet));
}

@override
String toString() {
  final _this = this as TodayView;
  return 'TodayView(date: ${_this.date}, stats: ${_this.stats}, runSheet: ${_this.runSheet})';
}


}

/// @nodoc
abstract mixin class $TodayViewCopyWith<$Res>  {
  factory $TodayViewCopyWith(TodayView value, $Res Function(TodayView) _then) = _$TodayViewCopyWithImpl;
@useResult
$Res call({
 String date, VenueStats stats, List<RunSheetEntry> runSheet
});


$VenueStatsCopyWith<$Res> get stats;

}
/// @nodoc
class _$TodayViewCopyWithImpl<$Res>
    implements $TodayViewCopyWith<$Res> {
  _$TodayViewCopyWithImpl(this._self, this._then);

  final TodayView _self;
  final $Res Function(TodayView) _then;

/// Create a copy of TodayView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? stats = null,Object? runSheet = null,}) {
  return _then(TodayView(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as VenueStats,runSheet: null == runSheet ? _self.runSheet : runSheet // ignore: cast_nullable_to_non_nullable
as List<RunSheetEntry>,
  ));
}
/// Create a copy of TodayView
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VenueStatsCopyWith<$Res> get stats {
  
  return $VenueStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// Adds pattern-matching-related methods to [TodayView].
extension TodayViewPatterns on TodayView {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayView() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayView value)  $default,){
final _that = this;
switch (_that) {
case _TodayView():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayView value)?  $default,){
final _that = this;
switch (_that) {
case _TodayView() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  VenueStats stats,  List<RunSheetEntry> runSheet)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayView() when $default != null:
return $default(_that.date,_that.stats,_that.runSheet);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  VenueStats stats,  List<RunSheetEntry> runSheet)  $default,) {final _that = this;
switch (_that) {
case _TodayView():
return $default(_that.date,_that.stats,_that.runSheet);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  VenueStats stats,  List<RunSheetEntry> runSheet)?  $default,) {final _that = this;
switch (_that) {
case _TodayView() when $default != null:
return $default(_that.date,_that.stats,_that.runSheet);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodayView implements TodayView {
  const _TodayView({required this.date, this.stats = const VenueStats(),  List<RunSheetEntry> runSheet = const []}): _runSheet = runSheet;
  factory _TodayView.fromJson(Map<String, dynamic> json) => _$TodayViewFromJson(json);

/// "2026-09-23", venue-local.
@override final  String date;
@override@JsonKey() final  VenueStats stats;
 final  List<RunSheetEntry> _runSheet;
@override@JsonKey() List<RunSheetEntry> get runSheet {
  if (_runSheet is EqualUnmodifiableListView) return _runSheet;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_runSheet);
}


/// Create a copy of TodayView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayViewCopyWith<_TodayView> get copyWith => __$TodayViewCopyWithImpl<_TodayView>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodayViewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayView&&(identical(other.date, date) || other.date == date)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other.runSheet, _runSheet));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,stats,const DeepCollectionEquality().hash(_runSheet));
}

@override
String toString() {
    return 'TodayView(date: $date, stats: $stats, runSheet: $runSheet)';
}


}

/// @nodoc
abstract mixin class _$TodayViewCopyWith<$Res> implements $TodayViewCopyWith<$Res> {
  factory _$TodayViewCopyWith(_TodayView value, $Res Function(_TodayView) _then) = __$TodayViewCopyWithImpl;
@override @useResult
$Res call({
 String date, VenueStats stats, List<RunSheetEntry> runSheet
});


@override $VenueStatsCopyWith<$Res> get stats;

}
/// @nodoc
class __$TodayViewCopyWithImpl<$Res>
    implements _$TodayViewCopyWith<$Res> {
  __$TodayViewCopyWithImpl(this._self, this._then);

  final _TodayView _self;
  final $Res Function(_TodayView) _then;

/// Create a copy of TodayView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? stats = null,Object? runSheet = null,}) {
  return _then(_TodayView(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as VenueStats,runSheet: null == runSheet ? _self._runSheet : runSheet // ignore: cast_nullable_to_non_nullable
as List<RunSheetEntry>,
  ));
}

/// Create a copy of TodayView
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VenueStatsCopyWith<$Res> get stats {
  
  return $VenueStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}

// dart format on
