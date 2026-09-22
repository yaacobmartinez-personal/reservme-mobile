// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_venue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VenueSpace {

 String get id; String get name; String get slug; SpaceKind get kind; int get capacity; int get slotMinutes; int get bufferMinutes; int get priceCents; bool get isActive; int get sortOrder; String? get imageUrl;/// Cheapest peak price, when the space has pricing rules.
 int? get peakPriceCents;/// Open slots left today, for the "6 open today" chip. Null = unknown.
 int? get openToday;
/// Create a copy of VenueSpace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueSpaceCopyWith<VenueSpace> get copyWith => _$VenueSpaceCopyWithImpl<VenueSpace>(this as VenueSpace, _$identity);

  /// Serializes this VenueSpace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VenueSpace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueSpace&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&(identical(other.slotMinutes, _this.slotMinutes) || other.slotMinutes == _this.slotMinutes)&&(identical(other.bufferMinutes, _this.bufferMinutes) || other.bufferMinutes == _this.bufferMinutes)&&(identical(other.priceCents, _this.priceCents) || other.priceCents == _this.priceCents)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.peakPriceCents, _this.peakPriceCents) || other.peakPriceCents == _this.peakPriceCents)&&(identical(other.openToday, _this.openToday) || other.openToday == _this.openToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VenueSpace;
  return Object.hash(runtimeType,_this.id,_this.name,_this.slug,_this.kind,_this.capacity,_this.slotMinutes,_this.bufferMinutes,_this.priceCents,_this.isActive,_this.sortOrder,_this.imageUrl,_this.peakPriceCents,_this.openToday);
}

@override
String toString() {
  final _this = this as VenueSpace;
  return 'VenueSpace(id: ${_this.id}, name: ${_this.name}, slug: ${_this.slug}, kind: ${_this.kind}, capacity: ${_this.capacity}, slotMinutes: ${_this.slotMinutes}, bufferMinutes: ${_this.bufferMinutes}, priceCents: ${_this.priceCents}, isActive: ${_this.isActive}, sortOrder: ${_this.sortOrder}, imageUrl: ${_this.imageUrl}, peakPriceCents: ${_this.peakPriceCents}, openToday: ${_this.openToday})';
}


}

