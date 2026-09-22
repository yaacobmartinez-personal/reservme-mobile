// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_membership.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VenueMembership {

 String get orgId; String get slug; String get name; VenueRole get role; String get timezone; String get currency; VenueTheme get theme; bool get suspended; int get activeSpaces;
/// Create a copy of VenueMembership
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueMembershipCopyWith<VenueMembership> get copyWith => _$VenueMembershipCopyWithImpl<VenueMembership>(this as VenueMembership, _$identity);

  /// Serializes this VenueMembership to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VenueMembership;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueMembership&&(identical(other.orgId, _this.orgId) || other.orgId == _this.orgId)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.timezone, _this.timezone) || other.timezone == _this.timezone)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.theme, _this.theme) || other.theme == _this.theme)&&(identical(other.suspended, _this.suspended) || other.suspended == _this.suspended)&&(identical(other.activeSpaces, _this.activeSpaces) || other.activeSpaces == _this.activeSpaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VenueMembership;
  return Object.hash(runtimeType,_this.orgId,_this.slug,_this.name,_this.role,_this.timezone,_this.currency,_this.theme,_this.suspended,_this.activeSpaces);
}

@override
String toString() {
  final _this = this as VenueMembership;
  return 'VenueMembership(orgId: ${_this.orgId}, slug: ${_this.slug}, name: ${_this.name}, role: ${_this.role}, timezone: ${_this.timezone}, currency: ${_this.currency}, theme: ${_this.theme}, suspended: ${_this.suspended}, activeSpaces: ${_this.activeSpaces})';
}


}

/// @nodoc
abstract mixin class $VenueMembershipCopyWith<$Res>  {
  factory $VenueMembershipCopyWith(VenueMembership value, $Res Function(VenueMembership) _then) = _$VenueMembershipCopyWithImpl;
@useResult
$Res call({
 String orgId, String slug, String name, VenueRole role, String timezone, String currency, VenueTheme theme, bool suspended, int activeSpaces
});




}
/// @nodoc
class _$VenueMembershipCopyWithImpl<$Res>
    implements $VenueMembershipCopyWith<$Res> {
  _$VenueMembershipCopyWithImpl(this._self, this._then);

  final VenueMembership _self;
  final $Res Function(VenueMembership) _then;

/// Create a copy of VenueMembership
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orgId = null,Object? slug = null,Object? name = null,Object? role = null,Object? timezone = null,Object? currency = null,Object? theme = null,Object? suspended = null,Object? activeSpaces = null,}) {
  return _then(VenueMembership(
orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as VenueRole,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as VenueTheme,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueMembership].
extension VenueMembershipPatterns on VenueMembership {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueMembership value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueMembership() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueMembership value)  $default,){
final _that = this;
switch (_that) {
case _VenueMembership():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueMembership value)?  $default,){
final _that = this;
switch (_that) {
case _VenueMembership() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orgId,  String slug,  String name,  VenueRole role,  String timezone,  String currency,  VenueTheme theme,  bool suspended,  int activeSpaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueMembership() when $default != null:
return $default(_that.orgId,_that.slug,_that.name,_that.role,_that.timezone,_that.currency,_that.theme,_that.suspended,_that.activeSpaces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orgId,  String slug,  String name,  VenueRole role,  String timezone,  String currency,  VenueTheme theme,  bool suspended,  int activeSpaces)  $default,) {final _that = this;
switch (_that) {
case _VenueMembership():
return $default(_that.orgId,_that.slug,_that.name,_that.role,_that.timezone,_that.currency,_that.theme,_that.suspended,_that.activeSpaces);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orgId,  String slug,  String name,  VenueRole role,  String timezone,  String currency,  VenueTheme theme,  bool suspended,  int activeSpaces)?  $default,) {final _that = this;
switch (_that) {
case _VenueMembership() when $default != null:
return $default(_that.orgId,_that.slug,_that.name,_that.role,_that.timezone,_that.currency,_that.theme,_that.suspended,_that.activeSpaces);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VenueMembership extends VenueMembership {
  const _VenueMembership({required this.orgId, required this.slug, required this.name, required this.role, this.timezone = 'Asia/Manila', this.currency = 'PHP', this.theme = VenueTheme.pine, this.suspended = false, this.activeSpaces = 0}): super._();
  factory _VenueMembership.fromJson(Map<String, dynamic> json) => _$VenueMembershipFromJson(json);

@override final  String orgId;
@override final  String slug;
@override final  String name;
@override final  VenueRole role;
@override@JsonKey() final  String timezone;
@override@JsonKey() final  String currency;
@override@JsonKey() final  VenueTheme theme;
@override@JsonKey() final  bool suspended;
@override@JsonKey() final  int activeSpaces;

/// Create a copy of VenueMembership
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueMembershipCopyWith<_VenueMembership> get copyWith => __$VenueMembershipCopyWithImpl<_VenueMembership>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VenueMembershipToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueMembership&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.suspended, suspended) || other.suspended == suspended)&&(identical(other.activeSpaces, activeSpaces) || other.activeSpaces == activeSpaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,orgId,slug,name,role,timezone,currency,theme,suspended,activeSpaces);
}

@override
String toString() {
    return 'VenueMembership(orgId: $orgId, slug: $slug, name: $name, role: $role, timezone: $timezone, currency: $currency, theme: $theme, suspended: $suspended, activeSpaces: $activeSpaces)';
}


}

/// @nodoc
abstract mixin class _$VenueMembershipCopyWith<$Res> implements $VenueMembershipCopyWith<$Res> {
  factory _$VenueMembershipCopyWith(_VenueMembership value, $Res Function(_VenueMembership) _then) = __$VenueMembershipCopyWithImpl;
@override @useResult
$Res call({
 String orgId, String slug, String name, VenueRole role, String timezone, String currency, VenueTheme theme, bool suspended, int activeSpaces
});




}
/// @nodoc
class __$VenueMembershipCopyWithImpl<$Res>
    implements _$VenueMembershipCopyWith<$Res> {
  __$VenueMembershipCopyWithImpl(this._self, this._then);

  final _VenueMembership _self;
  final $Res Function(_VenueMembership) _then;

/// Create a copy of VenueMembership
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orgId = null,Object? slug = null,Object? name = null,Object? role = null,Object? timezone = null,Object? currency = null,Object? theme = null,Object? suspended = null,Object? activeSpaces = null,}) {
  return _then(_VenueMembership(
orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as VenueRole,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as VenueTheme,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
