// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'space_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpaceSummary {

 String get id; String get name; SpaceKind get kind; int get slotMinutes; int get priceCents;/// The highest price any rule charges, when it beats the base price.
 int? get peakPriceCents; bool get isActive; String? get imageUrl;/// "open play Tue/Thu" — the sessions this space runs, if any.
 String? get sessionSummary; int get upcomingBookings;
/// Create a copy of SpaceSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpaceSummaryCopyWith<SpaceSummary> get copyWith => _$SpaceSummaryCopyWithImpl<SpaceSummary>(this as SpaceSummary, _$identity);

  /// Serializes this SpaceSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpaceSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpaceSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.slotMinutes, _this.slotMinutes) || other.slotMinutes == _this.slotMinutes)&&(identical(other.priceCents, _this.priceCents) || other.priceCents == _this.priceCents)&&(identical(other.peakPriceCents, _this.peakPriceCents) || other.peakPriceCents == _this.peakPriceCents)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.sessionSummary, _this.sessionSummary) || other.sessionSummary == _this.sessionSummary)&&(identical(other.upcomingBookings, _this.upcomingBookings) || other.upcomingBookings == _this.upcomingBookings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpaceSummary;
  return Object.hash(runtimeType,_this.id,_this.name,_this.kind,_this.slotMinutes,_this.priceCents,_this.peakPriceCents,_this.isActive,_this.imageUrl,_this.sessionSummary,_this.upcomingBookings);
}

@override
String toString() {
  final _this = this as SpaceSummary;
  return 'SpaceSummary(id: ${_this.id}, name: ${_this.name}, kind: ${_this.kind}, slotMinutes: ${_this.slotMinutes}, priceCents: ${_this.priceCents}, peakPriceCents: ${_this.peakPriceCents}, isActive: ${_this.isActive}, imageUrl: ${_this.imageUrl}, sessionSummary: ${_this.sessionSummary}, upcomingBookings: ${_this.upcomingBookings})';
}


}

