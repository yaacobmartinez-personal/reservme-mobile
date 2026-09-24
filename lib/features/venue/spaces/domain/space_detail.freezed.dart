// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'space_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpaceDetail {

 String get id; String get name; String get slug; SpaceKind get kind; int get capacity; int get slotMinutes; int get bufferMinutes; int get priceCents; bool get isActive; String? get imageUrl; List<DayHoursView> get hours; List<PricingRuleView> get pricingRules; List<ClosureView> get closures; List<SpaceSessionView> get sessions;/// Live bookings still ahead of now — what a delete would strand.
 int get upcomingBookings;
/// Create a copy of SpaceDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpaceDetailCopyWith<SpaceDetail> get copyWith => _$SpaceDetailCopyWithImpl<SpaceDetail>(this as SpaceDetail, _$identity);

  /// Serializes this SpaceDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpaceDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpaceDetail&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&(identical(other.slotMinutes, _this.slotMinutes) || other.slotMinutes == _this.slotMinutes)&&(identical(other.bufferMinutes, _this.bufferMinutes) || other.bufferMinutes == _this.bufferMinutes)&&(identical(other.priceCents, _this.priceCents) || other.priceCents == _this.priceCents)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&const DeepCollectionEquality().equals(other.hours, _this.hours)&&const DeepCollectionEquality().equals(other.pricingRules, _this.pricingRules)&&const DeepCollectionEquality().equals(other.closures, _this.closures)&&const DeepCollectionEquality().equals(other.sessions, _this.sessions)&&(identical(other.upcomingBookings, _this.upcomingBookings) || other.upcomingBookings == _this.upcomingBookings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpaceDetail;
  return Object.hash(runtimeType,_this.id,_this.name,_this.slug,_this.kind,_this.capacity,_this.slotMinutes,_this.bufferMinutes,_this.priceCents,_this.isActive,_this.imageUrl,const DeepCollectionEquality().hash(_this.hours),const DeepCollectionEquality().hash(_this.pricingRules),const DeepCollectionEquality().hash(_this.closures),const DeepCollectionEquality().hash(_this.sessions),_this.upcomingBookings);
}

@override
String toString() {
  final _this = this as SpaceDetail;
  return 'SpaceDetail(id: ${_this.id}, name: ${_this.name}, slug: ${_this.slug}, kind: ${_this.kind}, capacity: ${_this.capacity}, slotMinutes: ${_this.slotMinutes}, bufferMinutes: ${_this.bufferMinutes}, priceCents: ${_this.priceCents}, isActive: ${_this.isActive}, imageUrl: ${_this.imageUrl}, hours: ${_this.hours}, pricingRules: ${_this.pricingRules}, closures: ${_this.closures}, sessions: ${_this.sessions}, upcomingBookings: ${_this.upcomingBookings})';
}


}

