// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarItem {

 String get id; CalendarItemKind get kind; DateTime get startsAt; DateTime get endsAt;/// "18:00–19:00" in the venue's timezone.
 String get label;/// Customer name, block reason, or session title — whatever names the row.
 String get title; String? get subtitle; String? get customerId; String? get reference; ReservationStatus get status; DateTime? get checkedInAt; int get amountCents; int get partySize; int get noShowCount; int? get sessionCapacity; int? get sessionBooked;
/// Create a copy of CalendarItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarItemCopyWith<CalendarItem> get copyWith => _$CalendarItemCopyWithImpl<CalendarItem>(this as CalendarItem, _$identity);

  /// Serializes this CalendarItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CalendarItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.checkedInAt, _this.checkedInAt) || other.checkedInAt == _this.checkedInAt)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.partySize, _this.partySize) || other.partySize == _this.partySize)&&(identical(other.noShowCount, _this.noShowCount) || other.noShowCount == _this.noShowCount)&&(identical(other.sessionCapacity, _this.sessionCapacity) || other.sessionCapacity == _this.sessionCapacity)&&(identical(other.sessionBooked, _this.sessionBooked) || other.sessionBooked == _this.sessionBooked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CalendarItem;
  return Object.hash(runtimeType,_this.id,_this.kind,_this.startsAt,_this.endsAt,_this.label,_this.title,_this.subtitle,_this.customerId,_this.reference,_this.status,_this.checkedInAt,_this.amountCents,_this.partySize,_this.noShowCount,_this.sessionCapacity,_this.sessionBooked);
}

@override
String toString() {
  final _this = this as CalendarItem;
  return 'CalendarItem(id: ${_this.id}, kind: ${_this.kind}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, label: ${_this.label}, title: ${_this.title}, subtitle: ${_this.subtitle}, customerId: ${_this.customerId}, reference: ${_this.reference}, status: ${_this.status}, checkedInAt: ${_this.checkedInAt}, amountCents: ${_this.amountCents}, partySize: ${_this.partySize}, noShowCount: ${_this.noShowCount}, sessionCapacity: ${_this.sessionCapacity}, sessionBooked: ${_this.sessionBooked})';
}


}