/// @nodoc
abstract mixin class $VenueSpaceCopyWith<$Res>  {
  factory $VenueSpaceCopyWith(VenueSpace value, $Res Function(VenueSpace) _then) = _$VenueSpaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String slug, SpaceKind kind, int capacity, int slotMinutes, int bufferMinutes, int priceCents, bool isActive, int sortOrder, String? imageUrl, int? peakPriceCents, int? openToday
});




}
/// @nodoc
class _$VenueSpaceCopyWithImpl<$Res>
    implements $VenueSpaceCopyWith<$Res> {
  _$VenueSpaceCopyWithImpl(this._self, this._then);

  final VenueSpace _self;
  final $Res Function(VenueSpace) _then;

/// Create a copy of VenueSpace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? kind = null,Object? capacity = null,Object? slotMinutes = null,Object? bufferMinutes = null,Object? priceCents = null,Object? isActive = null,Object? sortOrder = null,Object? imageUrl = freezed,Object? peakPriceCents = freezed,Object? openToday = freezed,}) {
  return _then(VenueSpace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SpaceKind,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,slotMinutes: null == slotMinutes ? _self.slotMinutes : slotMinutes // ignore: cast_nullable_to_non_nullable
as int,bufferMinutes: null == bufferMinutes ? _self.bufferMinutes : bufferMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,peakPriceCents: freezed == peakPriceCents ? _self.peakPriceCents : peakPriceCents // ignore: cast_nullable_to_non_nullable
as int?,openToday: freezed == openToday ? _self.openToday : openToday // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueSpace].
extension VenueSpacePatterns on VenueSpace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueSpace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueSpace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueSpace value)  $default,){
final _that = this;
switch (_that) {
case _VenueSpace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueSpace value)?  $default,){
final _that = this;
switch (_that) {
case _VenueSpace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  SpaceKind kind,  int capacity,  int slotMinutes,  int bufferMinutes,  int priceCents,  bool isActive,  int sortOrder,  String? imageUrl,  int? peakPriceCents,  int? openToday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueSpace() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.kind,_that.capacity,_that.slotMinutes,_that.bufferMinutes,_that.priceCents,_that.isActive,_that.sortOrder,_that.imageUrl,_that.peakPriceCents,_that.openToday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  SpaceKind kind,  int capacity,  int slotMinutes,  int bufferMinutes,  int priceCents,  bool isActive,  int sortOrder,  String? imageUrl,  int? peakPriceCents,  int? openToday)  $default,) {final _that = this;
switch (_that) {
case _VenueSpace():
return $default(_that.id,_that.name,_that.slug,_that.kind,_that.capacity,_that.slotMinutes,_that.bufferMinutes,_that.priceCents,_that.isActive,_that.sortOrder,_that.imageUrl,_that.peakPriceCents,_that.openToday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String slug,  SpaceKind kind,  int capacity,  int slotMinutes,  int bufferMinutes,  int priceCents,  bool isActive,  int sortOrder,  String? imageUrl,  int? peakPriceCents,  int? openToday)?  $default,) {final _that = this;
switch (_that) {
case _VenueSpace() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.kind,_that.capacity,_that.slotMinutes,_that.bufferMinutes,_that.priceCents,_that.isActive,_that.sortOrder,_that.imageUrl,_that.peakPriceCents,_that.openToday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VenueSpace extends VenueSpace {
  const _VenueSpace({required this.id, required this.name, required this.slug, this.kind = SpaceKind.other, this.capacity = 1, this.slotMinutes = 60, this.bufferMinutes = 0, required this.priceCents, this.isActive = true, this.sortOrder = 0, this.imageUrl, this.peakPriceCents, this.openToday}): super._();
  factory _VenueSpace.fromJson(Map<String, dynamic> json) => _$VenueSpaceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String slug;
@override@JsonKey() final  SpaceKind kind;
@override@JsonKey() final  int capacity;
@override@JsonKey() final  int slotMinutes;
@override@JsonKey() final  int bufferMinutes;
@override final  int priceCents;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  int sortOrder;
@override final  String? imageUrl;
/// Cheapest peak price, when the space has pricing rules.
@override final  int? peakPriceCents;
/// Open slots left today, for the "6 open today" chip. Null = unknown.
@override final  int? openToday;

/// Create a copy of VenueSpace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueSpaceCopyWith<_VenueSpace> get copyWith => __$VenueSpaceCopyWithImpl<_VenueSpace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VenueSpaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueSpace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.slotMinutes, slotMinutes) || other.slotMinutes == slotMinutes)&&(identical(other.bufferMinutes, bufferMinutes) || other.bufferMinutes == bufferMinutes)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.peakPriceCents, peakPriceCents) || other.peakPriceCents == peakPriceCents)&&(identical(other.openToday, openToday) || other.openToday == openToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,slug,kind,capacity,slotMinutes,bufferMinutes,priceCents,isActive,sortOrder,imageUrl,peakPriceCents,openToday);
}

@override
String toString() {
    return 'VenueSpace(id: $id, name: $name, slug: $slug, kind: $kind, capacity: $capacity, slotMinutes: $slotMinutes, bufferMinutes: $bufferMinutes, priceCents: $priceCents, isActive: $isActive, sortOrder: $sortOrder, imageUrl: $imageUrl, peakPriceCents: $peakPriceCents, openToday: $openToday)';
}


}

/// @nodoc
abstract mixin class _$VenueSpaceCopyWith<$Res> implements $VenueSpaceCopyWith<$Res> {
  factory _$VenueSpaceCopyWith(_VenueSpace value, $Res Function(_VenueSpace) _then) = __$VenueSpaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String slug, SpaceKind kind, int capacity, int slotMinutes, int bufferMinutes, int priceCents, bool isActive, int sortOrder, String? imageUrl, int? peakPriceCents, int? openToday
});




}
/// @nodoc
class __$VenueSpaceCopyWithImpl<$Res>
    implements _$VenueSpaceCopyWith<$Res> {
  __$VenueSpaceCopyWithImpl(this._self, this._then);

  final _VenueSpace _self;
  final $Res Function(_VenueSpace) _then;

/// Create a copy of VenueSpace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? kind = null,Object? capacity = null,Object? slotMinutes = null,Object? bufferMinutes = null,Object? priceCents = null,Object? isActive = null,Object? sortOrder = null,Object? imageUrl = freezed,Object? peakPriceCents = freezed,Object? openToday = freezed,}) {
  return _then(_VenueSpace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SpaceKind,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,slotMinutes: null == slotMinutes ? _self.slotMinutes : slotMinutes // ignore: cast_nullable_to_non_nullable
as int,bufferMinutes: null == bufferMinutes ? _self.bufferMinutes : bufferMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,peakPriceCents: freezed == peakPriceCents ? _self.peakPriceCents : peakPriceCents // ignore: cast_nullable_to_non_nullable
as int?,openToday: freezed == openToday ? _self.openToday : openToday // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PublicVenue {

 String get id; String get slug; String get name; String? get tagline; String? get address; String get timezone; String get currency; VenueTheme get theme; String? get logoUrl; String? get coverUrl; int get minNoticeMinutes; int get maxHorizonDays; CancellationMode get cancellationMode; int get cancellationGraceHours; String? get refundTerms; String? get gcashName; bool get suspended; List<VenueSpace> get spaces;
/// Create a copy of PublicVenue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicVenueCopyWith<PublicVenue> get copyWith => _$PublicVenueCopyWithImpl<PublicVenue>(this as PublicVenue, _$identity);

  /// Serializes this PublicVenue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PublicVenue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicVenue&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.tagline, _this.tagline) || other.tagline == _this.tagline)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.timezone, _this.timezone) || other.timezone == _this.timezone)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.theme, _this.theme) || other.theme == _this.theme)&&(identical(other.logoUrl, _this.logoUrl) || other.logoUrl == _this.logoUrl)&&(identical(other.coverUrl, _this.coverUrl) || other.coverUrl == _this.coverUrl)&&(identical(other.minNoticeMinutes, _this.minNoticeMinutes) || other.minNoticeMinutes == _this.minNoticeMinutes)&&(identical(other.maxHorizonDays, _this.maxHorizonDays) || other.maxHorizonDays == _this.maxHorizonDays)&&(identical(other.cancellationMode, _this.cancellationMode) || other.cancellationMode == _this.cancellationMode)&&(identical(other.cancellationGraceHours, _this.cancellationGraceHours) || other.cancellationGraceHours == _this.cancellationGraceHours)&&(identical(other.refundTerms, _this.refundTerms) || other.refundTerms == _this.refundTerms)&&(identical(other.gcashName, _this.gcashName) || other.gcashName == _this.gcashName)&&(identical(other.suspended, _this.suspended) || other.suspended == _this.suspended)&&const DeepCollectionEquality().equals(other.spaces, _this.spaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PublicVenue;
  return Object.hash(runtimeType,_this.id,_this.slug,_this.name,_this.tagline,_this.address,_this.timezone,_this.currency,_this.theme,_this.logoUrl,_this.coverUrl,_this.minNoticeMinutes,_this.maxHorizonDays,_this.cancellationMode,_this.cancellationGraceHours,_this.refundTerms,_this.gcashName,_this.suspended,const DeepCollectionEquality().hash(_this.spaces));
}

@override
String toString() {
  final _this = this as PublicVenue;
  return 'PublicVenue(id: ${_this.id}, slug: ${_this.slug}, name: ${_this.name}, tagline: ${_this.tagline}, address: ${_this.address}, timezone: ${_this.timezone}, currency: ${_this.currency}, theme: ${_this.theme}, logoUrl: ${_this.logoUrl}, coverUrl: ${_this.coverUrl}, minNoticeMinutes: ${_this.minNoticeMinutes}, maxHorizonDays: ${_this.maxHorizonDays}, cancellationMode: ${_this.cancellationMode}, cancellationGraceHours: ${_this.cancellationGraceHours}, refundTerms: ${_this.refundTerms}, gcashName: ${_this.gcashName}, suspended: ${_this.suspended}, spaces: ${_this.spaces})';
}


}