/// @nodoc
abstract mixin class $SpaceDetailCopyWith<$Res>  {
  factory $SpaceDetailCopyWith(SpaceDetail value, $Res Function(SpaceDetail) _then) = _$SpaceDetailCopyWithImpl;
@useResult
$Res call({
 String id, String name, String slug, SpaceKind kind, int capacity, int slotMinutes, int bufferMinutes, int priceCents, bool isActive, String? imageUrl, List<DayHoursView> hours, List<PricingRuleView> pricingRules, List<ClosureView> closures, List<SpaceSessionView> sessions, int upcomingBookings
});




}
/// @nodoc
class _$SpaceDetailCopyWithImpl<$Res>
    implements $SpaceDetailCopyWith<$Res> {
  _$SpaceDetailCopyWithImpl(this._self, this._then);

  final SpaceDetail _self;
  final $Res Function(SpaceDetail) _then;

/// Create a copy of SpaceDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? kind = null,Object? capacity = null,Object? slotMinutes = null,Object? bufferMinutes = null,Object? priceCents = null,Object? isActive = null,Object? imageUrl = freezed,Object? hours = null,Object? pricingRules = null,Object? closures = null,Object? sessions = null,Object? upcomingBookings = null,}) {
  return _then(SpaceDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SpaceKind,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,slotMinutes: null == slotMinutes ? _self.slotMinutes : slotMinutes // ignore: cast_nullable_to_non_nullable
as int,bufferMinutes: null == bufferMinutes ? _self.bufferMinutes : bufferMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as List<DayHoursView>,pricingRules: null == pricingRules ? _self.pricingRules : pricingRules // ignore: cast_nullable_to_non_nullable
as List<PricingRuleView>,closures: null == closures ? _self.closures : closures // ignore: cast_nullable_to_non_nullable
as List<ClosureView>,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SpaceSessionView>,upcomingBookings: null == upcomingBookings ? _self.upcomingBookings : upcomingBookings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpaceDetail].
extension SpaceDetailPatterns on SpaceDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpaceDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpaceDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpaceDetail value)  $default,){
final _that = this;
switch (_that) {
case _SpaceDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpaceDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SpaceDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  SpaceKind kind,  int capacity,  int slotMinutes,  int bufferMinutes,  int priceCents,  bool isActive,  String? imageUrl,  List<DayHoursView> hours,  List<PricingRuleView> pricingRules,  List<ClosureView> closures,  List<SpaceSessionView> sessions,  int upcomingBookings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpaceDetail() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.kind,_that.capacity,_that.slotMinutes,_that.bufferMinutes,_that.priceCents,_that.isActive,_that.imageUrl,_that.hours,_that.pricingRules,_that.closures,_that.sessions,_that.upcomingBookings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  SpaceKind kind,  int capacity,  int slotMinutes,  int bufferMinutes,  int priceCents,  bool isActive,  String? imageUrl,  List<DayHoursView> hours,  List<PricingRuleView> pricingRules,  List<ClosureView> closures,  List<SpaceSessionView> sessions,  int upcomingBookings)  $default,) {final _that = this;
switch (_that) {
case _SpaceDetail():
return $default(_that.id,_that.name,_that.slug,_that.kind,_that.capacity,_that.slotMinutes,_that.bufferMinutes,_that.priceCents,_that.isActive,_that.imageUrl,_that.hours,_that.pricingRules,_that.closures,_that.sessions,_that.upcomingBookings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String slug,  SpaceKind kind,  int capacity,  int slotMinutes,  int bufferMinutes,  int priceCents,  bool isActive,  String? imageUrl,  List<DayHoursView> hours,  List<PricingRuleView> pricingRules,  List<ClosureView> closures,  List<SpaceSessionView> sessions,  int upcomingBookings)?  $default,) {final _that = this;
switch (_that) {
case _SpaceDetail() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.kind,_that.capacity,_that.slotMinutes,_that.bufferMinutes,_that.priceCents,_that.isActive,_that.imageUrl,_that.hours,_that.pricingRules,_that.closures,_that.sessions,_that.upcomingBookings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpaceDetail extends SpaceDetail {
  const _SpaceDetail({required this.id, required this.name, required this.slug, this.kind = SpaceKind.court, this.capacity = 1, this.slotMinutes = 60, this.bufferMinutes = 0, this.priceCents = 0, this.isActive = true, this.imageUrl,  List<DayHoursView> hours = const <DayHoursView>[],  List<PricingRuleView> pricingRules = const <PricingRuleView>[],  List<ClosureView> closures = const <ClosureView>[],  List<SpaceSessionView> sessions = const <SpaceSessionView>[], this.upcomingBookings = 0}): _hours = hours,_pricingRules = pricingRules,_closures = closures,_sessions = sessions,super._();
  factory _SpaceDetail.fromJson(Map<String, dynamic> json) => _$SpaceDetailFromJson(json);

@override final  String id;
@override final  String name;
@override final  String slug;
@override@JsonKey() final  SpaceKind kind;
@override@JsonKey() final  int capacity;
@override@JsonKey() final  int slotMinutes;
@override@JsonKey() final  int bufferMinutes;
@override@JsonKey() final  int priceCents;
@override@JsonKey() final  bool isActive;
@override final  String? imageUrl;
 final  List<DayHoursView> _hours;
@override@JsonKey() List<DayHoursView> get hours {
  if (_hours is EqualUnmodifiableListView) return _hours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hours);
}

 final  List<PricingRuleView> _pricingRules;
@override@JsonKey() List<PricingRuleView> get pricingRules {
  if (_pricingRules is EqualUnmodifiableListView) return _pricingRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pricingRules);
}

 final  List<ClosureView> _closures;
@override@JsonKey() List<ClosureView> get closures {
  if (_closures is EqualUnmodifiableListView) return _closures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_closures);
}

 final  List<SpaceSessionView> _sessions;
@override@JsonKey() List<SpaceSessionView> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

/// Live bookings still ahead of now — what a delete would strand.
@override@JsonKey() final  int upcomingBookings;

/// Create a copy of SpaceDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpaceDetailCopyWith<_SpaceDetail> get copyWith => __$SpaceDetailCopyWithImpl<_SpaceDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpaceDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpaceDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.slotMinutes, slotMinutes) || other.slotMinutes == slotMinutes)&&(identical(other.bufferMinutes, bufferMinutes) || other.bufferMinutes == bufferMinutes)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.hours, _hours)&&const DeepCollectionEquality().equals(other.pricingRules, _pricingRules)&&const DeepCollectionEquality().equals(other.closures, _closures)&&const DeepCollectionEquality().equals(other.sessions, _sessions)&&(identical(other.upcomingBookings, upcomingBookings) || other.upcomingBookings == upcomingBookings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,slug,kind,capacity,slotMinutes,bufferMinutes,priceCents,isActive,imageUrl,const DeepCollectionEquality().hash(_hours),const DeepCollectionEquality().hash(_pricingRules),const DeepCollectionEquality().hash(_closures),const DeepCollectionEquality().hash(_sessions),upcomingBookings);
}

