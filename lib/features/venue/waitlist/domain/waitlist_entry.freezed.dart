// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waitlist_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WaitlistEntry {

 String get id; String get customerName; String? get customerEmail; String? get customerPhone; String get spaceName; DateTime get startsAt; DateTime get endsAt;/// "Sat 26 Sep · 12:00", in the venue's timezone.
 String get whenLabel; WaitlistStatus get status; DateTime get createdAt; DateTime? get notifiedAt; DateTime? get claimExpiresAt;
/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaitlistEntryCopyWith<WaitlistEntry> get copyWith => _$WaitlistEntryCopyWithImpl<WaitlistEntry>(this as WaitlistEntry, _$identity);

  /// Serializes this WaitlistEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WaitlistEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaitlistEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.customerName, _this.customerName) || other.customerName == _this.customerName)&&(identical(other.customerEmail, _this.customerEmail) || other.customerEmail == _this.customerEmail)&&(identical(other.customerPhone, _this.customerPhone) || other.customerPhone == _this.customerPhone)&&(identical(other.spaceName, _this.spaceName) || other.spaceName == _this.spaceName)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.whenLabel, _this.whenLabel) || other.whenLabel == _this.whenLabel)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.notifiedAt, _this.notifiedAt) || other.notifiedAt == _this.notifiedAt)&&(identical(other.claimExpiresAt, _this.claimExpiresAt) || other.claimExpiresAt == _this.claimExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WaitlistEntry;
  return Object.hash(runtimeType,_this.id,_this.customerName,_this.customerEmail,_this.customerPhone,_this.spaceName,_this.startsAt,_this.endsAt,_this.whenLabel,_this.status,_this.createdAt,_this.notifiedAt,_this.claimExpiresAt);
}

@override
String toString() {
  final _this = this as WaitlistEntry;
  return 'WaitlistEntry(id: ${_this.id}, customerName: ${_this.customerName}, customerEmail: ${_this.customerEmail}, customerPhone: ${_this.customerPhone}, spaceName: ${_this.spaceName}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, whenLabel: ${_this.whenLabel}, status: ${_this.status}, createdAt: ${_this.createdAt}, notifiedAt: ${_this.notifiedAt}, claimExpiresAt: ${_this.claimExpiresAt})';
}


}