/// @nodoc
abstract mixin class $PublicVenueCopyWith<$Res>  {
  factory $PublicVenueCopyWith(PublicVenue value, $Res Function(PublicVenue) _then) = _$PublicVenueCopyWithImpl;
@useResult
$Res call({
 String id, String slug, String name, String? tagline, String? address, String timezone, String currency, VenueTheme theme, String? logoUrl, String? coverUrl, int minNoticeMinutes, int maxHorizonDays, CancellationMode cancellationMode, int cancellationGraceHours, String? refundTerms, String? gcashName, bool suspended, List<VenueSpace> spaces
});




}
/// @nodoc
class _$PublicVenueCopyWithImpl<$Res>
    implements $PublicVenueCopyWith<$Res> {
  _$PublicVenueCopyWithImpl(this._self, this._then);

  final PublicVenue _self;
  final $Res Function(PublicVenue) _then;

/// Create a copy of PublicVenue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? tagline = freezed,Object? address = freezed,Object? timezone = null,Object? currency = null,Object? theme = null,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? minNoticeMinutes = null,Object? maxHorizonDays = null,Object? cancellationMode = null,Object? cancellationGraceHours = null,Object? refundTerms = freezed,Object? gcashName = freezed,Object? suspended = null,Object? spaces = null,}) {
  return _then(PublicVenue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as VenueTheme,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,minNoticeMinutes: null == minNoticeMinutes ? _self.minNoticeMinutes : minNoticeMinutes // ignore: cast_nullable_to_non_nullable
as int,maxHorizonDays: null == maxHorizonDays ? _self.maxHorizonDays : maxHorizonDays // ignore: cast_nullable_to_non_nullable
as int,cancellationMode: null == cancellationMode ? _self.cancellationMode : cancellationMode // ignore: cast_nullable_to_non_nullable
as CancellationMode,cancellationGraceHours: null == cancellationGraceHours ? _self.cancellationGraceHours : cancellationGraceHours // ignore: cast_nullable_to_non_nullable
as int,refundTerms: freezed == refundTerms ? _self.refundTerms : refundTerms // ignore: cast_nullable_to_non_nullable
as String?,gcashName: freezed == gcashName ? _self.gcashName : gcashName // ignore: cast_nullable_to_non_nullable
as String?,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,spaces: null == spaces ? _self.spaces : spaces // ignore: cast_nullable_to_non_nullable
as List<VenueSpace>,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicVenue].
extension PublicVenuePatterns on PublicVenue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicVenue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicVenue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicVenue value)  $default,){
final _that = this;
switch (_that) {
case _PublicVenue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicVenue value)?  $default,){
final _that = this;
switch (_that) {
case _PublicVenue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String slug,  String name,  String? tagline,  String? address,  String timezone,  String currency,  VenueTheme theme,  String? logoUrl,  String? coverUrl,  int minNoticeMinutes,  int maxHorizonDays,  CancellationMode cancellationMode,  int cancellationGraceHours,  String? refundTerms,  String? gcashName,  bool suspended,  List<VenueSpace> spaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicVenue() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.tagline,_that.address,_that.timezone,_that.currency,_that.theme,_that.logoUrl,_that.coverUrl,_that.minNoticeMinutes,_that.maxHorizonDays,_that.cancellationMode,_that.cancellationGraceHours,_that.refundTerms,_that.gcashName,_that.suspended,_that.spaces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String slug,  String name,  String? tagline,  String? address,  String timezone,  String currency,  VenueTheme theme,  String? logoUrl,  String? coverUrl,  int minNoticeMinutes,  int maxHorizonDays,  CancellationMode cancellationMode,  int cancellationGraceHours,  String? refundTerms,  String? gcashName,  bool suspended,  List<VenueSpace> spaces)  $default,) {final _that = this;
switch (_that) {
case _PublicVenue():
return $default(_that.id,_that.slug,_that.name,_that.tagline,_that.address,_that.timezone,_that.currency,_that.theme,_that.logoUrl,_that.coverUrl,_that.minNoticeMinutes,_that.maxHorizonDays,_that.cancellationMode,_that.cancellationGraceHours,_that.refundTerms,_that.gcashName,_that.suspended,_that.spaces);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String slug,  String name,  String? tagline,  String? address,  String timezone,  String currency,  VenueTheme theme,  String? logoUrl,  String? coverUrl,  int minNoticeMinutes,  int maxHorizonDays,  CancellationMode cancellationMode,  int cancellationGraceHours,  String? refundTerms,  String? gcashName,  bool suspended,  List<VenueSpace> spaces)?  $default,) {final _that = this;
switch (_that) {
case _PublicVenue() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.tagline,_that.address,_that.timezone,_that.currency,_that.theme,_that.logoUrl,_that.coverUrl,_that.minNoticeMinutes,_that.maxHorizonDays,_that.cancellationMode,_that.cancellationGraceHours,_that.refundTerms,_that.gcashName,_that.suspended,_that.spaces);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicVenue extends PublicVenue {
  const _PublicVenue({required this.id, required this.slug, required this.name, this.tagline, this.address, this.timezone = 'Asia/Manila', this.currency = 'PHP', this.theme = VenueTheme.pine, this.logoUrl, this.coverUrl, this.minNoticeMinutes = 60, this.maxHorizonDays = 60, this.cancellationMode = CancellationMode.anytime, this.cancellationGraceHours = 24, this.refundTerms, this.gcashName, this.suspended = false,  List<VenueSpace> spaces = const []}): _spaces = spaces,super._();
  factory _PublicVenue.fromJson(Map<String, dynamic> json) => _$PublicVenueFromJson(json);

@override final  String id;
@override final  String slug;
@override final  String name;
@override final  String? tagline;
@override final  String? address;
@override@JsonKey() final  String timezone;
@override@JsonKey() final  String currency;
@override@JsonKey() final  VenueTheme theme;
@override final  String? logoUrl;
@override final  String? coverUrl;
@override@JsonKey() final  int minNoticeMinutes;
@override@JsonKey() final  int maxHorizonDays;
@override@JsonKey() final  CancellationMode cancellationMode;
@override@JsonKey() final  int cancellationGraceHours;
@override final  String? refundTerms;
@override final  String? gcashName;
@override@JsonKey() final  bool suspended;
 final  List<VenueSpace> _spaces;
@override@JsonKey() List<VenueSpace> get spaces {
  if (_spaces is EqualUnmodifiableListView) return _spaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_spaces);
}


/// Create a copy of PublicVenue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicVenueCopyWith<_PublicVenue> get copyWith => __$PublicVenueCopyWithImpl<_PublicVenue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicVenueToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicVenue&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.address, address) || other.address == address)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.minNoticeMinutes, minNoticeMinutes) || other.minNoticeMinutes == minNoticeMinutes)&&(identical(other.maxHorizonDays, maxHorizonDays) || other.maxHorizonDays == maxHorizonDays)&&(identical(other.cancellationMode, cancellationMode) || other.cancellationMode == cancellationMode)&&(identical(other.cancellationGraceHours, cancellationGraceHours) || other.cancellationGraceHours == cancellationGraceHours)&&(identical(other.refundTerms, refundTerms) || other.refundTerms == refundTerms)&&(identical(other.gcashName, gcashName) || other.gcashName == gcashName)&&(identical(other.suspended, suspended) || other.suspended == suspended)&&const DeepCollectionEquality().equals(other.spaces, _spaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,slug,name,tagline,address,timezone,currency,theme,logoUrl,coverUrl,minNoticeMinutes,maxHorizonDays,cancellationMode,cancellationGraceHours,refundTerms,gcashName,suspended,const DeepCollectionEquality().hash(_spaces));
}

