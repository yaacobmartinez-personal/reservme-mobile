// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VenueSettings {

 String get slug; String get name; String? get tagline; String? get address; String get timezone; String get currency; VenueTheme get theme; String? get logoUrl; String? get coverUrl; int get minNoticeMinutes; int get maxHorizonDays; CancellationMode get cancellationMode; int get cancellationGraceHours; String? get refundTerms; String? get gcashName; bool get suspended; String? get suspendedReason;
/// Create a copy of VenueSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueSettingsCopyWith<VenueSettings> get copyWith => _$VenueSettingsCopyWithImpl<VenueSettings>(this as VenueSettings, _$identity);

  /// Serializes this VenueSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VenueSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueSettings&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.tagline, _this.tagline) || other.tagline == _this.tagline)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.timezone, _this.timezone) || other.timezone == _this.timezone)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.theme, _this.theme) || other.theme == _this.theme)&&(identical(other.logoUrl, _this.logoUrl) || other.logoUrl == _this.logoUrl)&&(identical(other.coverUrl, _this.coverUrl) || other.coverUrl == _this.coverUrl)&&(identical(other.minNoticeMinutes, _this.minNoticeMinutes) || other.minNoticeMinutes == _this.minNoticeMinutes)&&(identical(other.maxHorizonDays, _this.maxHorizonDays) || other.maxHorizonDays == _this.maxHorizonDays)&&(identical(other.cancellationMode, _this.cancellationMode) || other.cancellationMode == _this.cancellationMode)&&(identical(other.cancellationGraceHours, _this.cancellationGraceHours) || other.cancellationGraceHours == _this.cancellationGraceHours)&&(identical(other.refundTerms, _this.refundTerms) || other.refundTerms == _this.refundTerms)&&(identical(other.gcashName, _this.gcashName) || other.gcashName == _this.gcashName)&&(identical(other.suspended, _this.suspended) || other.suspended == _this.suspended)&&(identical(other.suspendedReason, _this.suspendedReason) || other.suspendedReason == _this.suspendedReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VenueSettings;
  return Object.hash(runtimeType,_this.slug,_this.name,_this.tagline,_this.address,_this.timezone,_this.currency,_this.theme,_this.logoUrl,_this.coverUrl,_this.minNoticeMinutes,_this.maxHorizonDays,_this.cancellationMode,_this.cancellationGraceHours,_this.refundTerms,_this.gcashName,_this.suspended,_this.suspendedReason);
}

@override
String toString() {
  final _this = this as VenueSettings;
  return 'VenueSettings(slug: ${_this.slug}, name: ${_this.name}, tagline: ${_this.tagline}, address: ${_this.address}, timezone: ${_this.timezone}, currency: ${_this.currency}, theme: ${_this.theme}, logoUrl: ${_this.logoUrl}, coverUrl: ${_this.coverUrl}, minNoticeMinutes: ${_this.minNoticeMinutes}, maxHorizonDays: ${_this.maxHorizonDays}, cancellationMode: ${_this.cancellationMode}, cancellationGraceHours: ${_this.cancellationGraceHours}, refundTerms: ${_this.refundTerms}, gcashName: ${_this.gcashName}, suspended: ${_this.suspended}, suspendedReason: ${_this.suspendedReason})';
}


}

