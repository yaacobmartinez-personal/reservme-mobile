// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'availability.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Slot {

 DateTime get startsAt; DateTime get endsAt;/// "18:00", already in the venue's timezone.
 String get label; bool get available; SlotReason get reason; int get priceCents;/// True when a pricing rule raised the price above the space's base.
 bool get peak;
/// Create a copy of Slot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotCopyWith<Slot> get copyWith => _$SlotCopyWithImpl<Slot>(this as Slot, _$identity);

  /// Serializes this Slot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Slot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Slot&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.available, _this.available) || other.available == _this.available)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.priceCents, _this.priceCents) || other.priceCents == _this.priceCents)&&(identical(other.peak, _this.peak) || other.peak == _this.peak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Slot;
  return Object.hash(runtimeType,_this.startsAt,_this.endsAt,_this.label,_this.available,_this.reason,_this.priceCents,_this.peak);
}

@override
String toString() {
  final _this = this as Slot;
  return 'Slot(startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, label: ${_this.label}, available: ${_this.available}, reason: ${_this.reason}, priceCents: ${_this.priceCents}, peak: ${_this.peak})';
}


}

/// @nodoc
abstract mixin class $SlotCopyWith<$Res>  {
  factory $SlotCopyWith(Slot value, $Res Function(Slot) _then) = _$SlotCopyWithImpl;
@useResult
$Res call({
 DateTime startsAt, DateTime endsAt, String label, bool available, SlotReason reason, int priceCents, bool peak
});




}
/// @nodoc
class _$SlotCopyWithImpl<$Res>
    implements $SlotCopyWith<$Res> {
  _$SlotCopyWithImpl(this._self, this._then);

  final Slot _self;
  final $Res Function(Slot) _then;

/// Create a copy of Slot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startsAt = null,Object? endsAt = null,Object? label = null,Object? available = null,Object? reason = null,Object? priceCents = null,Object? peak = null,}) {
  return _then(Slot(
startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as SlotReason,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,peak: null == peak ? _self.peak : peak // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Slot].
extension SlotPatterns on Slot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Slot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Slot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Slot value)  $default,){
final _that = this;
switch (_that) {
case _Slot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Slot value)?  $default,){
final _that = this;
switch (_that) {
case _Slot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime startsAt,  DateTime endsAt,  String label,  bool available,  SlotReason reason,  int priceCents,  bool peak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Slot() when $default != null:
return $default(_that.startsAt,_that.endsAt,_that.label,_that.available,_that.reason,_that.priceCents,_that.peak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime startsAt,  DateTime endsAt,  String label,  bool available,  SlotReason reason,  int priceCents,  bool peak)  $default,) {final _that = this;
switch (_that) {
case _Slot():
return $default(_that.startsAt,_that.endsAt,_that.label,_that.available,_that.reason,_that.priceCents,_that.peak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime startsAt,  DateTime endsAt,  String label,  bool available,  SlotReason reason,  int priceCents,  bool peak)?  $default,) {final _that = this;
switch (_that) {
case _Slot() when $default != null:
return $default(_that.startsAt,_that.endsAt,_that.label,_that.available,_that.reason,_that.priceCents,_that.peak);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Slot extends Slot {
  const _Slot({required this.startsAt, required this.endsAt, required this.label, required this.available, required this.reason, required this.priceCents, this.peak = false}): super._();
  factory _Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);

@override final  DateTime startsAt;
@override final  DateTime endsAt;
/// "18:00", already in the venue's timezone.
@override final  String label;
@override final  bool available;
@override final  SlotReason reason;
@override final  int priceCents;
/// True when a pricing rule raised the price above the space's base.
@override@JsonKey() final  bool peak;

/// Create a copy of Slot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotCopyWith<_Slot> get copyWith => __$SlotCopyWithImpl<_Slot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlotToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Slot&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.label, label) || other.label == label)&&(identical(other.available, available) || other.available == available)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.peak, peak) || other.peak == peak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,startsAt,endsAt,label,available,reason,priceCents,peak);
}

@override
String toString() {
    return 'Slot(startsAt: $startsAt, endsAt: $endsAt, label: $label, available: $available, reason: $reason, priceCents: $priceCents, peak: $peak)';
}


}

/// @nodoc
abstract mixin class _$SlotCopyWith<$Res> implements $SlotCopyWith<$Res> {
  factory _$SlotCopyWith(_Slot value, $Res Function(_Slot) _then) = __$SlotCopyWithImpl;
@override @useResult
$Res call({
 DateTime startsAt, DateTime endsAt, String label, bool available, SlotReason reason, int priceCents, bool peak
});




}
/// @nodoc
class __$SlotCopyWithImpl<$Res>
    implements _$SlotCopyWith<$Res> {
  __$SlotCopyWithImpl(this._self, this._then);

  final _Slot _self;
  final $Res Function(_Slot) _then;

/// Create a copy of Slot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startsAt = null,Object? endsAt = null,Object? label = null,Object? available = null,Object? reason = null,Object? priceCents = null,Object? peak = null,}) {
  return _then(_Slot(
startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as SlotReason,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,peak: null == peak ? _self.peak : peak // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SessionSummary {

 String get id; String get title; DateTime get startsAt; DateTime get endsAt; String get label; int get capacity; int get bookedSpots; int get pricePerPersonCents;
/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionSummaryCopyWith<SessionSummary> get copyWith => _$SessionSummaryCopyWithImpl<SessionSummary>(this as SessionSummary, _$identity);

  /// Serializes this SessionSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SessionSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&(identical(other.bookedSpots, _this.bookedSpots) || other.bookedSpots == _this.bookedSpots)&&(identical(other.pricePerPersonCents, _this.pricePerPersonCents) || other.pricePerPersonCents == _this.pricePerPersonCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SessionSummary;
  return Object.hash(runtimeType,_this.id,_this.title,_this.startsAt,_this.endsAt,_this.label,_this.capacity,_this.bookedSpots,_this.pricePerPersonCents);
}

@override
String toString() {
  final _this = this as SessionSummary;
  return 'SessionSummary(id: ${_this.id}, title: ${_this.title}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, label: ${_this.label}, capacity: ${_this.capacity}, bookedSpots: ${_this.bookedSpots}, pricePerPersonCents: ${_this.pricePerPersonCents})';
}


}

/// @nodoc
abstract mixin class $SessionSummaryCopyWith<$Res>  {
  factory $SessionSummaryCopyWith(SessionSummary value, $Res Function(SessionSummary) _then) = _$SessionSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime startsAt, DateTime endsAt, String label, int capacity, int bookedSpots, int pricePerPersonCents
});




}
/// @nodoc
class _$SessionSummaryCopyWithImpl<$Res>
    implements $SessionSummaryCopyWith<$Res> {
  _$SessionSummaryCopyWithImpl(this._self, this._then);

  final SessionSummary _self;
  final $Res Function(SessionSummary) _then;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? label = null,Object? capacity = null,Object? bookedSpots = null,Object? pricePerPersonCents = null,}) {
  return _then(SessionSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,bookedSpots: null == bookedSpots ? _self.bookedSpots : bookedSpots // ignore: cast_nullable_to_non_nullable
as int,pricePerPersonCents: null == pricePerPersonCents ? _self.pricePerPersonCents : pricePerPersonCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionSummary].
extension SessionSummaryPatterns on SessionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionSummary value)  $default,){
final _that = this;
switch (_that) {
case _SessionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsAt,  DateTime endsAt,  String label,  int capacity,  int bookedSpots,  int pricePerPersonCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.label,_that.capacity,_that.bookedSpots,_that.pricePerPersonCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsAt,  DateTime endsAt,  String label,  int capacity,  int bookedSpots,  int pricePerPersonCents)  $default,) {final _that = this;
switch (_that) {
case _SessionSummary():
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.label,_that.capacity,_that.bookedSpots,_that.pricePerPersonCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime startsAt,  DateTime endsAt,  String label,  int capacity,  int bookedSpots,  int pricePerPersonCents)?  $default,) {final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.label,_that.capacity,_that.bookedSpots,_that.pricePerPersonCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionSummary extends SessionSummary {
  const _SessionSummary({required this.id, required this.title, required this.startsAt, required this.endsAt, required this.label, required this.capacity, required this.bookedSpots, required this.pricePerPersonCents}): super._();
  factory _SessionSummary.fromJson(Map<String, dynamic> json) => _$SessionSummaryFromJson(json);

@override final  String id;
@override final  String title;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  String label;
@override final  int capacity;
@override final  int bookedSpots;
@override final  int pricePerPersonCents;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionSummaryCopyWith<_SessionSummary> get copyWith => __$SessionSummaryCopyWithImpl<_SessionSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.label, label) || other.label == label)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.bookedSpots, bookedSpots) || other.bookedSpots == bookedSpots)&&(identical(other.pricePerPersonCents, pricePerPersonCents) || other.pricePerPersonCents == pricePerPersonCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,startsAt,endsAt,label,capacity,bookedSpots,pricePerPersonCents);
}