/// @nodoc
abstract mixin class $WaitlistEntryCopyWith<$Res>  {
  factory $WaitlistEntryCopyWith(WaitlistEntry value, $Res Function(WaitlistEntry) _then) = _$WaitlistEntryCopyWithImpl;
@useResult
$Res call({
 String id, String customerName, String? customerEmail, String? customerPhone, String spaceName, DateTime startsAt, DateTime endsAt, String whenLabel, WaitlistStatus status, DateTime createdAt, DateTime? notifiedAt, DateTime? claimExpiresAt
});




}
/// @nodoc
class _$WaitlistEntryCopyWithImpl<$Res>
    implements $WaitlistEntryCopyWith<$Res> {
  _$WaitlistEntryCopyWithImpl(this._self, this._then);

  final WaitlistEntry _self;
  final $Res Function(WaitlistEntry) _then;

/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerName = null,Object? customerEmail = freezed,Object? customerPhone = freezed,Object? spaceName = null,Object? startsAt = null,Object? endsAt = null,Object? whenLabel = null,Object? status = null,Object? createdAt = null,Object? notifiedAt = freezed,Object? claimExpiresAt = freezed,}) {
  return _then(WaitlistEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerEmail: freezed == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String?,customerPhone: freezed == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String?,spaceName: null == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,whenLabel: null == whenLabel ? _self.whenLabel : whenLabel // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WaitlistStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,notifiedAt: freezed == notifiedAt ? _self.notifiedAt : notifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimExpiresAt: freezed == claimExpiresAt ? _self.claimExpiresAt : claimExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WaitlistEntry].
extension WaitlistEntryPatterns on WaitlistEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaitlistEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaitlistEntry value)  $default,){
final _that = this;
switch (_that) {
case _WaitlistEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaitlistEntry value)?  $default,){
final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerName,  String? customerEmail,  String? customerPhone,  String spaceName,  DateTime startsAt,  DateTime endsAt,  String whenLabel,  WaitlistStatus status,  DateTime createdAt,  DateTime? notifiedAt,  DateTime? claimExpiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
return $default(_that.id,_that.customerName,_that.customerEmail,_that.customerPhone,_that.spaceName,_that.startsAt,_that.endsAt,_that.whenLabel,_that.status,_that.createdAt,_that.notifiedAt,_that.claimExpiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerName,  String? customerEmail,  String? customerPhone,  String spaceName,  DateTime startsAt,  DateTime endsAt,  String whenLabel,  WaitlistStatus status,  DateTime createdAt,  DateTime? notifiedAt,  DateTime? claimExpiresAt)  $default,) {final _that = this;
switch (_that) {
case _WaitlistEntry():
return $default(_that.id,_that.customerName,_that.customerEmail,_that.customerPhone,_that.spaceName,_that.startsAt,_that.endsAt,_that.whenLabel,_that.status,_that.createdAt,_that.notifiedAt,_that.claimExpiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerName,  String? customerEmail,  String? customerPhone,  String spaceName,  DateTime startsAt,  DateTime endsAt,  String whenLabel,  WaitlistStatus status,  DateTime createdAt,  DateTime? notifiedAt,  DateTime? claimExpiresAt)?  $default,) {final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
return $default(_that.id,_that.customerName,_that.customerEmail,_that.customerPhone,_that.spaceName,_that.startsAt,_that.endsAt,_that.whenLabel,_that.status,_that.createdAt,_that.notifiedAt,_that.claimExpiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WaitlistEntry extends WaitlistEntry {
  const _WaitlistEntry({required this.id, required this.customerName, this.customerEmail, this.customerPhone, required this.spaceName, required this.startsAt, required this.endsAt, required this.whenLabel, this.status = WaitlistStatus.waiting, required this.createdAt, this.notifiedAt, this.claimExpiresAt}): super._();
  factory _WaitlistEntry.fromJson(Map<String, dynamic> json) => _$WaitlistEntryFromJson(json);

@override final  String id;
@override final  String customerName;
@override final  String? customerEmail;
@override final  String? customerPhone;
@override final  String spaceName;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
/// "Sat 26 Sep · 12:00", in the venue's timezone.
@override final  String whenLabel;
@override@JsonKey() final  WaitlistStatus status;
@override final  DateTime createdAt;
@override final  DateTime? notifiedAt;
@override final  DateTime? claimExpiresAt;

/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitlistEntryCopyWith<_WaitlistEntry> get copyWith => __$WaitlistEntryCopyWithImpl<_WaitlistEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitlistEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitlistEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.spaceName, spaceName) || other.spaceName == spaceName)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.whenLabel, whenLabel) || other.whenLabel == whenLabel)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.notifiedAt, notifiedAt) || other.notifiedAt == notifiedAt)&&(identical(other.claimExpiresAt, claimExpiresAt) || other.claimExpiresAt == claimExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,customerName,customerEmail,customerPhone,spaceName,startsAt,endsAt,whenLabel,status,createdAt,notifiedAt,claimExpiresAt);
}

@override
String toString() {
    return 'WaitlistEntry(id: $id, customerName: $customerName, customerEmail: $customerEmail, customerPhone: $customerPhone, spaceName: $spaceName, startsAt: $startsAt, endsAt: $endsAt, whenLabel: $whenLabel, status: $status, createdAt: $createdAt, notifiedAt: $notifiedAt, claimExpiresAt: $claimExpiresAt)';
}


}

/// @nodoc
abstract mixin class _$WaitlistEntryCopyWith<$Res> implements $WaitlistEntryCopyWith<$Res> {
  factory _$WaitlistEntryCopyWith(_WaitlistEntry value, $Res Function(_WaitlistEntry) _then) = __$WaitlistEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerName, String? customerEmail, String? customerPhone, String spaceName, DateTime startsAt, DateTime endsAt, String whenLabel, WaitlistStatus status, DateTime createdAt, DateTime? notifiedAt, DateTime? claimExpiresAt
});




}
/// @nodoc
class __$WaitlistEntryCopyWithImpl<$Res>
    implements _$WaitlistEntryCopyWith<$Res> {
  __$WaitlistEntryCopyWithImpl(this._self, this._then);

  final _WaitlistEntry _self;
  final $Res Function(_WaitlistEntry) _then;

/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerName = null,Object? customerEmail = freezed,Object? customerPhone = freezed,Object? spaceName = null,Object? startsAt = null,Object? endsAt = null,Object? whenLabel = null,Object? status = null,Object? createdAt = null,Object? notifiedAt = freezed,Object? claimExpiresAt = freezed,}) {
  return _then(_WaitlistEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerEmail: freezed == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String?,customerPhone: freezed == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String?,spaceName: null == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,whenLabel: null == whenLabel ? _self.whenLabel : whenLabel // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WaitlistStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,notifiedAt: freezed == notifiedAt ? _self.notifiedAt : notifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimExpiresAt: freezed == claimExpiresAt ? _self.claimExpiresAt : claimExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
