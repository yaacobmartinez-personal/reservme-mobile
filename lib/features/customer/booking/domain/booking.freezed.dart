// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Cancellation {

 bool get canCancel; String? get reason;
/// Create a copy of Cancellation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancellationCopyWith<Cancellation> get copyWith => _$CancellationCopyWithImpl<Cancellation>(this as Cancellation, _$identity);

  /// Serializes this Cancellation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Cancellation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cancellation&&(identical(other.canCancel, _this.canCancel) || other.canCancel == _this.canCancel)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Cancellation;
  return Object.hash(runtimeType,_this.canCancel,_this.reason);
}

@override
String toString() {
  final _this = this as Cancellation;
  return 'Cancellation(canCancel: ${_this.canCancel}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $CancellationCopyWith<$Res>  {
  factory $CancellationCopyWith(Cancellation value, $Res Function(Cancellation) _then) = _$CancellationCopyWithImpl;
@useResult
$Res call({
 bool canCancel, String? reason
});




}
/// @nodoc
class _$CancellationCopyWithImpl<$Res>
    implements $CancellationCopyWith<$Res> {
  _$CancellationCopyWithImpl(this._self, this._then);

  final Cancellation _self;
  final $Res Function(Cancellation) _then;

/// Create a copy of Cancellation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? canCancel = null,Object? reason = freezed,}) {
  return _then(Cancellation(
canCancel: null == canCancel ? _self.canCancel : canCancel // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Cancellation].
extension CancellationPatterns on Cancellation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cancellation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cancellation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cancellation value)  $default,){
final _that = this;
switch (_that) {
case _Cancellation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cancellation value)?  $default,){
final _that = this;
switch (_that) {
case _Cancellation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool canCancel,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Cancellation() when $default != null:
return $default(_that.canCancel,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool canCancel,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _Cancellation():
return $default(_that.canCancel,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool canCancel,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _Cancellation() when $default != null:
return $default(_that.canCancel,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Cancellation implements Cancellation {
  const _Cancellation({this.canCancel = false, this.reason});
  factory _Cancellation.fromJson(Map<String, dynamic> json) => _$CancellationFromJson(json);

@override@JsonKey() final  bool canCancel;
@override final  String? reason;

/// Create a copy of Cancellation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancellationCopyWith<_Cancellation> get copyWith => __$CancellationCopyWithImpl<_Cancellation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CancellationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cancellation&&(identical(other.canCancel, canCancel) || other.canCancel == canCancel)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,canCancel,reason);
}

@override
String toString() {
    return 'Cancellation(canCancel: $canCancel, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CancellationCopyWith<$Res> implements $CancellationCopyWith<$Res> {
  factory _$CancellationCopyWith(_Cancellation value, $Res Function(_Cancellation) _then) = __$CancellationCopyWithImpl;
@override @useResult
$Res call({
 bool canCancel, String? reason
});




}
/// @nodoc
class __$CancellationCopyWithImpl<$Res>
    implements _$CancellationCopyWith<$Res> {
  __$CancellationCopyWithImpl(this._self, this._then);

  final _Cancellation _self;
  final $Res Function(_Cancellation) _then;

/// Create a copy of Cancellation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? canCancel = null,Object? reason = freezed,}) {
  return _then(_Cancellation(
canCancel: null == canCancel ? _self.canCancel : canCancel // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BookingVenue {

 String get slug; String get name; VenueTheme get theme; String get timezone; String get currency; String? get address;
/// Create a copy of BookingVenue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingVenueCopyWith<BookingVenue> get copyWith => _$BookingVenueCopyWithImpl<BookingVenue>(this as BookingVenue, _$identity);

  /// Serializes this BookingVenue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BookingVenue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingVenue&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.theme, _this.theme) || other.theme == _this.theme)&&(identical(other.timezone, _this.timezone) || other.timezone == _this.timezone)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.address, _this.address) || other.address == _this.address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BookingVenue;
  return Object.hash(runtimeType,_this.slug,_this.name,_this.theme,_this.timezone,_this.currency,_this.address);
}

@override
String toString() {
  final _this = this as BookingVenue;
  return 'BookingVenue(slug: ${_this.slug}, name: ${_this.name}, theme: ${_this.theme}, timezone: ${_this.timezone}, currency: ${_this.currency}, address: ${_this.address})';
}


}

/// @nodoc
abstract mixin class $BookingVenueCopyWith<$Res>  {
  factory $BookingVenueCopyWith(BookingVenue value, $Res Function(BookingVenue) _then) = _$BookingVenueCopyWithImpl;
@useResult
$Res call({
 String slug, String name, VenueTheme theme, String timezone, String currency, String? address
});




}
/// @nodoc
class _$BookingVenueCopyWithImpl<$Res>
    implements $BookingVenueCopyWith<$Res> {
  _$BookingVenueCopyWithImpl(this._self, this._then);

  final BookingVenue _self;
  final $Res Function(BookingVenue) _then;

/// Create a copy of BookingVenue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? name = null,Object? theme = null,Object? timezone = null,Object? currency = null,Object? address = freezed,}) {
  return _then(BookingVenue(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as VenueTheme,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingVenue].
extension BookingVenuePatterns on BookingVenue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingVenue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingVenue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingVenue value)  $default,){
final _that = this;
switch (_that) {
case _BookingVenue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingVenue value)?  $default,){
final _that = this;
switch (_that) {
case _BookingVenue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  String name,  VenueTheme theme,  String timezone,  String currency,  String? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingVenue() when $default != null:
return $default(_that.slug,_that.name,_that.theme,_that.timezone,_that.currency,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  String name,  VenueTheme theme,  String timezone,  String currency,  String? address)  $default,) {final _that = this;
switch (_that) {
case _BookingVenue():
return $default(_that.slug,_that.name,_that.theme,_that.timezone,_that.currency,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  String name,  VenueTheme theme,  String timezone,  String currency,  String? address)?  $default,) {final _that = this;
switch (_that) {
case _BookingVenue() when $default != null:
return $default(_that.slug,_that.name,_that.theme,_that.timezone,_that.currency,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingVenue implements BookingVenue {
  const _BookingVenue({required this.slug, required this.name, this.theme = VenueTheme.pine, this.timezone = 'Asia/Manila', this.currency = 'PHP', this.address});
  factory _BookingVenue.fromJson(Map<String, dynamic> json) => _$BookingVenueFromJson(json);

@override final  String slug;
@override final  String name;
@override@JsonKey() final  VenueTheme theme;
@override@JsonKey() final  String timezone;
@override@JsonKey() final  String currency;
@override final  String? address;

/// Create a copy of BookingVenue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingVenueCopyWith<_BookingVenue> get copyWith => __$BookingVenueCopyWithImpl<_BookingVenue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingVenueToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingVenue&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,slug,name,theme,timezone,currency,address);
}

@override
String toString() {
    return 'BookingVenue(slug: $slug, name: $name, theme: $theme, timezone: $timezone, currency: $currency, address: $address)';
}


}

/// @nodoc
abstract mixin class _$BookingVenueCopyWith<$Res> implements $BookingVenueCopyWith<$Res> {
  factory _$BookingVenueCopyWith(_BookingVenue value, $Res Function(_BookingVenue) _then) = __$BookingVenueCopyWithImpl;
@override @useResult
$Res call({
 String slug, String name, VenueTheme theme, String timezone, String currency, String? address
});




}
/// @nodoc
class __$BookingVenueCopyWithImpl<$Res>
    implements _$BookingVenueCopyWith<$Res> {
  __$BookingVenueCopyWithImpl(this._self, this._then);

  final _BookingVenue _self;
  final $Res Function(_BookingVenue) _then;

/// Create a copy of BookingVenue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? name = null,Object? theme = null,Object? timezone = null,Object? currency = null,Object? address = freezed,}) {
  return _then(_BookingVenue(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as VenueTheme,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BookingSpace {

 String get id; String get name; SpaceKind get kind; int get slotMinutes;
/// Create a copy of BookingSpace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingSpaceCopyWith<BookingSpace> get copyWith => _$BookingSpaceCopyWithImpl<BookingSpace>(this as BookingSpace, _$identity);

  /// Serializes this BookingSpace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BookingSpace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSpace&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.slotMinutes, _this.slotMinutes) || other.slotMinutes == _this.slotMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BookingSpace;
  return Object.hash(runtimeType,_this.id,_this.name,_this.kind,_this.slotMinutes);
}

@override
String toString() {
  final _this = this as BookingSpace;
  return 'BookingSpace(id: ${_this.id}, name: ${_this.name}, kind: ${_this.kind}, slotMinutes: ${_this.slotMinutes})';
}


}

/// @nodoc
abstract mixin class $BookingSpaceCopyWith<$Res>  {
  factory $BookingSpaceCopyWith(BookingSpace value, $Res Function(BookingSpace) _then) = _$BookingSpaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, SpaceKind kind, int slotMinutes
});




}
/// @nodoc
class _$BookingSpaceCopyWithImpl<$Res>
    implements $BookingSpaceCopyWith<$Res> {
  _$BookingSpaceCopyWithImpl(this._self, this._then);

  final BookingSpace _self;
  final $Res Function(BookingSpace) _then;

/// Create a copy of BookingSpace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? slotMinutes = null,}) {
  return _then(BookingSpace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SpaceKind,slotMinutes: null == slotMinutes ? _self.slotMinutes : slotMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingSpace].
extension BookingSpacePatterns on BookingSpace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingSpace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingSpace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingSpace value)  $default,){
final _that = this;
switch (_that) {
case _BookingSpace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingSpace value)?  $default,){
final _that = this;
switch (_that) {
case _BookingSpace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  SpaceKind kind,  int slotMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingSpace() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.slotMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  SpaceKind kind,  int slotMinutes)  $default,) {final _that = this;
switch (_that) {
case _BookingSpace():
return $default(_that.id,_that.name,_that.kind,_that.slotMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  SpaceKind kind,  int slotMinutes)?  $default,) {final _that = this;
switch (_that) {
case _BookingSpace() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.slotMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingSpace implements BookingSpace {
  const _BookingSpace({required this.id, required this.name, this.kind = SpaceKind.other, this.slotMinutes = 60});
  factory _BookingSpace.fromJson(Map<String, dynamic> json) => _$BookingSpaceFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  SpaceKind kind;
@override@JsonKey() final  int slotMinutes;

/// Create a copy of BookingSpace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingSpaceCopyWith<_BookingSpace> get copyWith => __$BookingSpaceCopyWithImpl<_BookingSpace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingSpaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingSpace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.slotMinutes, slotMinutes) || other.slotMinutes == slotMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,kind,slotMinutes);
}

@override
String toString() {
    return 'BookingSpace(id: $id, name: $name, kind: $kind, slotMinutes: $slotMinutes)';
}


}

/// @nodoc
abstract mixin class _$BookingSpaceCopyWith<$Res> implements $BookingSpaceCopyWith<$Res> {
  factory _$BookingSpaceCopyWith(_BookingSpace value, $Res Function(_BookingSpace) _then) = __$BookingSpaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, SpaceKind kind, int slotMinutes
});




}
/// @nodoc
class __$BookingSpaceCopyWithImpl<$Res>
    implements _$BookingSpaceCopyWith<$Res> {
  __$BookingSpaceCopyWithImpl(this._self, this._then);

  final _BookingSpace _self;
  final $Res Function(_BookingSpace) _then;

/// Create a copy of BookingSpace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? slotMinutes = null,}) {
  return _then(_BookingSpace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SpaceKind,slotMinutes: null == slotMinutes ? _self.slotMinutes : slotMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Booking {

 String? get id; String get reference; BookingVenue get venue; BookingSpace get space; DateTime get startsAt; DateTime get endsAt;/// "Sat 26 Sep · 18:00–19:00", rendered by the server in the venue's zone.
 String get whenLabel; ReservationKind get kind; int get partySize; int get amountCents; ReservationStatus get status; DateTime? get checkedInAt; String? get notes; Cancellation get cancellation; String? get manageToken;
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingCopyWith<Booking> get copyWith => _$BookingCopyWithImpl<Booking>(this as Booking, _$identity);

  /// Serializes this Booking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Booking;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booking&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.venue, _this.venue) || other.venue == _this.venue)&&(identical(other.space, _this.space) || other.space == _this.space)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.whenLabel, _this.whenLabel) || other.whenLabel == _this.whenLabel)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.partySize, _this.partySize) || other.partySize == _this.partySize)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.checkedInAt, _this.checkedInAt) || other.checkedInAt == _this.checkedInAt)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.cancellation, _this.cancellation) || other.cancellation == _this.cancellation)&&(identical(other.manageToken, _this.manageToken) || other.manageToken == _this.manageToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Booking;
  return Object.hash(runtimeType,_this.id,_this.reference,_this.venue,_this.space,_this.startsAt,_this.endsAt,_this.whenLabel,_this.kind,_this.partySize,_this.amountCents,_this.status,_this.checkedInAt,_this.notes,_this.cancellation,_this.manageToken);
}

@override
String toString() {
  final _this = this as Booking;
  return 'Booking(id: ${_this.id}, reference: ${_this.reference}, venue: ${_this.venue}, space: ${_this.space}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, whenLabel: ${_this.whenLabel}, kind: ${_this.kind}, partySize: ${_this.partySize}, amountCents: ${_this.amountCents}, status: ${_this.status}, checkedInAt: ${_this.checkedInAt}, notes: ${_this.notes}, cancellation: ${_this.cancellation}, manageToken: ${_this.manageToken})';
}


}

/// @nodoc
abstract mixin class $BookingCopyWith<$Res>  {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) _then) = _$BookingCopyWithImpl;
@useResult
$Res call({
 String? id, String reference, BookingVenue venue, BookingSpace space, DateTime startsAt, DateTime endsAt, String whenLabel, ReservationKind kind, int partySize, int amountCents, ReservationStatus status, DateTime? checkedInAt, String? notes, Cancellation cancellation, String? manageToken
});


$BookingVenueCopyWith<$Res> get venue;$BookingSpaceCopyWith<$Res> get space;$CancellationCopyWith<$Res> get cancellation;

}
/// @nodoc
class _$BookingCopyWithImpl<$Res>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._self, this._then);

  final Booking _self;
  final $Res Function(Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? reference = null,Object? venue = null,Object? space = null,Object? startsAt = null,Object? endsAt = null,Object? whenLabel = null,Object? kind = null,Object? partySize = null,Object? amountCents = null,Object? status = null,Object? checkedInAt = freezed,Object? notes = freezed,Object? cancellation = null,Object? manageToken = freezed,}) {
  return _then(Booking(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as BookingVenue,space: null == space ? _self.space : space // ignore: cast_nullable_to_non_nullable
as BookingSpace,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,whenLabel: null == whenLabel ? _self.whenLabel : whenLabel // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReservationKind,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,cancellation: null == cancellation ? _self.cancellation : cancellation // ignore: cast_nullable_to_non_nullable
as Cancellation,manageToken: freezed == manageToken ? _self.manageToken : manageToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingVenueCopyWith<$Res> get venue {
  
  return $BookingVenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingSpaceCopyWith<$Res> get space {
  
  return $BookingSpaceCopyWith<$Res>(_self.space, (value) {
    return _then(_self.copyWith(space: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CancellationCopyWith<$Res> get cancellation {
  
  return $CancellationCopyWith<$Res>(_self.cancellation, (value) {
    return _then(_self.copyWith(cancellation: value));
  });
}
}


/// Adds pattern-matching-related methods to [Booking].
extension BookingPatterns on Booking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Booking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Booking value)  $default,){
final _that = this;
switch (_that) {
case _Booking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Booking value)?  $default,){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String reference,  BookingVenue venue,  BookingSpace space,  DateTime startsAt,  DateTime endsAt,  String whenLabel,  ReservationKind kind,  int partySize,  int amountCents,  ReservationStatus status,  DateTime? checkedInAt,  String? notes,  Cancellation cancellation,  String? manageToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.reference,_that.venue,_that.space,_that.startsAt,_that.endsAt,_that.whenLabel,_that.kind,_that.partySize,_that.amountCents,_that.status,_that.checkedInAt,_that.notes,_that.cancellation,_that.manageToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String reference,  BookingVenue venue,  BookingSpace space,  DateTime startsAt,  DateTime endsAt,  String whenLabel,  ReservationKind kind,  int partySize,  int amountCents,  ReservationStatus status,  DateTime? checkedInAt,  String? notes,  Cancellation cancellation,  String? manageToken)  $default,) {final _that = this;
switch (_that) {
case _Booking():
return $default(_that.id,_that.reference,_that.venue,_that.space,_that.startsAt,_that.endsAt,_that.whenLabel,_that.kind,_that.partySize,_that.amountCents,_that.status,_that.checkedInAt,_that.notes,_that.cancellation,_that.manageToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String reference,  BookingVenue venue,  BookingSpace space,  DateTime startsAt,  DateTime endsAt,  String whenLabel,  ReservationKind kind,  int partySize,  int amountCents,  ReservationStatus status,  DateTime? checkedInAt,  String? notes,  Cancellation cancellation,  String? manageToken)?  $default,) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.reference,_that.venue,_that.space,_that.startsAt,_that.endsAt,_that.whenLabel,_that.kind,_that.partySize,_that.amountCents,_that.status,_that.checkedInAt,_that.notes,_that.cancellation,_that.manageToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Booking extends Booking {
  const _Booking({this.id, required this.reference, required this.venue, required this.space, required this.startsAt, required this.endsAt, required this.whenLabel, this.kind = ReservationKind.rental, this.partySize = 1, this.amountCents = 0, this.status = ReservationStatus.confirmed, this.checkedInAt, this.notes, this.cancellation = const Cancellation(), this.manageToken}): super._();
  factory _Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

@override final  String? id;
@override final  String reference;
@override final  BookingVenue venue;
@override final  BookingSpace space;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
/// "Sat 26 Sep · 18:00–19:00", rendered by the server in the venue's zone.
@override final  String whenLabel;
@override@JsonKey() final  ReservationKind kind;
@override@JsonKey() final  int partySize;
@override@JsonKey() final  int amountCents;
@override@JsonKey() final  ReservationStatus status;
@override final  DateTime? checkedInAt;
@override final  String? notes;
@override@JsonKey() final  Cancellation cancellation;
@override final  String? manageToken;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingCopyWith<_Booking> get copyWith => __$BookingCopyWithImpl<_Booking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.space, space) || other.space == space)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.whenLabel, whenLabel) || other.whenLabel == whenLabel)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.partySize, partySize) || other.partySize == partySize)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.status, status) || other.status == status)&&(identical(other.checkedInAt, checkedInAt) || other.checkedInAt == checkedInAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.cancellation, cancellation) || other.cancellation == cancellation)&&(identical(other.manageToken, manageToken) || other.manageToken == manageToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,reference,venue,space,startsAt,endsAt,whenLabel,kind,partySize,amountCents,status,checkedInAt,notes,cancellation,manageToken);
}

@override
String toString() {
    return 'Booking(id: $id, reference: $reference, venue: $venue, space: $space, startsAt: $startsAt, endsAt: $endsAt, whenLabel: $whenLabel, kind: $kind, partySize: $partySize, amountCents: $amountCents, status: $status, checkedInAt: $checkedInAt, notes: $notes, cancellation: $cancellation, manageToken: $manageToken)';
}


}

/// @nodoc
abstract mixin class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) _then) = __$BookingCopyWithImpl;
@override @useResult
$Res call({
 String? id, String reference, BookingVenue venue, BookingSpace space, DateTime startsAt, DateTime endsAt, String whenLabel, ReservationKind kind, int partySize, int amountCents, ReservationStatus status, DateTime? checkedInAt, String? notes, Cancellation cancellation, String? manageToken
});


@override $BookingVenueCopyWith<$Res> get venue;@override $BookingSpaceCopyWith<$Res> get space;@override $CancellationCopyWith<$Res> get cancellation;

}
/// @nodoc
class __$BookingCopyWithImpl<$Res>
    implements _$BookingCopyWith<$Res> {
  __$BookingCopyWithImpl(this._self, this._then);

  final _Booking _self;
  final $Res Function(_Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? reference = null,Object? venue = null,Object? space = null,Object? startsAt = null,Object? endsAt = null,Object? whenLabel = null,Object? kind = null,Object? partySize = null,Object? amountCents = null,Object? status = null,Object? checkedInAt = freezed,Object? notes = freezed,Object? cancellation = null,Object? manageToken = freezed,}) {
  return _then(_Booking(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as BookingVenue,space: null == space ? _self.space : space // ignore: cast_nullable_to_non_nullable
as BookingSpace,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,whenLabel: null == whenLabel ? _self.whenLabel : whenLabel // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReservationKind,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,cancellation: null == cancellation ? _self.cancellation : cancellation // ignore: cast_nullable_to_non_nullable
as Cancellation,manageToken: freezed == manageToken ? _self.manageToken : manageToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingVenueCopyWith<$Res> get venue {
  
  return $BookingVenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingSpaceCopyWith<$Res> get space {
  
  return $BookingSpaceCopyWith<$Res>(_self.space, (value) {
    return _then(_self.copyWith(space: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CancellationCopyWith<$Res> get cancellation {
  
  return $CancellationCopyWith<$Res>(_self.cancellation, (value) {
    return _then(_self.copyWith(cancellation: value));
  });
}
}


/// @nodoc
mixin _$BookingInput {

 String get spaceId; DateTime get startsAt; DateTime get endsAt; String get name; String get email; String? get phone; String? get promo; int get partySize;
/// Create a copy of BookingInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingInputCopyWith<BookingInput> get copyWith => _$BookingInputCopyWithImpl<BookingInput>(this as BookingInput, _$identity);

  /// Serializes this BookingInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BookingInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingInput&&(identical(other.spaceId, _this.spaceId) || other.spaceId == _this.spaceId)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.promo, _this.promo) || other.promo == _this.promo)&&(identical(other.partySize, _this.partySize) || other.partySize == _this.partySize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BookingInput;
  return Object.hash(runtimeType,_this.spaceId,_this.startsAt,_this.endsAt,_this.name,_this.email,_this.phone,_this.promo,_this.partySize);
}

@override
String toString() {
  final _this = this as BookingInput;
  return 'BookingInput(spaceId: ${_this.spaceId}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, name: ${_this.name}, email: ${_this.email}, phone: ${_this.phone}, promo: ${_this.promo}, partySize: ${_this.partySize})';
}


}

/// @nodoc
abstract mixin class $BookingInputCopyWith<$Res>  {
  factory $BookingInputCopyWith(BookingInput value, $Res Function(BookingInput) _then) = _$BookingInputCopyWithImpl;
@useResult
$Res call({
 String spaceId, DateTime startsAt, DateTime endsAt, String name, String email, String? phone, String? promo, int partySize
});




}
/// @nodoc
class _$BookingInputCopyWithImpl<$Res>
    implements $BookingInputCopyWith<$Res> {
  _$BookingInputCopyWithImpl(this._self, this._then);

  final BookingInput _self;
  final $Res Function(BookingInput) _then;

/// Create a copy of BookingInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? spaceId = null,Object? startsAt = null,Object? endsAt = null,Object? name = null,Object? email = null,Object? phone = freezed,Object? promo = freezed,Object? partySize = null,}) {
  return _then(BookingInput(
spaceId: null == spaceId ? _self.spaceId : spaceId // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,promo: freezed == promo ? _self.promo : promo // ignore: cast_nullable_to_non_nullable
as String?,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingInput].
extension BookingInputPatterns on BookingInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingInput value)  $default,){
final _that = this;
switch (_that) {
case _BookingInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingInput value)?  $default,){
final _that = this;
switch (_that) {
case _BookingInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String spaceId,  DateTime startsAt,  DateTime endsAt,  String name,  String email,  String? phone,  String? promo,  int partySize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingInput() when $default != null:
return $default(_that.spaceId,_that.startsAt,_that.endsAt,_that.name,_that.email,_that.phone,_that.promo,_that.partySize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String spaceId,  DateTime startsAt,  DateTime endsAt,  String name,  String email,  String? phone,  String? promo,  int partySize)  $default,) {final _that = this;
switch (_that) {
case _BookingInput():
return $default(_that.spaceId,_that.startsAt,_that.endsAt,_that.name,_that.email,_that.phone,_that.promo,_that.partySize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String spaceId,  DateTime startsAt,  DateTime endsAt,  String name,  String email,  String? phone,  String? promo,  int partySize)?  $default,) {final _that = this;
switch (_that) {
case _BookingInput() when $default != null:
return $default(_that.spaceId,_that.startsAt,_that.endsAt,_that.name,_that.email,_that.phone,_that.promo,_that.partySize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingInput extends BookingInput {
  const _BookingInput({required this.spaceId, required this.startsAt, required this.endsAt, required this.name, required this.email, this.phone, this.promo, this.partySize = 1}): super._();
  factory _BookingInput.fromJson(Map<String, dynamic> json) => _$BookingInputFromJson(json);

@override final  String spaceId;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  String name;
@override final  String email;
@override final  String? phone;
@override final  String? promo;
@override@JsonKey() final  int partySize;

/// Create a copy of BookingInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingInputCopyWith<_BookingInput> get copyWith => __$BookingInputCopyWithImpl<_BookingInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingInputToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingInput&&(identical(other.spaceId, spaceId) || other.spaceId == spaceId)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.promo, promo) || other.promo == promo)&&(identical(other.partySize, partySize) || other.partySize == partySize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,spaceId,startsAt,endsAt,name,email,phone,promo,partySize);
}

@override
String toString() {
    return 'BookingInput(spaceId: $spaceId, startsAt: $startsAt, endsAt: $endsAt, name: $name, email: $email, phone: $phone, promo: $promo, partySize: $partySize)';
}


}

/// @nodoc
abstract mixin class _$BookingInputCopyWith<$Res> implements $BookingInputCopyWith<$Res> {
  factory _$BookingInputCopyWith(_BookingInput value, $Res Function(_BookingInput) _then) = __$BookingInputCopyWithImpl;
@override @useResult
$Res call({
 String spaceId, DateTime startsAt, DateTime endsAt, String name, String email, String? phone, String? promo, int partySize
});




}
/// @nodoc
class __$BookingInputCopyWithImpl<$Res>
    implements _$BookingInputCopyWith<$Res> {
  __$BookingInputCopyWithImpl(this._self, this._then);

  final _BookingInput _self;
  final $Res Function(_BookingInput) _then;

/// Create a copy of BookingInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? spaceId = null,Object? startsAt = null,Object? endsAt = null,Object? name = null,Object? email = null,Object? phone = freezed,Object? promo = freezed,Object? partySize = null,}) {
  return _then(_BookingInput(
spaceId: null == spaceId ? _self.spaceId : spaceId // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,promo: freezed == promo ? _self.promo : promo // ignore: cast_nullable_to_non_nullable
as String?,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