@override
String toString() {
    return 'SessionSummary(id: $id, title: $title, startsAt: $startsAt, endsAt: $endsAt, label: $label, capacity: $capacity, bookedSpots: $bookedSpots, pricePerPersonCents: $pricePerPersonCents)';
}


}

/// @nodoc
abstract mixin class _$SessionSummaryCopyWith<$Res> implements $SessionSummaryCopyWith<$Res> {
  factory _$SessionSummaryCopyWith(_SessionSummary value, $Res Function(_SessionSummary) _then) = __$SessionSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime startsAt, DateTime endsAt, String label, int capacity, int bookedSpots, int pricePerPersonCents
});




}
/// @nodoc
class __$SessionSummaryCopyWithImpl<$Res>
    implements _$SessionSummaryCopyWith<$Res> {
  __$SessionSummaryCopyWithImpl(this._self, this._then);

  final _SessionSummary _self;
  final $Res Function(_SessionSummary) _then;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? label = null,Object? capacity = null,Object? bookedSpots = null,Object? pricePerPersonCents = null,}) {
  return _then(_SessionSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,bookedSpots: null == bookedSpots ? _self.bookedSpots : bookedSpots // ignore: cast_nullable_to_non_nullable
as int,pricePerPersonCents: null == pricePerPersonCents ? _self.pricePerPersonCents : pricePerPersonCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DayAvailability {

/// "2026-09-26", venue-local.
 String get date; List<Slot> get slots; List<SessionSummary> get sessions;
/// Create a copy of DayAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayAvailabilityCopyWith<DayAvailability> get copyWith => _$DayAvailabilityCopyWithImpl<DayAvailability>(this as DayAvailability, _$identity);

  /// Serializes this DayAvailability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DayAvailability;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayAvailability&&(identical(other.date, _this.date) || other.date == _this.date)&&const DeepCollectionEquality().equals(other.slots, _this.slots)&&const DeepCollectionEquality().equals(other.sessions, _this.sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DayAvailability;
  return Object.hash(runtimeType,_this.date,const DeepCollectionEquality().hash(_this.slots),const DeepCollectionEquality().hash(_this.sessions));
}

@override
String toString() {
  final _this = this as DayAvailability;
  return 'DayAvailability(date: ${_this.date}, slots: ${_this.slots}, sessions: ${_this.sessions})';
}


}

/// @nodoc
abstract mixin class $DayAvailabilityCopyWith<$Res>  {
  factory $DayAvailabilityCopyWith(DayAvailability value, $Res Function(DayAvailability) _then) = _$DayAvailabilityCopyWithImpl;
@useResult
$Res call({
 String date, List<Slot> slots, List<SessionSummary> sessions
});




}
/// @nodoc
class _$DayAvailabilityCopyWithImpl<$Res>
    implements $DayAvailabilityCopyWith<$Res> {
  _$DayAvailabilityCopyWithImpl(this._self, this._then);

  final DayAvailability _self;
  final $Res Function(DayAvailability) _then;

/// Create a copy of DayAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? slots = null,Object? sessions = null,}) {
  return _then(DayAvailability(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<Slot>,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SessionSummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [DayAvailability].
extension DayAvailabilityPatterns on DayAvailability {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayAvailability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayAvailability() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayAvailability value)  $default,){
final _that = this;
switch (_that) {
case _DayAvailability():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayAvailability value)?  $default,){
final _that = this;
switch (_that) {
case _DayAvailability() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  List<Slot> slots,  List<SessionSummary> sessions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayAvailability() when $default != null:
return $default(_that.date,_that.slots,_that.sessions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  List<Slot> slots,  List<SessionSummary> sessions)  $default,) {final _that = this;
switch (_that) {
case _DayAvailability():
return $default(_that.date,_that.slots,_that.sessions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  List<Slot> slots,  List<SessionSummary> sessions)?  $default,) {final _that = this;
switch (_that) {
case _DayAvailability() when $default != null:
return $default(_that.date,_that.slots,_that.sessions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DayAvailability extends DayAvailability {
  const _DayAvailability({required this.date,  List<Slot> slots = const [],  List<SessionSummary> sessions = const []}): _slots = slots,_sessions = sessions,super._();
  factory _DayAvailability.fromJson(Map<String, dynamic> json) => _$DayAvailabilityFromJson(json);

/// "2026-09-26", venue-local.
@override final  String date;
 final  List<Slot> _slots;
@override@JsonKey() List<Slot> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}

 final  List<SessionSummary> _sessions;
@override@JsonKey() List<SessionSummary> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}


/// Create a copy of DayAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayAvailabilityCopyWith<_DayAvailability> get copyWith => __$DayAvailabilityCopyWithImpl<_DayAvailability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DayAvailabilityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayAvailability&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.slots, _slots)&&const DeepCollectionEquality().equals(other.sessions, _sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_slots),const DeepCollectionEquality().hash(_sessions));
}

@override
String toString() {
    return 'DayAvailability(date: $date, slots: $slots, sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class _$DayAvailabilityCopyWith<$Res> implements $DayAvailabilityCopyWith<$Res> {
  factory _$DayAvailabilityCopyWith(_DayAvailability value, $Res Function(_DayAvailability) _then) = __$DayAvailabilityCopyWithImpl;
@override @useResult
$Res call({
 String date, List<Slot> slots, List<SessionSummary> sessions
});




}
/// @nodoc
class __$DayAvailabilityCopyWithImpl<$Res>
    implements _$DayAvailabilityCopyWith<$Res> {
  __$DayAvailabilityCopyWithImpl(this._self, this._then);

  final _DayAvailability _self;
  final $Res Function(_DayAvailability) _then;

/// Create a copy of DayAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? slots = null,Object? sessions = null,}) {
  return _then(_DayAvailability(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<Slot>,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SessionSummary>,
  ));
}


}

// dart format on
