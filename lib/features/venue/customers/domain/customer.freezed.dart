// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomerSummary {

 String get id; String get name; String get email; String? get phone; List<String> get tags; int get bookings; int get lifetimeValueCents; int get noShowCount;/// Whole days since the last confirmed past booking; null if never.
 int? get lastVisitDays; DateTime get createdAt;
/// Create a copy of CustomerSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerSummaryCopyWith<CustomerSummary> get copyWith => _$CustomerSummaryCopyWithImpl<CustomerSummary>(this as CustomerSummary, _$identity);

  /// Serializes this CustomerSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomerSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.bookings, _this.bookings) || other.bookings == _this.bookings)&&(identical(other.lifetimeValueCents, _this.lifetimeValueCents) || other.lifetimeValueCents == _this.lifetimeValueCents)&&(identical(other.noShowCount, _this.noShowCount) || other.noShowCount == _this.noShowCount)&&(identical(other.lastVisitDays, _this.lastVisitDays) || other.lastVisitDays == _this.lastVisitDays)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomerSummary;
  return Object.hash(runtimeType,_this.id,_this.name,_this.email,_this.phone,const DeepCollectionEquality().hash(_this.tags),_this.bookings,_this.lifetimeValueCents,_this.noShowCount,_this.lastVisitDays,_this.createdAt);
}