/// @nodoc
abstract mixin class $SpaceSummaryCopyWith<$Res>  {
  factory $SpaceSummaryCopyWith(SpaceSummary value, $Res Function(SpaceSummary) _then) = _$SpaceSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, SpaceKind kind, int slotMinutes, int priceCents, int? peakPriceCents, bool isActive, String? imageUrl, String? sessionSummary, int upcomingBookings
});




}
/// @nodoc
class _$SpaceSummaryCopyWithImpl<$Res>
    implements $SpaceSummaryCopyWith<$Res> {
  _$SpaceSummaryCopyWithImpl(this._self, this._then);

  final SpaceSummary _self;
  final $Res Function(SpaceSummary) _then;

/// Create a copy of SpaceSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? slotMinutes = null,Object? priceCents = null,Object? peakPriceCents = freezed,Object? isActive = null,Object? imageUrl = freezed,Object? sessionSummary = freezed,Object? upcomingBookings = null,}) {
  return _then(SpaceSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SpaceKind,slotMinutes: null == slotMinutes ? _self.slotMinutes : slotMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,peakPriceCents: freezed == peakPriceCents ? _self.peakPriceCents : peakPriceCents // ignore: cast_nullable_to_non_nullable
as int?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,sessionSummary: freezed == sessionSummary ? _self.sessionSummary : sessionSummary // ignore: cast_nullable_to_non_nullable
as String?,upcomingBookings: null == upcomingBookings ? _self.upcomingBookings : upcomingBookings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpaceSummary].
extension SpaceSummaryPatterns on SpaceSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpaceSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpaceSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpaceSummary value)  $default,){
final _that = this;
switch (_that) {
case _SpaceSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpaceSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SpaceSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  SpaceKind kind,  int slotMinutes,  int priceCents,  int? peakPriceCents,  bool isActive,  String? imageUrl,  String? sessionSummary,  int upcomingBookings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpaceSummary() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.slotMinutes,_that.priceCents,_that.peakPriceCents,_that.isActive,_that.imageUrl,_that.sessionSummary,_that.upcomingBookings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  SpaceKind kind,  int slotMinutes,  int priceCents,  int? peakPriceCents,  bool isActive,  String? imageUrl,  String? sessionSummary,  int upcomingBookings)  $default,) {final _that = this;
switch (_that) {
case _SpaceSummary():
return $default(_that.id,_that.name,_that.kind,_that.slotMinutes,_that.priceCents,_that.peakPriceCents,_that.isActive,_that.imageUrl,_that.sessionSummary,_that.upcomingBookings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  SpaceKind kind,  int slotMinutes,  int priceCents,  int? peakPriceCents,  bool isActive,  String? imageUrl,  String? sessionSummary,  int upcomingBookings)?  $default,) {final _that = this;
switch (_that) {
case _SpaceSummary() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.slotMinutes,_that.priceCents,_that.peakPriceCents,_that.isActive,_that.imageUrl,_that.sessionSummary,_that.upcomingBookings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpaceSummary extends SpaceSummary {
  const _SpaceSummary({required this.id, required this.name, this.kind = SpaceKind.court, this.slotMinutes = 60, this.priceCents = 0, this.peakPriceCents, this.isActive = true, this.imageUrl, this.sessionSummary, this.upcomingBookings = 0}): super._();
  factory _SpaceSummary.fromJson(Map<String, dynamic> json) => _$SpaceSummaryFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  SpaceKind kind;
@override@JsonKey() final  int slotMinutes;
@override@JsonKey() final  int priceCents;
/// The highest price any rule charges, when it beats the base price.
@override final  int? peakPriceCents;
@override@JsonKey() final  bool isActive;
@override final  String? imageUrl;
/// "open play Tue/Thu" — the sessions this space runs, if any.
@override final  String? sessionSummary;
@override@JsonKey() final  int upcomingBookings;

/// Create a copy of SpaceSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpaceSummaryCopyWith<_SpaceSummary> get copyWith => __$SpaceSummaryCopyWithImpl<_SpaceSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpaceSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpaceSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.slotMinutes, slotMinutes) || other.slotMinutes == slotMinutes)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.peakPriceCents, peakPriceCents) || other.peakPriceCents == peakPriceCents)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sessionSummary, sessionSummary) || other.sessionSummary == sessionSummary)&&(identical(other.upcomingBookings, upcomingBookings) || other.upcomingBookings == upcomingBookings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,kind,slotMinutes,priceCents,peakPriceCents,isActive,imageUrl,sessionSummary,upcomingBookings);
}

@override
String toString() {
    return 'SpaceSummary(id: $id, name: $name, kind: $kind, slotMinutes: $slotMinutes, priceCents: $priceCents, peakPriceCents: $peakPriceCents, isActive: $isActive, imageUrl: $imageUrl, sessionSummary: $sessionSummary, upcomingBookings: $upcomingBookings)';
}


}

/// @nodoc
abstract mixin class _$SpaceSummaryCopyWith<$Res> implements $SpaceSummaryCopyWith<$Res> {
  factory _$SpaceSummaryCopyWith(_SpaceSummary value, $Res Function(_SpaceSummary) _then) = __$SpaceSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, SpaceKind kind, int slotMinutes, int priceCents, int? peakPriceCents, bool isActive, String? imageUrl, String? sessionSummary, int upcomingBookings
});




}
/// @nodoc
class __$SpaceSummaryCopyWithImpl<$Res>
    implements _$SpaceSummaryCopyWith<$Res> {
  __$SpaceSummaryCopyWithImpl(this._self, this._then);

  final _SpaceSummary _self;
  final $Res Function(_SpaceSummary) _then;

/// Create a copy of SpaceSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? slotMinutes = null,Object? priceCents = null,Object? peakPriceCents = freezed,Object? isActive = null,Object? imageUrl = freezed,Object? sessionSummary = freezed,Object? upcomingBookings = null,}) {
  return _then(_SpaceSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SpaceKind,slotMinutes: null == slotMinutes ? _self.slotMinutes : slotMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,peakPriceCents: freezed == peakPriceCents ? _self.peakPriceCents : peakPriceCents // ignore: cast_nullable_to_non_nullable
as int?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,sessionSummary: freezed == sessionSummary ? _self.sessionSummary : sessionSummary // ignore: cast_nullable_to_non_nullable
as String?,upcomingBookings: null == upcomingBookings ? _self.upcomingBookings : upcomingBookings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