/// @nodoc
abstract mixin class $CalendarItemCopyWith<$Res>  {
  factory $CalendarItemCopyWith(CalendarItem value, $Res Function(CalendarItem) _then) = _$CalendarItemCopyWithImpl;
@useResult
$Res call({
 String id, CalendarItemKind kind, DateTime startsAt, DateTime endsAt, String label, String title, String? subtitle, String? customerId, String? reference, ReservationStatus status, DateTime? checkedInAt, int amountCents, int partySize, int noShowCount, int? sessionCapacity, int? sessionBooked
});




}
/// @nodoc
class _$CalendarItemCopyWithImpl<$Res>
    implements $CalendarItemCopyWith<$Res> {
  _$CalendarItemCopyWithImpl(this._self, this._then);

  final CalendarItem _self;
  final $Res Function(CalendarItem) _then;

/// Create a copy of CalendarItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? startsAt = null,Object? endsAt = null,Object? label = null,Object? title = null,Object? subtitle = freezed,Object? customerId = freezed,Object? reference = freezed,Object? status = null,Object? checkedInAt = freezed,Object? amountCents = null,Object? partySize = null,Object? noShowCount = null,Object? sessionCapacity = freezed,Object? sessionBooked = freezed,}) {
  return _then(CalendarItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CalendarItemKind,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,noShowCount: null == noShowCount ? _self.noShowCount : noShowCount // ignore: cast_nullable_to_non_nullable
as int,sessionCapacity: freezed == sessionCapacity ? _self.sessionCapacity : sessionCapacity // ignore: cast_nullable_to_non_nullable
as int?,sessionBooked: freezed == sessionBooked ? _self.sessionBooked : sessionBooked // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarItem].
extension CalendarItemPatterns on CalendarItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarItem value)  $default,){
final _that = this;
switch (_that) {
case _CalendarItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarItem value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  CalendarItemKind kind,  DateTime startsAt,  DateTime endsAt,  String label,  String title,  String? subtitle,  String? customerId,  String? reference,  ReservationStatus status,  DateTime? checkedInAt,  int amountCents,  int partySize,  int noShowCount,  int? sessionCapacity,  int? sessionBooked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarItem() when $default != null:
return $default(_that.id,_that.kind,_that.startsAt,_that.endsAt,_that.label,_that.title,_that.subtitle,_that.customerId,_that.reference,_that.status,_that.checkedInAt,_that.amountCents,_that.partySize,_that.noShowCount,_that.sessionCapacity,_that.sessionBooked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  CalendarItemKind kind,  DateTime startsAt,  DateTime endsAt,  String label,  String title,  String? subtitle,  String? customerId,  String? reference,  ReservationStatus status,  DateTime? checkedInAt,  int amountCents,  int partySize,  int noShowCount,  int? sessionCapacity,  int? sessionBooked)  $default,) {final _that = this;
switch (_that) {
case _CalendarItem():
return $default(_that.id,_that.kind,_that.startsAt,_that.endsAt,_that.label,_that.title,_that.subtitle,_that.customerId,_that.reference,_that.status,_that.checkedInAt,_that.amountCents,_that.partySize,_that.noShowCount,_that.sessionCapacity,_that.sessionBooked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  CalendarItemKind kind,  DateTime startsAt,  DateTime endsAt,  String label,  String title,  String? subtitle,  String? customerId,  String? reference,  ReservationStatus status,  DateTime? checkedInAt,  int amountCents,  int partySize,  int noShowCount,  int? sessionCapacity,  int? sessionBooked)?  $default,) {final _that = this;
switch (_that) {
case _CalendarItem() when $default != null:
return $default(_that.id,_that.kind,_that.startsAt,_that.endsAt,_that.label,_that.title,_that.subtitle,_that.customerId,_that.reference,_that.status,_that.checkedInAt,_that.amountCents,_that.partySize,_that.noShowCount,_that.sessionCapacity,_that.sessionBooked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarItem extends CalendarItem {
  const _CalendarItem({required this.id, required this.kind, required this.startsAt, required this.endsAt, required this.label, required this.title, this.subtitle, this.customerId, this.reference, this.status = ReservationStatus.confirmed, this.checkedInAt, this.amountCents = 0, this.partySize = 1, this.noShowCount = 0, this.sessionCapacity, this.sessionBooked}): super._();
  factory _CalendarItem.fromJson(Map<String, dynamic> json) => _$CalendarItemFromJson(json);

@override final  String id;
@override final  CalendarItemKind kind;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
/// "18:00–19:00" in the venue's timezone.
@override final  String label;
/// Customer name, block reason, or session title — whatever names the row.
@override final  String title;
@override final  String? subtitle;
@override final  String? customerId;
@override final  String? reference;
@override@JsonKey() final  ReservationStatus status;
@override final  DateTime? checkedInAt;
@override@JsonKey() final  int amountCents;
@override@JsonKey() final  int partySize;
@override@JsonKey() final  int noShowCount;
@override final  int? sessionCapacity;
@override final  int? sessionBooked;

/// Create a copy of CalendarItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarItemCopyWith<_CalendarItem> get copyWith => __$CalendarItemCopyWithImpl<_CalendarItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarItem&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.label, label) || other.label == label)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.status, status) || other.status == status)&&(identical(other.checkedInAt, checkedInAt) || other.checkedInAt == checkedInAt)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.partySize, partySize) || other.partySize == partySize)&&(identical(other.noShowCount, noShowCount) || other.noShowCount == noShowCount)&&(identical(other.sessionCapacity, sessionCapacity) || other.sessionCapacity == sessionCapacity)&&(identical(other.sessionBooked, sessionBooked) || other.sessionBooked == sessionBooked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,startsAt,endsAt,label,title,subtitle,customerId,reference,status,checkedInAt,amountCents,partySize,noShowCount,sessionCapacity,sessionBooked);
}

@override
String toString() {
    return 'CalendarItem(id: $id, kind: $kind, startsAt: $startsAt, endsAt: $endsAt, label: $label, title: $title, subtitle: $subtitle, customerId: $customerId, reference: $reference, status: $status, checkedInAt: $checkedInAt, amountCents: $amountCents, partySize: $partySize, noShowCount: $noShowCount, sessionCapacity: $sessionCapacity, sessionBooked: $sessionBooked)';
}


}

/// @nodoc
abstract mixin class _$CalendarItemCopyWith<$Res> implements $CalendarItemCopyWith<$Res> {
  factory _$CalendarItemCopyWith(_CalendarItem value, $Res Function(_CalendarItem) _then) = __$CalendarItemCopyWithImpl;
@override @useResult
$Res call({
 String id, CalendarItemKind kind, DateTime startsAt, DateTime endsAt, String label, String title, String? subtitle, String? customerId, String? reference, ReservationStatus status, DateTime? checkedInAt, int amountCents, int partySize, int noShowCount, int? sessionCapacity, int? sessionBooked
});




}
/// @nodoc
class __$CalendarItemCopyWithImpl<$Res>
    implements _$CalendarItemCopyWith<$Res> {
  __$CalendarItemCopyWithImpl(this._self, this._then);

  final _CalendarItem _self;
  final $Res Function(_CalendarItem) _then;

/// Create a copy of CalendarItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? startsAt = null,Object? endsAt = null,Object? label = null,Object? title = null,Object? subtitle = freezed,Object? customerId = freezed,Object? reference = freezed,Object? status = null,Object? checkedInAt = freezed,Object? amountCents = null,Object? partySize = null,Object? noShowCount = null,Object? sessionCapacity = freezed,Object? sessionBooked = freezed,}) {
  return _then(_CalendarItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CalendarItemKind,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,noShowCount: null == noShowCount ? _self.noShowCount : noShowCount // ignore: cast_nullable_to_non_nullable
as int,sessionCapacity: freezed == sessionCapacity ? _self.sessionCapacity : sessionCapacity // ignore: cast_nullable_to_non_nullable
as int?,sessionBooked: freezed == sessionBooked ? _self.sessionBooked : sessionBooked // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CalendarLane {

 String get spaceId; String get spaceName; int get slotMinutes; bool get isActive; List<CalendarItem> get items;
/// Create a copy of CalendarLane
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarLaneCopyWith<CalendarLane> get copyWith => _$CalendarLaneCopyWithImpl<CalendarLane>(this as CalendarLane, _$identity);

  /// Serializes this CalendarLane to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CalendarLane;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarLane&&(identical(other.spaceId, _this.spaceId) || other.spaceId == _this.spaceId)&&(identical(other.spaceName, _this.spaceName) || other.spaceName == _this.spaceName)&&(identical(other.slotMinutes, _this.slotMinutes) || other.slotMinutes == _this.slotMinutes)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CalendarLane;
  return Object.hash(runtimeType,_this.spaceId,_this.spaceName,_this.slotMinutes,_this.isActive,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as CalendarLane;
  return 'CalendarLane(spaceId: ${_this.spaceId}, spaceName: ${_this.spaceName}, slotMinutes: ${_this.slotMinutes}, isActive: ${_this.isActive}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $CalendarLaneCopyWith<$Res>  {
  factory $CalendarLaneCopyWith(CalendarLane value, $Res Function(CalendarLane) _then) = _$CalendarLaneCopyWithImpl;
@useResult
$Res call({
 String spaceId, String spaceName, int slotMinutes, bool isActive, List<CalendarItem> items
});




}
/// @nodoc
class _$CalendarLaneCopyWithImpl<$Res>
    implements $CalendarLaneCopyWith<$Res> {
  _$CalendarLaneCopyWithImpl(this._self, this._then);

  final CalendarLane _self;
  final $Res Function(CalendarLane) _then;

/// Create a copy of CalendarLane
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? spaceId = null,Object? spaceName = null,Object? slotMinutes = null,Object? isActive = null,Object? items = null,}) {
  return _then(CalendarLane(
spaceId: null == spaceId ? _self.spaceId : spaceId // ignore: cast_nullable_to_non_nullable
as String,spaceName: null == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String,slotMinutes: null == slotMinutes ? _self.slotMinutes : slotMinutes // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CalendarItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarLane].
extension CalendarLanePatterns on CalendarLane {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarLane value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarLane() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarLane value)  $default,){
final _that = this;
switch (_that) {
case _CalendarLane():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarLane value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarLane() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String spaceId,  String spaceName,  int slotMinutes,  bool isActive,  List<CalendarItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarLane() when $default != null:
return $default(_that.spaceId,_that.spaceName,_that.slotMinutes,_that.isActive,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String spaceId,  String spaceName,  int slotMinutes,  bool isActive,  List<CalendarItem> items)  $default,) {final _that = this;
switch (_that) {
case _CalendarLane():
return $default(_that.spaceId,_that.spaceName,_that.slotMinutes,_that.isActive,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String spaceId,  String spaceName,  int slotMinutes,  bool isActive,  List<CalendarItem> items)?  $default,) {final _that = this;
switch (_that) {
case _CalendarLane() when $default != null:
return $default(_that.spaceId,_that.spaceName,_that.slotMinutes,_that.isActive,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarLane implements CalendarLane {
  const _CalendarLane({required this.spaceId, required this.spaceName, this.slotMinutes = 60, this.isActive = true,  List<CalendarItem> items = const []}): _items = items;
  factory _CalendarLane.fromJson(Map<String, dynamic> json) => _$CalendarLaneFromJson(json);

@override final  String spaceId;
@override final  String spaceName;
@override@JsonKey() final  int slotMinutes;
@override@JsonKey() final  bool isActive;
 final  List<CalendarItem> _items;
@override@JsonKey() List<CalendarItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CalendarLane
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarLaneCopyWith<_CalendarLane> get copyWith => __$CalendarLaneCopyWithImpl<_CalendarLane>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarLaneToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarLane&&(identical(other.spaceId, spaceId) || other.spaceId == spaceId)&&(identical(other.spaceName, spaceName) || other.spaceName == spaceName)&&(identical(other.slotMinutes, slotMinutes) || other.slotMinutes == slotMinutes)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,spaceId,spaceName,slotMinutes,isActive,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'CalendarLane(spaceId: $spaceId, spaceName: $spaceName, slotMinutes: $slotMinutes, isActive: $isActive, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CalendarLaneCopyWith<$Res> implements $CalendarLaneCopyWith<$Res> {
  factory _$CalendarLaneCopyWith(_CalendarLane value, $Res Function(_CalendarLane) _then) = __$CalendarLaneCopyWithImpl;
@override @useResult
$Res call({
 String spaceId, String spaceName, int slotMinutes, bool isActive, List<CalendarItem> items
});




}
/// @nodoc
class __$CalendarLaneCopyWithImpl<$Res>
    implements _$CalendarLaneCopyWith<$Res> {
  __$CalendarLaneCopyWithImpl(this._self, this._then);

  final _CalendarLane _self;
  final $Res Function(_CalendarLane) _then;

/// Create a copy of CalendarLane
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? spaceId = null,Object? spaceName = null,Object? slotMinutes = null,Object? isActive = null,Object? items = null,}) {
  return _then(_CalendarLane(
spaceId: null == spaceId ? _self.spaceId : spaceId // ignore: cast_nullable_to_non_nullable
as String,spaceName: null == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String,slotMinutes: null == slotMinutes ? _self.slotMinutes : slotMinutes // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CalendarItem>,
  ));
}


}


/// @nodoc
mixin _$CalendarDay {

/// "2026-09-26", venue-local.
 String get date;/// The hour rows to draw, as local "HH:MM" — the union of every lane's
/// opening hours, so an empty day is still a grid and not a blank screen.
 List<String> get rows; List<CalendarLane> get lanes;
/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDayCopyWith<CalendarDay> get copyWith => _$CalendarDayCopyWithImpl<CalendarDay>(this as CalendarDay, _$identity);

  /// Serializes this CalendarDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CalendarDay;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDay&&(identical(other.date, _this.date) || other.date == _this.date)&&const DeepCollectionEquality().equals(other.rows, _this.rows)&&const DeepCollectionEquality().equals(other.lanes, _this.lanes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CalendarDay;
  return Object.hash(runtimeType,_this.date,const DeepCollectionEquality().hash(_this.rows),const DeepCollectionEquality().hash(_this.lanes));
}

@override
String toString() {
  final _this = this as CalendarDay;
  return 'CalendarDay(date: ${_this.date}, rows: ${_this.rows}, lanes: ${_this.lanes})';
}


}

/// @nodoc
abstract mixin class $CalendarDayCopyWith<$Res>  {
  factory $CalendarDayCopyWith(CalendarDay value, $Res Function(CalendarDay) _then) = _$CalendarDayCopyWithImpl;
@useResult
$Res call({
 String date, List<String> rows, List<CalendarLane> lanes
});




}
/// @nodoc
class _$CalendarDayCopyWithImpl<$Res>
    implements $CalendarDayCopyWith<$Res> {
  _$CalendarDayCopyWithImpl(this._self, this._then);

  final CalendarDay _self;
  final $Res Function(CalendarDay) _then;

/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? rows = null,Object? lanes = null,}) {
  return _then(CalendarDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<String>,lanes: null == lanes ? _self.lanes : lanes // ignore: cast_nullable_to_non_nullable
as List<CalendarLane>,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarDay].
extension CalendarDayPatterns on CalendarDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarDay value)  $default,){
final _that = this;
switch (_that) {
case _CalendarDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarDay value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  List<String> rows,  List<CalendarLane> lanes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
return $default(_that.date,_that.rows,_that.lanes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  List<String> rows,  List<CalendarLane> lanes)  $default,) {final _that = this;
switch (_that) {
case _CalendarDay():
return $default(_that.date,_that.rows,_that.lanes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  List<String> rows,  List<CalendarLane> lanes)?  $default,) {final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
return $default(_that.date,_that.rows,_that.lanes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarDay extends CalendarDay {
  const _CalendarDay({required this.date,  List<String> rows = const [],  List<CalendarLane> lanes = const []}): _rows = rows,_lanes = lanes,super._();
  factory _CalendarDay.fromJson(Map<String, dynamic> json) => _$CalendarDayFromJson(json);

/// "2026-09-26", venue-local.
@override final  String date;
/// The hour rows to draw, as local "HH:MM" — the union of every lane's
/// opening hours, so an empty day is still a grid and not a blank screen.
 final  List<String> _rows;
/// The hour rows to draw, as local "HH:MM" — the union of every lane's
/// opening hours, so an empty day is still a grid and not a blank screen.
@override@JsonKey() List<String> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}

 final  List<CalendarLane> _lanes;
@override@JsonKey() List<CalendarLane> get lanes {
  if (_lanes is EqualUnmodifiableListView) return _lanes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lanes);
}


/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDayCopyWith<_CalendarDay> get copyWith => __$CalendarDayCopyWithImpl<_CalendarDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarDayToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDay&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.rows, _rows)&&const DeepCollectionEquality().equals(other.lanes, _lanes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_rows),const DeepCollectionEquality().hash(_lanes));
}

@override
String toString() {
    return 'CalendarDay(date: $date, rows: $rows, lanes: $lanes)';
}


}

/// @nodoc
abstract mixin class _$CalendarDayCopyWith<$Res> implements $CalendarDayCopyWith<$Res> {
  factory _$CalendarDayCopyWith(_CalendarDay value, $Res Function(_CalendarDay) _then) = __$CalendarDayCopyWithImpl;
@override @useResult
$Res call({
 String date, List<String> rows, List<CalendarLane> lanes
});




}
/// @nodoc
class __$CalendarDayCopyWithImpl<$Res>
    implements _$CalendarDayCopyWith<$Res> {
  __$CalendarDayCopyWithImpl(this._self, this._then);

  final _CalendarDay _self;
  final $Res Function(_CalendarDay) _then;

/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? rows = null,Object? lanes = null,}) {
  return _then(_CalendarDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<String>,lanes: null == lanes ? _self._lanes : lanes // ignore: cast_nullable_to_non_nullable
as List<CalendarLane>,
  ));
}


}

// dart format on