@override
String toString() {
  final _this = this as CustomerSummary;
  return 'CustomerSummary(id: ${_this.id}, name: ${_this.name}, email: ${_this.email}, phone: ${_this.phone}, tags: ${_this.tags}, bookings: ${_this.bookings}, lifetimeValueCents: ${_this.lifetimeValueCents}, noShowCount: ${_this.noShowCount}, lastVisitDays: ${_this.lastVisitDays}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $CustomerSummaryCopyWith<$Res>  {
  factory $CustomerSummaryCopyWith(CustomerSummary value, $Res Function(CustomerSummary) _then) = _$CustomerSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String? phone, List<String> tags, int bookings, int lifetimeValueCents, int noShowCount, int? lastVisitDays, DateTime createdAt
});




}
/// @nodoc
class _$CustomerSummaryCopyWithImpl<$Res>
    implements $CustomerSummaryCopyWith<$Res> {
  _$CustomerSummaryCopyWithImpl(this._self, this._then);

  final CustomerSummary _self;
  final $Res Function(CustomerSummary) _then;

/// Create a copy of CustomerSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = freezed,Object? tags = null,Object? bookings = null,Object? lifetimeValueCents = null,Object? noShowCount = null,Object? lastVisitDays = freezed,Object? createdAt = null,}) {
  return _then(CustomerSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as int,lifetimeValueCents: null == lifetimeValueCents ? _self.lifetimeValueCents : lifetimeValueCents // ignore: cast_nullable_to_non_nullable
as int,noShowCount: null == noShowCount ? _self.noShowCount : noShowCount // ignore: cast_nullable_to_non_nullable
as int,lastVisitDays: freezed == lastVisitDays ? _self.lastVisitDays : lastVisitDays // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerSummary].
extension CustomerSummaryPatterns on CustomerSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerSummary value)  $default,){
final _that = this;
switch (_that) {
case _CustomerSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String? phone,  List<String> tags,  int bookings,  int lifetimeValueCents,  int noShowCount,  int? lastVisitDays,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerSummary() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.phone,_that.tags,_that.bookings,_that.lifetimeValueCents,_that.noShowCount,_that.lastVisitDays,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String? phone,  List<String> tags,  int bookings,  int lifetimeValueCents,  int noShowCount,  int? lastVisitDays,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CustomerSummary():
return $default(_that.id,_that.name,_that.email,_that.phone,_that.tags,_that.bookings,_that.lifetimeValueCents,_that.noShowCount,_that.lastVisitDays,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String email,  String? phone,  List<String> tags,  int bookings,  int lifetimeValueCents,  int noShowCount,  int? lastVisitDays,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CustomerSummary() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.phone,_that.tags,_that.bookings,_that.lifetimeValueCents,_that.noShowCount,_that.lastVisitDays,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerSummary extends CustomerSummary {
  const _CustomerSummary({required this.id, required this.name, required this.email, this.phone,  List<String> tags = const [], this.bookings = 0, this.lifetimeValueCents = 0, this.noShowCount = 0, this.lastVisitDays, required this.createdAt}): _tags = tags,super._();
  factory _CustomerSummary.fromJson(Map<String, dynamic> json) => _$CustomerSummaryFromJson(json);

@override final  String id;
@override final  String name;
@override final  String email;
@override final  String? phone;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  int bookings;
@override@JsonKey() final  int lifetimeValueCents;
@override@JsonKey() final  int noShowCount;
/// Whole days since the last confirmed past booking; null if never.
@override final  int? lastVisitDays;
@override final  DateTime createdAt;

/// Create a copy of CustomerSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerSummaryCopyWith<_CustomerSummary> get copyWith => __$CustomerSummaryCopyWithImpl<_CustomerSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.bookings, bookings) || other.bookings == bookings)&&(identical(other.lifetimeValueCents, lifetimeValueCents) || other.lifetimeValueCents == lifetimeValueCents)&&(identical(other.noShowCount, noShowCount) || other.noShowCount == noShowCount)&&(identical(other.lastVisitDays, lastVisitDays) || other.lastVisitDays == lastVisitDays)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,email,phone,const DeepCollectionEquality().hash(_tags),bookings,lifetimeValueCents,noShowCount,lastVisitDays,createdAt);
}

@override
String toString() {
    return 'CustomerSummary(id: $id, name: $name, email: $email, phone: $phone, tags: $tags, bookings: $bookings, lifetimeValueCents: $lifetimeValueCents, noShowCount: $noShowCount, lastVisitDays: $lastVisitDays, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CustomerSummaryCopyWith<$Res> implements $CustomerSummaryCopyWith<$Res> {
  factory _$CustomerSummaryCopyWith(_CustomerSummary value, $Res Function(_CustomerSummary) _then) = __$CustomerSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String? phone, List<String> tags, int bookings, int lifetimeValueCents, int noShowCount, int? lastVisitDays, DateTime createdAt
});




}
/// @nodoc
class __$CustomerSummaryCopyWithImpl<$Res>
    implements _$CustomerSummaryCopyWith<$Res> {
  __$CustomerSummaryCopyWithImpl(this._self, this._then);

  final _CustomerSummary _self;
  final $Res Function(_CustomerSummary) _then;

/// Create a copy of CustomerSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = freezed,Object? tags = null,Object? bookings = null,Object? lifetimeValueCents = null,Object? noShowCount = null,Object? lastVisitDays = freezed,Object? createdAt = null,}) {
  return _then(_CustomerSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as int,lifetimeValueCents: null == lifetimeValueCents ? _self.lifetimeValueCents : lifetimeValueCents // ignore: cast_nullable_to_non_nullable
as int,noShowCount: null == noShowCount ? _self.noShowCount : noShowCount // ignore: cast_nullable_to_non_nullable
as int,lastVisitDays: freezed == lastVisitDays ? _self.lastVisitDays : lastVisitDays // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CustomerBooking {

 String get id; String get spaceName;/// "Sat 26 Sep 2026, 17:00", already in the venue's timezone.
 String get whenLabel; DateTime get startsAt; ReservationStatus get status; ReservationKind get kind; int get amountCents; String get reference; DateTime? get checkedInAt;
/// Create a copy of CustomerBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerBookingCopyWith<CustomerBooking> get copyWith => _$CustomerBookingCopyWithImpl<CustomerBooking>(this as CustomerBooking, _$identity);

  /// Serializes this CustomerBooking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomerBooking;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerBooking&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.spaceName, _this.spaceName) || other.spaceName == _this.spaceName)&&(identical(other.whenLabel, _this.whenLabel) || other.whenLabel == _this.whenLabel)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.checkedInAt, _this.checkedInAt) || other.checkedInAt == _this.checkedInAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomerBooking;
  return Object.hash(runtimeType,_this.id,_this.spaceName,_this.whenLabel,_this.startsAt,_this.status,_this.kind,_this.amountCents,_this.reference,_this.checkedInAt);
}

@override
String toString() {
  final _this = this as CustomerBooking;
  return 'CustomerBooking(id: ${_this.id}, spaceName: ${_this.spaceName}, whenLabel: ${_this.whenLabel}, startsAt: ${_this.startsAt}, status: ${_this.status}, kind: ${_this.kind}, amountCents: ${_this.amountCents}, reference: ${_this.reference}, checkedInAt: ${_this.checkedInAt})';
}


}

/// @nodoc
abstract mixin class $CustomerBookingCopyWith<$Res>  {
  factory $CustomerBookingCopyWith(CustomerBooking value, $Res Function(CustomerBooking) _then) = _$CustomerBookingCopyWithImpl;
@useResult
$Res call({
 String id, String spaceName, String whenLabel, DateTime startsAt, ReservationStatus status, ReservationKind kind, int amountCents, String reference, DateTime? checkedInAt
});




}
/// @nodoc
class _$CustomerBookingCopyWithImpl<$Res>
    implements $CustomerBookingCopyWith<$Res> {
  _$CustomerBookingCopyWithImpl(this._self, this._then);

  final CustomerBooking _self;
  final $Res Function(CustomerBooking) _then;

/// Create a copy of CustomerBooking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? spaceName = null,Object? whenLabel = null,Object? startsAt = null,Object? status = null,Object? kind = null,Object? amountCents = null,Object? reference = null,Object? checkedInAt = freezed,}) {
  return _then(CustomerBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,spaceName: null == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String,whenLabel: null == whenLabel ? _self.whenLabel : whenLabel // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReservationKind,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerBooking].
extension CustomerBookingPatterns on CustomerBooking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerBooking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerBooking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerBooking value)  $default,){
final _that = this;
switch (_that) {
case _CustomerBooking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerBooking value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerBooking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String spaceName,  String whenLabel,  DateTime startsAt,  ReservationStatus status,  ReservationKind kind,  int amountCents,  String reference,  DateTime? checkedInAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerBooking() when $default != null:
return $default(_that.id,_that.spaceName,_that.whenLabel,_that.startsAt,_that.status,_that.kind,_that.amountCents,_that.reference,_that.checkedInAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String spaceName,  String whenLabel,  DateTime startsAt,  ReservationStatus status,  ReservationKind kind,  int amountCents,  String reference,  DateTime? checkedInAt)  $default,) {final _that = this;
switch (_that) {
case _CustomerBooking():
return $default(_that.id,_that.spaceName,_that.whenLabel,_that.startsAt,_that.status,_that.kind,_that.amountCents,_that.reference,_that.checkedInAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String spaceName,  String whenLabel,  DateTime startsAt,  ReservationStatus status,  ReservationKind kind,  int amountCents,  String reference,  DateTime? checkedInAt)?  $default,) {final _that = this;
switch (_that) {
case _CustomerBooking() when $default != null:
return $default(_that.id,_that.spaceName,_that.whenLabel,_that.startsAt,_that.status,_that.kind,_that.amountCents,_that.reference,_that.checkedInAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerBooking implements CustomerBooking {
  const _CustomerBooking({required this.id, required this.spaceName, required this.whenLabel, required this.startsAt, this.status = ReservationStatus.confirmed, this.kind = ReservationKind.rental, this.amountCents = 0, required this.reference, this.checkedInAt});
  factory _CustomerBooking.fromJson(Map<String, dynamic> json) => _$CustomerBookingFromJson(json);

@override final  String id;
@override final  String spaceName;
/// "Sat 26 Sep 2026, 17:00", already in the venue's timezone.
@override final  String whenLabel;
@override final  DateTime startsAt;
@override@JsonKey() final  ReservationStatus status;
@override@JsonKey() final  ReservationKind kind;
@override@JsonKey() final  int amountCents;
@override final  String reference;
@override final  DateTime? checkedInAt;

/// Create a copy of CustomerBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerBookingCopyWith<_CustomerBooking> get copyWith => __$CustomerBookingCopyWithImpl<_CustomerBooking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerBookingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.spaceName, spaceName) || other.spaceName == spaceName)&&(identical(other.whenLabel, whenLabel) || other.whenLabel == whenLabel)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.checkedInAt, checkedInAt) || other.checkedInAt == checkedInAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,spaceName,whenLabel,startsAt,status,kind,amountCents,reference,checkedInAt);
}

@override
String toString() {
    return 'CustomerBooking(id: $id, spaceName: $spaceName, whenLabel: $whenLabel, startsAt: $startsAt, status: $status, kind: $kind, amountCents: $amountCents, reference: $reference, checkedInAt: $checkedInAt)';
}


}

/// @nodoc
abstract mixin class _$CustomerBookingCopyWith<$Res> implements $CustomerBookingCopyWith<$Res> {
  factory _$CustomerBookingCopyWith(_CustomerBooking value, $Res Function(_CustomerBooking) _then) = __$CustomerBookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String spaceName, String whenLabel, DateTime startsAt, ReservationStatus status, ReservationKind kind, int amountCents, String reference, DateTime? checkedInAt
});




}
/// @nodoc
class __$CustomerBookingCopyWithImpl<$Res>
    implements _$CustomerBookingCopyWith<$Res> {
  __$CustomerBookingCopyWithImpl(this._self, this._then);

  final _CustomerBooking _self;
  final $Res Function(_CustomerBooking) _then;

/// Create a copy of CustomerBooking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? spaceName = null,Object? whenLabel = null,Object? startsAt = null,Object? status = null,Object? kind = null,Object? amountCents = null,Object? reference = null,Object? checkedInAt = freezed,}) {
  return _then(_CustomerBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,spaceName: null == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String,whenLabel: null == whenLabel ? _self.whenLabel : whenLabel // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReservationKind,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CustomerNote {

 String get id; String get body; String? get authorName; DateTime get createdAt;
/// Create a copy of CustomerNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerNoteCopyWith<CustomerNote> get copyWith => _$CustomerNoteCopyWithImpl<CustomerNote>(this as CustomerNote, _$identity);

  /// Serializes this CustomerNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomerNote;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerNote&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomerNote;
  return Object.hash(runtimeType,_this.id,_this.body,_this.authorName,_this.createdAt);
}

@override
String toString() {
  final _this = this as CustomerNote;
  return 'CustomerNote(id: ${_this.id}, body: ${_this.body}, authorName: ${_this.authorName}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $CustomerNoteCopyWith<$Res>  {
  factory $CustomerNoteCopyWith(CustomerNote value, $Res Function(CustomerNote) _then) = _$CustomerNoteCopyWithImpl;
@useResult
$Res call({
 String id, String body, String? authorName, DateTime createdAt
});




}
/// @nodoc
class _$CustomerNoteCopyWithImpl<$Res>
    implements $CustomerNoteCopyWith<$Res> {
  _$CustomerNoteCopyWithImpl(this._self, this._then);

  final CustomerNote _self;
  final $Res Function(CustomerNote) _then;

/// Create a copy of CustomerNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? body = null,Object? authorName = freezed,Object? createdAt = null,}) {
  return _then(CustomerNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerNote].
extension CustomerNotePatterns on CustomerNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerNote value)  $default,){
final _that = this;
switch (_that) {
case _CustomerNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerNote value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String body,  String? authorName,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerNote() when $default != null:
return $default(_that.id,_that.body,_that.authorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String body,  String? authorName,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CustomerNote():
return $default(_that.id,_that.body,_that.authorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String body,  String? authorName,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CustomerNote() when $default != null:
return $default(_that.id,_that.body,_that.authorName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerNote implements CustomerNote {
  const _CustomerNote({required this.id, required this.body, this.authorName, required this.createdAt});
  factory _CustomerNote.fromJson(Map<String, dynamic> json) => _$CustomerNoteFromJson(json);

@override final  String id;
@override final  String body;
@override final  String? authorName;
@override final  DateTime createdAt;

/// Create a copy of CustomerNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerNoteCopyWith<_CustomerNote> get copyWith => __$CustomerNoteCopyWithImpl<_CustomerNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerNoteToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerNote&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,body,authorName,createdAt);
}

@override
String toString() {
    return 'CustomerNote(id: $id, body: $body, authorName: $authorName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CustomerNoteCopyWith<$Res> implements $CustomerNoteCopyWith<$Res> {
  factory _$CustomerNoteCopyWith(_CustomerNote value, $Res Function(_CustomerNote) _then) = __$CustomerNoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String body, String? authorName, DateTime createdAt
});




}
/// @nodoc
class __$CustomerNoteCopyWithImpl<$Res>
    implements _$CustomerNoteCopyWith<$Res> {
  __$CustomerNoteCopyWithImpl(this._self, this._then);

  final _CustomerNote _self;
  final $Res Function(_CustomerNote) _then;

/// Create a copy of CustomerNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? body = null,Object? authorName = freezed,Object? createdAt = null,}) {
  return _then(_CustomerNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CustomerProfile {

 CustomerSummary get customer; List<CustomerBooking> get upcoming; List<CustomerBooking> get past; List<CustomerNote> get notes; DateTime? get lastVisit;
/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerProfileCopyWith<CustomerProfile> get copyWith => _$CustomerProfileCopyWithImpl<CustomerProfile>(this as CustomerProfile, _$identity);

  /// Serializes this CustomerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomerProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerProfile&&(identical(other.customer, _this.customer) || other.customer == _this.customer)&&const DeepCollectionEquality().equals(other.upcoming, _this.upcoming)&&const DeepCollectionEquality().equals(other.past, _this.past)&&const DeepCollectionEquality().equals(other.notes, _this.notes)&&(identical(other.lastVisit, _this.lastVisit) || other.lastVisit == _this.lastVisit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomerProfile;
  return Object.hash(runtimeType,_this.customer,const DeepCollectionEquality().hash(_this.upcoming),const DeepCollectionEquality().hash(_this.past),const DeepCollectionEquality().hash(_this.notes),_this.lastVisit);
}

@override
String toString() {
  final _this = this as CustomerProfile;
  return 'CustomerProfile(customer: ${_this.customer}, upcoming: ${_this.upcoming}, past: ${_this.past}, notes: ${_this.notes}, lastVisit: ${_this.lastVisit})';
}


}

/// @nodoc
abstract mixin class $CustomerProfileCopyWith<$Res>  {
  factory $CustomerProfileCopyWith(CustomerProfile value, $Res Function(CustomerProfile) _then) = _$CustomerProfileCopyWithImpl;
@useResult
$Res call({
 CustomerSummary customer, List<CustomerBooking> upcoming, List<CustomerBooking> past, List<CustomerNote> notes, DateTime? lastVisit
});


$CustomerSummaryCopyWith<$Res> get customer;

}
/// @nodoc
class _$CustomerProfileCopyWithImpl<$Res>
    implements $CustomerProfileCopyWith<$Res> {
  _$CustomerProfileCopyWithImpl(this._self, this._then);

  final CustomerProfile _self;
  final $Res Function(CustomerProfile) _then;

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customer = null,Object? upcoming = null,Object? past = null,Object? notes = null,Object? lastVisit = freezed,}) {
  return _then(CustomerProfile(
customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as CustomerSummary,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<CustomerBooking>,past: null == past ? _self.past : past // ignore: cast_nullable_to_non_nullable
as List<CustomerBooking>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<CustomerNote>,lastVisit: freezed == lastVisit ? _self.lastVisit : lastVisit // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerSummaryCopyWith<$Res> get customer {
  
  return $CustomerSummaryCopyWith<$Res>(_self.customer, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomerProfile].
extension CustomerProfilePatterns on CustomerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerProfile value)  $default,){
final _that = this;
switch (_that) {
case _CustomerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CustomerSummary customer,  List<CustomerBooking> upcoming,  List<CustomerBooking> past,  List<CustomerNote> notes,  DateTime? lastVisit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
return $default(_that.customer,_that.upcoming,_that.past,_that.notes,_that.lastVisit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CustomerSummary customer,  List<CustomerBooking> upcoming,  List<CustomerBooking> past,  List<CustomerNote> notes,  DateTime? lastVisit)  $default,) {final _that = this;
switch (_that) {
case _CustomerProfile():
return $default(_that.customer,_that.upcoming,_that.past,_that.notes,_that.lastVisit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CustomerSummary customer,  List<CustomerBooking> upcoming,  List<CustomerBooking> past,  List<CustomerNote> notes,  DateTime? lastVisit)?  $default,) {final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
return $default(_that.customer,_that.upcoming,_that.past,_that.notes,_that.lastVisit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerProfile implements CustomerProfile {
  const _CustomerProfile({required this.customer,  List<CustomerBooking> upcoming = const [],  List<CustomerBooking> past = const [],  List<CustomerNote> notes = const [], this.lastVisit}): _upcoming = upcoming,_past = past,_notes = notes;
  factory _CustomerProfile.fromJson(Map<String, dynamic> json) => _$CustomerProfileFromJson(json);

@override final  CustomerSummary customer;
 final  List<CustomerBooking> _upcoming;
@override@JsonKey() List<CustomerBooking> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

 final  List<CustomerBooking> _past;
@override@JsonKey() List<CustomerBooking> get past {
  if (_past is EqualUnmodifiableListView) return _past;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_past);
}

 final  List<CustomerNote> _notes;
@override@JsonKey() List<CustomerNote> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

@override final  DateTime? lastVisit;

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerProfileCopyWith<_CustomerProfile> get copyWith => __$CustomerProfileCopyWithImpl<_CustomerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerProfile&&(identical(other.customer, customer) || other.customer == customer)&&const DeepCollectionEquality().equals(other.upcoming, _upcoming)&&const DeepCollectionEquality().equals(other.past, _past)&&const DeepCollectionEquality().equals(other.notes, _notes)&&(identical(other.lastVisit, lastVisit) || other.lastVisit == lastVisit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,customer,const DeepCollectionEquality().hash(_upcoming),const DeepCollectionEquality().hash(_past),const DeepCollectionEquality().hash(_notes),lastVisit);
}

@override
String toString() {
    return 'CustomerProfile(customer: $customer, upcoming: $upcoming, past: $past, notes: $notes, lastVisit: $lastVisit)';
}


}

/// @nodoc
abstract mixin class _$CustomerProfileCopyWith<$Res> implements $CustomerProfileCopyWith<$Res> {
  factory _$CustomerProfileCopyWith(_CustomerProfile value, $Res Function(_CustomerProfile) _then) = __$CustomerProfileCopyWithImpl;
@override @useResult
$Res call({
 CustomerSummary customer, List<CustomerBooking> upcoming, List<CustomerBooking> past, List<CustomerNote> notes, DateTime? lastVisit
});


@override $CustomerSummaryCopyWith<$Res> get customer;

}
/// @nodoc
class __$CustomerProfileCopyWithImpl<$Res>
    implements _$CustomerProfileCopyWith<$Res> {
  __$CustomerProfileCopyWithImpl(this._self, this._then);

  final _CustomerProfile _self;
  final $Res Function(_CustomerProfile) _then;

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customer = null,Object? upcoming = null,Object? past = null,Object? notes = null,Object? lastVisit = freezed,}) {
  return _then(_CustomerProfile(
customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as CustomerSummary,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<CustomerBooking>,past: null == past ? _self._past : past // ignore: cast_nullable_to_non_nullable
as List<CustomerBooking>,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<CustomerNote>,lastVisit: freezed == lastVisit ? _self.lastVisit : lastVisit // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerSummaryCopyWith<$Res> get customer {
  
  return $CustomerSummaryCopyWith<$Res>(_self.customer, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}


/// @nodoc
mixin _$CustomerPage {

 List<CustomerSummary> get rows; int get total;
/// Create a copy of CustomerPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerPageCopyWith<CustomerPage> get copyWith => _$CustomerPageCopyWithImpl<CustomerPage>(this as CustomerPage, _$identity);

  /// Serializes this CustomerPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomerPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerPage&&const DeepCollectionEquality().equals(other.rows, _this.rows)&&(identical(other.total, _this.total) || other.total == _this.total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomerPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.rows),_this.total);
}

@override
String toString() {
  final _this = this as CustomerPage;
  return 'CustomerPage(rows: ${_this.rows}, total: ${_this.total})';
}


}

/// @nodoc
abstract mixin class $CustomerPageCopyWith<$Res>  {
  factory $CustomerPageCopyWith(CustomerPage value, $Res Function(CustomerPage) _then) = _$CustomerPageCopyWithImpl;
@useResult
$Res call({
 List<CustomerSummary> rows, int total
});




}
/// @nodoc
class _$CustomerPageCopyWithImpl<$Res>
    implements $CustomerPageCopyWith<$Res> {
  _$CustomerPageCopyWithImpl(this._self, this._then);

  final CustomerPage _self;
  final $Res Function(CustomerPage) _then;

/// Create a copy of CustomerPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rows = null,Object? total = null,}) {
  return _then(CustomerPage(
rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<CustomerSummary>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerPage].
extension CustomerPagePatterns on CustomerPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerPage value)  $default,){
final _that = this;
switch (_that) {
case _CustomerPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerPage value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CustomerSummary> rows,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerPage() when $default != null:
return $default(_that.rows,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CustomerSummary> rows,  int total)  $default,) {final _that = this;
switch (_that) {
case _CustomerPage():
return $default(_that.rows,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CustomerSummary> rows,  int total)?  $default,) {final _that = this;
switch (_that) {
case _CustomerPage() when $default != null:
return $default(_that.rows,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerPage implements CustomerPage {
  const _CustomerPage({ List<CustomerSummary> rows = const [], this.total = 0}): _rows = rows;
  factory _CustomerPage.fromJson(Map<String, dynamic> json) => _$CustomerPageFromJson(json);

 final  List<CustomerSummary> _rows;
@override@JsonKey() List<CustomerSummary> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}

@override@JsonKey() final  int total;

/// Create a copy of CustomerPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerPageCopyWith<_CustomerPage> get copyWith => __$CustomerPageCopyWithImpl<_CustomerPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerPage&&const DeepCollectionEquality().equals(other.rows, _rows)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_rows),total);
}

@override
String toString() {
    return 'CustomerPage(rows: $rows, total: $total)';
}


}

/// @nodoc
abstract mixin class _$CustomerPageCopyWith<$Res> implements $CustomerPageCopyWith<$Res> {
  factory _$CustomerPageCopyWith(_CustomerPage value, $Res Function(_CustomerPage) _then) = __$CustomerPageCopyWithImpl;
@override @useResult
$Res call({
 List<CustomerSummary> rows, int total
});




}
/// @nodoc
class __$CustomerPageCopyWithImpl<$Res>
    implements _$CustomerPageCopyWith<$Res> {
  __$CustomerPageCopyWithImpl(this._self, this._then);

  final _CustomerPage _self;
  final $Res Function(_CustomerPage) _then;

/// Create a copy of CustomerPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rows = null,Object? total = null,}) {
  return _then(_CustomerPage(
rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<CustomerSummary>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