/// @nodoc
abstract mixin class $VenueSettingsCopyWith<$Res>  {
  factory $VenueSettingsCopyWith(VenueSettings value, $Res Function(VenueSettings) _then) = _$VenueSettingsCopyWithImpl;
@useResult
$Res call({
 String slug, String name, String? tagline, String? address, String timezone, String currency, VenueTheme theme, String? logoUrl, String? coverUrl, int minNoticeMinutes, int maxHorizonDays, CancellationMode cancellationMode, int cancellationGraceHours, String? refundTerms, String? gcashName, bool suspended, String? suspendedReason
});




}
/// @nodoc
class _$VenueSettingsCopyWithImpl<$Res>
    implements $VenueSettingsCopyWith<$Res> {
  _$VenueSettingsCopyWithImpl(this._self, this._then);

  final VenueSettings _self;
  final $Res Function(VenueSettings) _then;

/// Create a copy of VenueSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? name = null,Object? tagline = freezed,Object? address = freezed,Object? timezone = null,Object? currency = null,Object? theme = null,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? minNoticeMinutes = null,Object? maxHorizonDays = null,Object? cancellationMode = null,Object? cancellationGraceHours = null,Object? refundTerms = freezed,Object? gcashName = freezed,Object? suspended = null,Object? suspendedReason = freezed,}) {
  return _then(VenueSettings(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
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
as bool,suspendedReason: freezed == suspendedReason ? _self.suspendedReason : suspendedReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueSettings].
extension VenueSettingsPatterns on VenueSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueSettings value)  $default,){
final _that = this;
switch (_that) {
case _VenueSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueSettings value)?  $default,){
final _that = this;
switch (_that) {
case _VenueSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  String name,  String? tagline,  String? address,  String timezone,  String currency,  VenueTheme theme,  String? logoUrl,  String? coverUrl,  int minNoticeMinutes,  int maxHorizonDays,  CancellationMode cancellationMode,  int cancellationGraceHours,  String? refundTerms,  String? gcashName,  bool suspended,  String? suspendedReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueSettings() when $default != null:
return $default(_that.slug,_that.name,_that.tagline,_that.address,_that.timezone,_that.currency,_that.theme,_that.logoUrl,_that.coverUrl,_that.minNoticeMinutes,_that.maxHorizonDays,_that.cancellationMode,_that.cancellationGraceHours,_that.refundTerms,_that.gcashName,_that.suspended,_that.suspendedReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  String name,  String? tagline,  String? address,  String timezone,  String currency,  VenueTheme theme,  String? logoUrl,  String? coverUrl,  int minNoticeMinutes,  int maxHorizonDays,  CancellationMode cancellationMode,  int cancellationGraceHours,  String? refundTerms,  String? gcashName,  bool suspended,  String? suspendedReason)  $default,) {final _that = this;
switch (_that) {
case _VenueSettings():
return $default(_that.slug,_that.name,_that.tagline,_that.address,_that.timezone,_that.currency,_that.theme,_that.logoUrl,_that.coverUrl,_that.minNoticeMinutes,_that.maxHorizonDays,_that.cancellationMode,_that.cancellationGraceHours,_that.refundTerms,_that.gcashName,_that.suspended,_that.suspendedReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  String name,  String? tagline,  String? address,  String timezone,  String currency,  VenueTheme theme,  String? logoUrl,  String? coverUrl,  int minNoticeMinutes,  int maxHorizonDays,  CancellationMode cancellationMode,  int cancellationGraceHours,  String? refundTerms,  String? gcashName,  bool suspended,  String? suspendedReason)?  $default,) {final _that = this;
switch (_that) {
case _VenueSettings() when $default != null:
return $default(_that.slug,_that.name,_that.tagline,_that.address,_that.timezone,_that.currency,_that.theme,_that.logoUrl,_that.coverUrl,_that.minNoticeMinutes,_that.maxHorizonDays,_that.cancellationMode,_that.cancellationGraceHours,_that.refundTerms,_that.gcashName,_that.suspended,_that.suspendedReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VenueSettings extends VenueSettings {
  const _VenueSettings({required this.slug, required this.name, this.tagline, this.address, this.timezone = 'Asia/Manila', this.currency = 'PHP', this.theme = VenueTheme.pine, this.logoUrl, this.coverUrl, this.minNoticeMinutes = 60, this.maxHorizonDays = 60, this.cancellationMode = CancellationMode.grace, this.cancellationGraceHours = 24, this.refundTerms, this.gcashName, this.suspended = false, this.suspendedReason}): super._();
  factory _VenueSettings.fromJson(Map<String, dynamic> json) => _$VenueSettingsFromJson(json);

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
@override final  String? suspendedReason;

/// Create a copy of VenueSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueSettingsCopyWith<_VenueSettings> get copyWith => __$VenueSettingsCopyWithImpl<_VenueSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VenueSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueSettings&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.address, address) || other.address == address)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.minNoticeMinutes, minNoticeMinutes) || other.minNoticeMinutes == minNoticeMinutes)&&(identical(other.maxHorizonDays, maxHorizonDays) || other.maxHorizonDays == maxHorizonDays)&&(identical(other.cancellationMode, cancellationMode) || other.cancellationMode == cancellationMode)&&(identical(other.cancellationGraceHours, cancellationGraceHours) || other.cancellationGraceHours == cancellationGraceHours)&&(identical(other.refundTerms, refundTerms) || other.refundTerms == refundTerms)&&(identical(other.gcashName, gcashName) || other.gcashName == gcashName)&&(identical(other.suspended, suspended) || other.suspended == suspended)&&(identical(other.suspendedReason, suspendedReason) || other.suspendedReason == suspendedReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,slug,name,tagline,address,timezone,currency,theme,logoUrl,coverUrl,minNoticeMinutes,maxHorizonDays,cancellationMode,cancellationGraceHours,refundTerms,gcashName,suspended,suspendedReason);
}

@override
String toString() {
    return 'VenueSettings(slug: $slug, name: $name, tagline: $tagline, address: $address, timezone: $timezone, currency: $currency, theme: $theme, logoUrl: $logoUrl, coverUrl: $coverUrl, minNoticeMinutes: $minNoticeMinutes, maxHorizonDays: $maxHorizonDays, cancellationMode: $cancellationMode, cancellationGraceHours: $cancellationGraceHours, refundTerms: $refundTerms, gcashName: $gcashName, suspended: $suspended, suspendedReason: $suspendedReason)';
}


}

/// @nodoc
abstract mixin class _$VenueSettingsCopyWith<$Res> implements $VenueSettingsCopyWith<$Res> {
  factory _$VenueSettingsCopyWith(_VenueSettings value, $Res Function(_VenueSettings) _then) = __$VenueSettingsCopyWithImpl;
@override @useResult
$Res call({
 String slug, String name, String? tagline, String? address, String timezone, String currency, VenueTheme theme, String? logoUrl, String? coverUrl, int minNoticeMinutes, int maxHorizonDays, CancellationMode cancellationMode, int cancellationGraceHours, String? refundTerms, String? gcashName, bool suspended, String? suspendedReason
});




}
/// @nodoc
class __$VenueSettingsCopyWithImpl<$Res>
    implements _$VenueSettingsCopyWith<$Res> {
  __$VenueSettingsCopyWithImpl(this._self, this._then);

  final _VenueSettings _self;
  final $Res Function(_VenueSettings) _then;

/// Create a copy of VenueSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? name = null,Object? tagline = freezed,Object? address = freezed,Object? timezone = null,Object? currency = null,Object? theme = null,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? minNoticeMinutes = null,Object? maxHorizonDays = null,Object? cancellationMode = null,Object? cancellationGraceHours = null,Object? refundTerms = freezed,Object? gcashName = freezed,Object? suspended = null,Object? suspendedReason = freezed,}) {
  return _then(_VenueSettings(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
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
as bool,suspendedReason: freezed == suspendedReason ? _self.suspendedReason : suspendedReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