@override
String toString() {
    return 'SpaceDetail(id: $id, name: $name, slug: $slug, kind: $kind, capacity: $capacity, slotMinutes: $slotMinutes, bufferMinutes: $bufferMinutes, priceCents: $priceCents, isActive: $isActive, imageUrl: $imageUrl, hours: $hours, pricingRules: $pricingRules, closures: $closures, sessions: $sessions, upcomingBookings: $upcomingBookings)';
}


}

/// @nodoc
abstract mixin class _$SpaceDetailCopyWith<$Res> implements $SpaceDetailCopyWith<$Res> {
  factory _$SpaceDetailCopyWith(_SpaceDetail value, $Res Function(_SpaceDetail) _then) = __$SpaceDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String slug, SpaceKind kind, int capacity, int slotMinutes, int bufferMinutes, int priceCents, bool isActive, String? imageUrl, List<DayHoursView> hours, List<PricingRuleView> pricingRules, List<ClosureView> closures, List<SpaceSessionView> sessions, int upcomingBookings
});




}
/// @nodoc
class __$SpaceDetailCopyWithImpl<$Res>
    implements _$SpaceDetailCopyWith<$Res> {
  __$SpaceDetailCopyWithImpl(this._self, this._then);

  final _SpaceDetail _self;
  final $Res Function(_SpaceDetail) _then;

/// Create a copy of SpaceDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? kind = null,Object? capacity = null,Object? slotMinutes = null,Object? bufferMinutes = null,Object? priceCents = null,Object? isActive = null,Object? imageUrl = freezed,Object? hours = null,Object? pricingRules = null,Object? closures = null,Object? sessions = null,Object? upcomingBookings = null,}) {
  return _then(_SpaceDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SpaceKind,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,slotMinutes: null == slotMinutes ? _self.slotMinutes : slotMinutes // ignore: cast_nullable_to_non_nullable
as int,bufferMinutes: null == bufferMinutes ? _self.bufferMinutes : bufferMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,hours: null == hours ? _self._hours : hours // ignore: cast_nullable_to_non_nullable
as List<DayHoursView>,pricingRules: null == pricingRules ? _self._pricingRules : pricingRules // ignore: cast_nullable_to_non_nullable
as List<PricingRuleView>,closures: null == closures ? _self._closures : closures // ignore: cast_nullable_to_non_nullable
as List<ClosureView>,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SpaceSessionView>,upcomingBookings: null == upcomingBookings ? _self.upcomingBookings : upcomingBookings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DayHoursView {

 int get weekday; String get opensAt; String get closesAt;
/// Create a copy of DayHoursView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayHoursViewCopyWith<DayHoursView> get copyWith => _$DayHoursViewCopyWithImpl<DayHoursView>(this as DayHoursView, _$identity);

  /// Serializes this DayHoursView to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DayHoursView;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayHoursView&&(identical(other.weekday, _this.weekday) || other.weekday == _this.weekday)&&(identical(other.opensAt, _this.opensAt) || other.opensAt == _this.opensAt)&&(identical(other.closesAt, _this.closesAt) || other.closesAt == _this.closesAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DayHoursView;
  return Object.hash(runtimeType,_this.weekday,_this.opensAt,_this.closesAt);
}

@override
String toString() {
  final _this = this as DayHoursView;
  return 'DayHoursView(weekday: ${_this.weekday}, opensAt: ${_this.opensAt}, closesAt: ${_this.closesAt})';
}


}

/// @nodoc
abstract mixin class $DayHoursViewCopyWith<$Res>  {
  factory $DayHoursViewCopyWith(DayHoursView value, $Res Function(DayHoursView) _then) = _$DayHoursViewCopyWithImpl;
@useResult
$Res call({
 int weekday, String opensAt, String closesAt
});




}
/// @nodoc
class _$DayHoursViewCopyWithImpl<$Res>
    implements $DayHoursViewCopyWith<$Res> {
  _$DayHoursViewCopyWithImpl(this._self, this._then);

  final DayHoursView _self;
  final $Res Function(DayHoursView) _then;

/// Create a copy of DayHoursView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekday = null,Object? opensAt = null,Object? closesAt = null,}) {
  return _then(DayHoursView(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,opensAt: null == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as String,closesAt: null == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DayHoursView].
extension DayHoursViewPatterns on DayHoursView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayHoursView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayHoursView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayHoursView value)  $default,){
final _that = this;
switch (_that) {
case _DayHoursView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayHoursView value)?  $default,){
final _that = this;
switch (_that) {
case _DayHoursView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weekday,  String opensAt,  String closesAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayHoursView() when $default != null:
return $default(_that.weekday,_that.opensAt,_that.closesAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weekday,  String opensAt,  String closesAt)  $default,) {final _that = this;
switch (_that) {
case _DayHoursView():
return $default(_that.weekday,_that.opensAt,_that.closesAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weekday,  String opensAt,  String closesAt)?  $default,) {final _that = this;
switch (_that) {
case _DayHoursView() when $default != null:
return $default(_that.weekday,_that.opensAt,_that.closesAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DayHoursView implements DayHoursView {
  const _DayHoursView({required this.weekday, required this.opensAt, required this.closesAt});
  factory _DayHoursView.fromJson(Map<String, dynamic> json) => _$DayHoursViewFromJson(json);

@override final  int weekday;
@override final  String opensAt;
@override final  String closesAt;

/// Create a copy of DayHoursView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayHoursViewCopyWith<_DayHoursView> get copyWith => __$DayHoursViewCopyWithImpl<_DayHoursView>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DayHoursViewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayHoursView&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.opensAt, opensAt) || other.opensAt == opensAt)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,weekday,opensAt,closesAt);
}

@override
String toString() {
    return 'DayHoursView(weekday: $weekday, opensAt: $opensAt, closesAt: $closesAt)';
}


}

/// @nodoc
abstract mixin class _$DayHoursViewCopyWith<$Res> implements $DayHoursViewCopyWith<$Res> {
  factory _$DayHoursViewCopyWith(_DayHoursView value, $Res Function(_DayHoursView) _then) = __$DayHoursViewCopyWithImpl;
@override @useResult
$Res call({
 int weekday, String opensAt, String closesAt
});




}
/// @nodoc
class __$DayHoursViewCopyWithImpl<$Res>
    implements _$DayHoursViewCopyWith<$Res> {
  __$DayHoursViewCopyWithImpl(this._self, this._then);

  final _DayHoursView _self;
  final $Res Function(_DayHoursView) _then;

/// Create a copy of DayHoursView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekday = null,Object? opensAt = null,Object? closesAt = null,}) {
  return _then(_DayHoursView(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,opensAt: null == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as String,closesAt: null == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PricingRuleView {

 String get id; String? get label; List<int> get weekdays; String get startsAt; String get endsAt; int get priceCents;
/// Create a copy of PricingRuleView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingRuleViewCopyWith<PricingRuleView> get copyWith => _$PricingRuleViewCopyWithImpl<PricingRuleView>(this as PricingRuleView, _$identity);

  /// Serializes this PricingRuleView to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PricingRuleView;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingRuleView&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&const DeepCollectionEquality().equals(other.weekdays, _this.weekdays)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.priceCents, _this.priceCents) || other.priceCents == _this.priceCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PricingRuleView;
  return Object.hash(runtimeType,_this.id,_this.label,const DeepCollectionEquality().hash(_this.weekdays),_this.startsAt,_this.endsAt,_this.priceCents);
}

@override
String toString() {
  final _this = this as PricingRuleView;
  return 'PricingRuleView(id: ${_this.id}, label: ${_this.label}, weekdays: ${_this.weekdays}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, priceCents: ${_this.priceCents})';
}


}

/// @nodoc
abstract mixin class $PricingRuleViewCopyWith<$Res>  {
  factory $PricingRuleViewCopyWith(PricingRuleView value, $Res Function(PricingRuleView) _then) = _$PricingRuleViewCopyWithImpl;
@useResult
$Res call({
 String id, String? label, List<int> weekdays, String startsAt, String endsAt, int priceCents
});




}
/// @nodoc
class _$PricingRuleViewCopyWithImpl<$Res>
    implements $PricingRuleViewCopyWith<$Res> {
  _$PricingRuleViewCopyWithImpl(this._self, this._then);

  final PricingRuleView _self;
  final $Res Function(PricingRuleView) _then;

/// Create a copy of PricingRuleView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = freezed,Object? weekdays = null,Object? startsAt = null,Object? endsAt = null,Object? priceCents = null,}) {
  return _then(PricingRuleView(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,weekdays: null == weekdays ? _self.weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as List<int>,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PricingRuleView].
extension PricingRuleViewPatterns on PricingRuleView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricingRuleView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricingRuleView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricingRuleView value)  $default,){
final _that = this;
switch (_that) {
case _PricingRuleView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricingRuleView value)?  $default,){
final _that = this;
switch (_that) {
case _PricingRuleView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? label,  List<int> weekdays,  String startsAt,  String endsAt,  int priceCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricingRuleView() when $default != null:
return $default(_that.id,_that.label,_that.weekdays,_that.startsAt,_that.endsAt,_that.priceCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? label,  List<int> weekdays,  String startsAt,  String endsAt,  int priceCents)  $default,) {final _that = this;
switch (_that) {
case _PricingRuleView():
return $default(_that.id,_that.label,_that.weekdays,_that.startsAt,_that.endsAt,_that.priceCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? label,  List<int> weekdays,  String startsAt,  String endsAt,  int priceCents)?  $default,) {final _that = this;
switch (_that) {
case _PricingRuleView() when $default != null:
return $default(_that.id,_that.label,_that.weekdays,_that.startsAt,_that.endsAt,_that.priceCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PricingRuleView extends PricingRuleView {
  const _PricingRuleView({required this.id, this.label,  List<int> weekdays = const <int>[], required this.startsAt, required this.endsAt, this.priceCents = 0}): _weekdays = weekdays,super._();
  factory _PricingRuleView.fromJson(Map<String, dynamic> json) => _$PricingRuleViewFromJson(json);

@override final  String id;
@override final  String? label;
 final  List<int> _weekdays;
@override@JsonKey() List<int> get weekdays {
  if (_weekdays is EqualUnmodifiableListView) return _weekdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekdays);
}

@override final  String startsAt;
@override final  String endsAt;
@override@JsonKey() final  int priceCents;

/// Create a copy of PricingRuleView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricingRuleViewCopyWith<_PricingRuleView> get copyWith => __$PricingRuleViewCopyWithImpl<_PricingRuleView>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PricingRuleViewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingRuleView&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.weekdays, _weekdays)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label,const DeepCollectionEquality().hash(_weekdays),startsAt,endsAt,priceCents);
}

@override
String toString() {
    return 'PricingRuleView(id: $id, label: $label, weekdays: $weekdays, startsAt: $startsAt, endsAt: $endsAt, priceCents: $priceCents)';
}


}

/// @nodoc
abstract mixin class _$PricingRuleViewCopyWith<$Res> implements $PricingRuleViewCopyWith<$Res> {
  factory _$PricingRuleViewCopyWith(_PricingRuleView value, $Res Function(_PricingRuleView) _then) = __$PricingRuleViewCopyWithImpl;
@override @useResult
$Res call({
 String id, String? label, List<int> weekdays, String startsAt, String endsAt, int priceCents
});




}
/// @nodoc
class __$PricingRuleViewCopyWithImpl<$Res>
    implements _$PricingRuleViewCopyWith<$Res> {
  __$PricingRuleViewCopyWithImpl(this._self, this._then);

  final _PricingRuleView _self;
  final $Res Function(_PricingRuleView) _then;

/// Create a copy of PricingRuleView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = freezed,Object? weekdays = null,Object? startsAt = null,Object? endsAt = null,Object? priceCents = null,}) {
  return _then(_PricingRuleView(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,weekdays: null == weekdays ? _self._weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as List<int>,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClosureView {

 String get id; String? get spaceId; String? get spaceName; DateTime get startsAt; DateTime get endsAt; String? get reason;
/// Create a copy of ClosureView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClosureViewCopyWith<ClosureView> get copyWith => _$ClosureViewCopyWithImpl<ClosureView>(this as ClosureView, _$identity);

  /// Serializes this ClosureView to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ClosureView;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClosureView&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.spaceId, _this.spaceId) || other.spaceId == _this.spaceId)&&(identical(other.spaceName, _this.spaceName) || other.spaceName == _this.spaceName)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ClosureView;
  return Object.hash(runtimeType,_this.id,_this.spaceId,_this.spaceName,_this.startsAt,_this.endsAt,_this.reason);
}

@override
String toString() {
  final _this = this as ClosureView;
  return 'ClosureView(id: ${_this.id}, spaceId: ${_this.spaceId}, spaceName: ${_this.spaceName}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $ClosureViewCopyWith<$Res>  {
  factory $ClosureViewCopyWith(ClosureView value, $Res Function(ClosureView) _then) = _$ClosureViewCopyWithImpl;
@useResult
$Res call({
 String id, String? spaceId, String? spaceName, DateTime startsAt, DateTime endsAt, String? reason
});




}
/// @nodoc
class _$ClosureViewCopyWithImpl<$Res>
    implements $ClosureViewCopyWith<$Res> {
  _$ClosureViewCopyWithImpl(this._self, this._then);

  final ClosureView _self;
  final $Res Function(ClosureView) _then;

/// Create a copy of ClosureView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? spaceId = freezed,Object? spaceName = freezed,Object? startsAt = null,Object? endsAt = null,Object? reason = freezed,}) {
  return _then(ClosureView(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,spaceId: freezed == spaceId ? _self.spaceId : spaceId // ignore: cast_nullable_to_non_nullable
as String?,spaceName: freezed == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String?,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClosureView].
extension ClosureViewPatterns on ClosureView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClosureView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClosureView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClosureView value)  $default,){
final _that = this;
switch (_that) {
case _ClosureView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClosureView value)?  $default,){
final _that = this;
switch (_that) {
case _ClosureView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? spaceId,  String? spaceName,  DateTime startsAt,  DateTime endsAt,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClosureView() when $default != null:
return $default(_that.id,_that.spaceId,_that.spaceName,_that.startsAt,_that.endsAt,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? spaceId,  String? spaceName,  DateTime startsAt,  DateTime endsAt,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _ClosureView():
return $default(_that.id,_that.spaceId,_that.spaceName,_that.startsAt,_that.endsAt,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? spaceId,  String? spaceName,  DateTime startsAt,  DateTime endsAt,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _ClosureView() when $default != null:
return $default(_that.id,_that.spaceId,_that.spaceName,_that.startsAt,_that.endsAt,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClosureView extends ClosureView {
  const _ClosureView({required this.id, this.spaceId, this.spaceName, required this.startsAt, required this.endsAt, this.reason}): super._();
  factory _ClosureView.fromJson(Map<String, dynamic> json) => _$ClosureViewFromJson(json);

@override final  String id;
@override final  String? spaceId;
@override final  String? spaceName;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  String? reason;

/// Create a copy of ClosureView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClosureViewCopyWith<_ClosureView> get copyWith => __$ClosureViewCopyWithImpl<_ClosureView>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClosureViewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClosureView&&(identical(other.id, id) || other.id == id)&&(identical(other.spaceId, spaceId) || other.spaceId == spaceId)&&(identical(other.spaceName, spaceName) || other.spaceName == spaceName)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,spaceId,spaceName,startsAt,endsAt,reason);
}

@override
String toString() {
    return 'ClosureView(id: $id, spaceId: $spaceId, spaceName: $spaceName, startsAt: $startsAt, endsAt: $endsAt, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$ClosureViewCopyWith<$Res> implements $ClosureViewCopyWith<$Res> {
  factory _$ClosureViewCopyWith(_ClosureView value, $Res Function(_ClosureView) _then) = __$ClosureViewCopyWithImpl;
@override @useResult
$Res call({
 String id, String? spaceId, String? spaceName, DateTime startsAt, DateTime endsAt, String? reason
});




}
/// @nodoc
class __$ClosureViewCopyWithImpl<$Res>
    implements _$ClosureViewCopyWith<$Res> {
  __$ClosureViewCopyWithImpl(this._self, this._then);

  final _ClosureView _self;
  final $Res Function(_ClosureView) _then;

/// Create a copy of ClosureView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? spaceId = freezed,Object? spaceName = freezed,Object? startsAt = null,Object? endsAt = null,Object? reason = freezed,}) {
  return _then(_ClosureView(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,spaceId: freezed == spaceId ? _self.spaceId : spaceId // ignore: cast_nullable_to_non_nullable
as String?,spaceName: freezed == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String?,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SpaceSessionView {

 String get id; String get title; DateTime get startsAt; DateTime get endsAt; int get capacity; int get bookedSpots; bool get cancelled;
/// Create a copy of SpaceSessionView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpaceSessionViewCopyWith<SpaceSessionView> get copyWith => _$SpaceSessionViewCopyWithImpl<SpaceSessionView>(this as SpaceSessionView, _$identity);

  /// Serializes this SpaceSessionView to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpaceSessionView;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpaceSessionView&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&(identical(other.bookedSpots, _this.bookedSpots) || other.bookedSpots == _this.bookedSpots)&&(identical(other.cancelled, _this.cancelled) || other.cancelled == _this.cancelled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpaceSessionView;
  return Object.hash(runtimeType,_this.id,_this.title,_this.startsAt,_this.endsAt,_this.capacity,_this.bookedSpots,_this.cancelled);
}

@override
String toString() {
  final _this = this as SpaceSessionView;
  return 'SpaceSessionView(id: ${_this.id}, title: ${_this.title}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, capacity: ${_this.capacity}, bookedSpots: ${_this.bookedSpots}, cancelled: ${_this.cancelled})';
}


}

/// @nodoc
abstract mixin class $SpaceSessionViewCopyWith<$Res>  {
  factory $SpaceSessionViewCopyWith(SpaceSessionView value, $Res Function(SpaceSessionView) _then) = _$SpaceSessionViewCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime startsAt, DateTime endsAt, int capacity, int bookedSpots, bool cancelled
});




}
/// @nodoc
class _$SpaceSessionViewCopyWithImpl<$Res>
    implements $SpaceSessionViewCopyWith<$Res> {
  _$SpaceSessionViewCopyWithImpl(this._self, this._then);

  final SpaceSessionView _self;
  final $Res Function(SpaceSessionView) _then;

/// Create a copy of SpaceSessionView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? capacity = null,Object? bookedSpots = null,Object? cancelled = null,}) {
  return _then(SpaceSessionView(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,bookedSpots: null == bookedSpots ? _self.bookedSpots : bookedSpots // ignore: cast_nullable_to_non_nullable
as int,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SpaceSessionView].
extension SpaceSessionViewPatterns on SpaceSessionView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpaceSessionView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpaceSessionView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpaceSessionView value)  $default,){
final _that = this;
switch (_that) {
case _SpaceSessionView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpaceSessionView value)?  $default,){
final _that = this;
switch (_that) {
case _SpaceSessionView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsAt,  DateTime endsAt,  int capacity,  int bookedSpots,  bool cancelled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpaceSessionView() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.capacity,_that.bookedSpots,_that.cancelled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsAt,  DateTime endsAt,  int capacity,  int bookedSpots,  bool cancelled)  $default,) {final _that = this;
switch (_that) {
case _SpaceSessionView():
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.capacity,_that.bookedSpots,_that.cancelled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime startsAt,  DateTime endsAt,  int capacity,  int bookedSpots,  bool cancelled)?  $default,) {final _that = this;
switch (_that) {
case _SpaceSessionView() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.capacity,_that.bookedSpots,_that.cancelled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpaceSessionView extends SpaceSessionView {
  const _SpaceSessionView({required this.id, required this.title, required this.startsAt, required this.endsAt, this.capacity = 0, this.bookedSpots = 0, this.cancelled = false}): super._();
  factory _SpaceSessionView.fromJson(Map<String, dynamic> json) => _$SpaceSessionViewFromJson(json);

@override final  String id;
@override final  String title;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override@JsonKey() final  int capacity;
@override@JsonKey() final  int bookedSpots;
@override@JsonKey() final  bool cancelled;

/// Create a copy of SpaceSessionView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpaceSessionViewCopyWith<_SpaceSessionView> get copyWith => __$SpaceSessionViewCopyWithImpl<_SpaceSessionView>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpaceSessionViewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpaceSessionView&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.bookedSpots, bookedSpots) || other.bookedSpots == bookedSpots)&&(identical(other.cancelled, cancelled) || other.cancelled == cancelled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,startsAt,endsAt,capacity,bookedSpots,cancelled);
}

@override
String toString() {
    return 'SpaceSessionView(id: $id, title: $title, startsAt: $startsAt, endsAt: $endsAt, capacity: $capacity, bookedSpots: $bookedSpots, cancelled: $cancelled)';
}


}

/// @nodoc
abstract mixin class _$SpaceSessionViewCopyWith<$Res> implements $SpaceSessionViewCopyWith<$Res> {
  factory _$SpaceSessionViewCopyWith(_SpaceSessionView value, $Res Function(_SpaceSessionView) _then) = __$SpaceSessionViewCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime startsAt, DateTime endsAt, int capacity, int bookedSpots, bool cancelled
});




}
/// @nodoc
class __$SpaceSessionViewCopyWithImpl<$Res>
    implements _$SpaceSessionViewCopyWith<$Res> {
  __$SpaceSessionViewCopyWithImpl(this._self, this._then);

  final _SpaceSessionView _self;
  final $Res Function(_SpaceSessionView) _then;

/// Create a copy of SpaceSessionView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? capacity = null,Object? bookedSpots = null,Object? cancelled = null,}) {
  return _then(_SpaceSessionView(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,bookedSpots: null == bookedSpots ? _self.bookedSpots : bookedSpots // ignore: cast_nullable_to_non_nullable
as int,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