@override
String toString() {
    return 'PublicVenue(id: $id, slug: $slug, name: $name, tagline: $tagline, address: $address, timezone: $timezone, currency: $currency, theme: $theme, logoUrl: $logoUrl, coverUrl: $coverUrl, minNoticeMinutes: $minNoticeMinutes, maxHorizonDays: $maxHorizonDays, cancellationMode: $cancellationMode, cancellationGraceHours: $cancellationGraceHours, refundTerms: $refundTerms, gcashName: $gcashName, suspended: $suspended, spaces: $spaces)';
}


}

/// @nodoc
abstract mixin class _$PublicVenueCopyWith<$Res> implements $PublicVenueCopyWith<$Res> {
  factory _$PublicVenueCopyWith(_PublicVenue value, $Res Function(_PublicVenue) _then) = __$PublicVenueCopyWithImpl;
@override @useResult
$Res call({
 String id, String slug, String name, String? tagline, String? address, String timezone, String currency, VenueTheme theme, String? logoUrl, String? coverUrl, int minNoticeMinutes, int maxHorizonDays, CancellationMode cancellationMode, int cancellationGraceHours, String? refundTerms, String? gcashName, bool suspended, List<VenueSpace> spaces
});




}
/// @nodoc
class __$PublicVenueCopyWithImpl<$Res>
    implements _$PublicVenueCopyWith<$Res> {
  __$PublicVenueCopyWithImpl(this._self, this._then);

  final _PublicVenue _self;
  final $Res Function(_PublicVenue) _then;

/// Create a copy of PublicVenue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? tagline = freezed,Object? address = freezed,Object? timezone = null,Object? currency = null,Object? theme = null,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? minNoticeMinutes = null,Object? maxHorizonDays = null,Object? cancellationMode = null,Object? cancellationGraceHours = null,Object? refundTerms = freezed,Object? gcashName = freezed,Object? suspended = null,Object? spaces = null,}) {
  return _then(_PublicVenue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as VenueTheme,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,minNoticeMinutes: null == minNoticeMinutes ? _self.minNoticeMinutes : minNoticeMinutes // ignore: cast_nullable_to_non_nullable
as int,maxHorizonDays: null == maxHorizonDays ? _self.maxHorizonDays : maxHorizonDays // ignore: cast_nullable_to_non_nullable
as int,cancellationMode: null == cancellationMode ? _self.cancellationMode : cancellationMode // ignore: cast_nullable_to_non_nullable
as CancellationMode,cancellationGraceHours: null == cancellationGraceHours ? _self.cancellationGraceHours : cancellationGraceHours // ignore: cast_nullable_to_non_nullable
as int,refundTerms: freezed == refundTerms ? _self.refundTerms : refundTerms // ignore: cast_nullable_to_non_nullable
as String?,gcashName: freezed == gcashName ? _self.gcashName : gcashName // ignore: cast_nullable_to_non_nullable
as String?,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,spaces: null == spaces ? _self._spaces : spaces // ignore: cast_nullable_to_non_nullable
as List<VenueSpace>,
  ));
}


}

// dart format on
