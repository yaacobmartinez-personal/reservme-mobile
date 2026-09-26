// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TenantSummary {

 String get orgId; String get name; String get slug; String get timezone; String get currency; DateTime get createdAt; DateTime? get suspendedAt; String? get suspendedReason;/// Suspended by billing for non-payment — a payment or a comp lifts it. A
/// manual suspension (abuse, a dispute) does not lift that way.
 bool get billingSuspended; int get activeSpaces; int get memberCount; int get upcomingBookings; int get bookingsLast30; int get revenueLast30Cents; TenantSubscription get subscription; TenantBand get band;
/// Create a copy of TenantSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantSummaryCopyWith<TenantSummary> get copyWith => _$TenantSummaryCopyWithImpl<TenantSummary>(this as TenantSummary, _$identity);

  /// Serializes this TenantSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantSummary&&(identical(other.orgId, _this.orgId) || other.orgId == _this.orgId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.timezone, _this.timezone) || other.timezone == _this.timezone)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.suspendedAt, _this.suspendedAt) || other.suspendedAt == _this.suspendedAt)&&(identical(other.suspendedReason, _this.suspendedReason) || other.suspendedReason == _this.suspendedReason)&&(identical(other.billingSuspended, _this.billingSuspended) || other.billingSuspended == _this.billingSuspended)&&(identical(other.activeSpaces, _this.activeSpaces) || other.activeSpaces == _this.activeSpaces)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&(identical(other.upcomingBookings, _this.upcomingBookings) || other.upcomingBookings == _this.upcomingBookings)&&(identical(other.bookingsLast30, _this.bookingsLast30) || other.bookingsLast30 == _this.bookingsLast30)&&(identical(other.revenueLast30Cents, _this.revenueLast30Cents) || other.revenueLast30Cents == _this.revenueLast30Cents)&&(identical(other.subscription, _this.subscription) || other.subscription == _this.subscription)&&(identical(other.band, _this.band) || other.band == _this.band));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantSummary;
  return Object.hash(runtimeType,_this.orgId,_this.name,_this.slug,_this.timezone,_this.currency,_this.createdAt,_this.suspendedAt,_this.suspendedReason,_this.billingSuspended,_this.activeSpaces,_this.memberCount,_this.upcomingBookings,_this.bookingsLast30,_this.revenueLast30Cents,_this.subscription,_this.band);
}

@override
String toString() {
  final _this = this as TenantSummary;
  return 'TenantSummary(orgId: ${_this.orgId}, name: ${_this.name}, slug: ${_this.slug}, timezone: ${_this.timezone}, currency: ${_this.currency}, createdAt: ${_this.createdAt}, suspendedAt: ${_this.suspendedAt}, suspendedReason: ${_this.suspendedReason}, billingSuspended: ${_this.billingSuspended}, activeSpaces: ${_this.activeSpaces}, memberCount: ${_this.memberCount}, upcomingBookings: ${_this.upcomingBookings}, bookingsLast30: ${_this.bookingsLast30}, revenueLast30Cents: ${_this.revenueLast30Cents}, subscription: ${_this.subscription}, band: ${_this.band})';
}


}

/// @nodoc
abstract mixin class $TenantSummaryCopyWith<$Res>  {
  factory $TenantSummaryCopyWith(TenantSummary value, $Res Function(TenantSummary) _then) = _$TenantSummaryCopyWithImpl;
@useResult
$Res call({
 String orgId, String name, String slug, String timezone, String currency, DateTime createdAt, DateTime? suspendedAt, String? suspendedReason, bool billingSuspended, int activeSpaces, int memberCount, int upcomingBookings, int bookingsLast30, int revenueLast30Cents, TenantSubscription subscription, TenantBand band
});


$TenantSubscriptionCopyWith<$Res> get subscription;$TenantBandCopyWith<$Res> get band;

}
/// @nodoc
class _$TenantSummaryCopyWithImpl<$Res>
    implements $TenantSummaryCopyWith<$Res> {
  _$TenantSummaryCopyWithImpl(this._self, this._then);

  final TenantSummary _self;
  final $Res Function(TenantSummary) _then;

/// Create a copy of TenantSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orgId = null,Object? name = null,Object? slug = null,Object? timezone = null,Object? currency = null,Object? createdAt = null,Object? suspendedAt = freezed,Object? suspendedReason = freezed,Object? billingSuspended = null,Object? activeSpaces = null,Object? memberCount = null,Object? upcomingBookings = null,Object? bookingsLast30 = null,Object? revenueLast30Cents = null,Object? subscription = null,Object? band = null,}) {
  return _then(TenantSummary(
orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,suspendedAt: freezed == suspendedAt ? _self.suspendedAt : suspendedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,suspendedReason: freezed == suspendedReason ? _self.suspendedReason : suspendedReason // ignore: cast_nullable_to_non_nullable
as String?,billingSuspended: null == billingSuspended ? _self.billingSuspended : billingSuspended // ignore: cast_nullable_to_non_nullable
as bool,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,upcomingBookings: null == upcomingBookings ? _self.upcomingBookings : upcomingBookings // ignore: cast_nullable_to_non_nullable
as int,bookingsLast30: null == bookingsLast30 ? _self.bookingsLast30 : bookingsLast30 // ignore: cast_nullable_to_non_nullable
as int,revenueLast30Cents: null == revenueLast30Cents ? _self.revenueLast30Cents : revenueLast30Cents // ignore: cast_nullable_to_non_nullable
as int,subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as TenantSubscription,band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as TenantBand,
  ));
}
/// Create a copy of TenantSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantSubscriptionCopyWith<$Res> get subscription {
  
  return $TenantSubscriptionCopyWith<$Res>(_self.subscription, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of TenantSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantBandCopyWith<$Res> get band {
  
  return $TenantBandCopyWith<$Res>(_self.band, (value) {
    return _then(_self.copyWith(band: value));
  });
}
}


/// Adds pattern-matching-related methods to [TenantSummary].
extension TenantSummaryPatterns on TenantSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantSummary value)  $default,){
final _that = this;
switch (_that) {
case _TenantSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TenantSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orgId,  String name,  String slug,  String timezone,  String currency,  DateTime createdAt,  DateTime? suspendedAt,  String? suspendedReason,  bool billingSuspended,  int activeSpaces,  int memberCount,  int upcomingBookings,  int bookingsLast30,  int revenueLast30Cents,  TenantSubscription subscription,  TenantBand band)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantSummary() when $default != null:
return $default(_that.orgId,_that.name,_that.slug,_that.timezone,_that.currency,_that.createdAt,_that.suspendedAt,_that.suspendedReason,_that.billingSuspended,_that.activeSpaces,_that.memberCount,_that.upcomingBookings,_that.bookingsLast30,_that.revenueLast30Cents,_that.subscription,_that.band);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orgId,  String name,  String slug,  String timezone,  String currency,  DateTime createdAt,  DateTime? suspendedAt,  String? suspendedReason,  bool billingSuspended,  int activeSpaces,  int memberCount,  int upcomingBookings,  int bookingsLast30,  int revenueLast30Cents,  TenantSubscription subscription,  TenantBand band)  $default,) {final _that = this;
switch (_that) {
case _TenantSummary():
return $default(_that.orgId,_that.name,_that.slug,_that.timezone,_that.currency,_that.createdAt,_that.suspendedAt,_that.suspendedReason,_that.billingSuspended,_that.activeSpaces,_that.memberCount,_that.upcomingBookings,_that.bookingsLast30,_that.revenueLast30Cents,_that.subscription,_that.band);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orgId,  String name,  String slug,  String timezone,  String currency,  DateTime createdAt,  DateTime? suspendedAt,  String? suspendedReason,  bool billingSuspended,  int activeSpaces,  int memberCount,  int upcomingBookings,  int bookingsLast30,  int revenueLast30Cents,  TenantSubscription subscription,  TenantBand band)?  $default,) {final _that = this;
switch (_that) {
case _TenantSummary() when $default != null:
return $default(_that.orgId,_that.name,_that.slug,_that.timezone,_that.currency,_that.createdAt,_that.suspendedAt,_that.suspendedReason,_that.billingSuspended,_that.activeSpaces,_that.memberCount,_that.upcomingBookings,_that.bookingsLast30,_that.revenueLast30Cents,_that.subscription,_that.band);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantSummary extends TenantSummary {
  const _TenantSummary({required this.orgId, required this.name, required this.slug, this.timezone = 'Asia/Manila', this.currency = 'PHP', required this.createdAt, this.suspendedAt, this.suspendedReason, this.billingSuspended = false, this.activeSpaces = 0, this.memberCount = 0, this.upcomingBookings = 0, this.bookingsLast30 = 0, this.revenueLast30Cents = 0, required this.subscription, required this.band}): super._();
  factory _TenantSummary.fromJson(Map<String, dynamic> json) => _$TenantSummaryFromJson(json);

@override final  String orgId;
@override final  String name;
@override final  String slug;
@override@JsonKey() final  String timezone;
@override@JsonKey() final  String currency;
@override final  DateTime createdAt;
@override final  DateTime? suspendedAt;
@override final  String? suspendedReason;
/// Suspended by billing for non-payment — a payment or a comp lifts it. A
/// manual suspension (abuse, a dispute) does not lift that way.
@override@JsonKey() final  bool billingSuspended;
@override@JsonKey() final  int activeSpaces;
@override@JsonKey() final  int memberCount;
@override@JsonKey() final  int upcomingBookings;
@override@JsonKey() final  int bookingsLast30;
@override@JsonKey() final  int revenueLast30Cents;
@override final  TenantSubscription subscription;
@override final  TenantBand band;

/// Create a copy of TenantSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantSummaryCopyWith<_TenantSummary> get copyWith => __$TenantSummaryCopyWithImpl<_TenantSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantSummary&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.suspendedAt, suspendedAt) || other.suspendedAt == suspendedAt)&&(identical(other.suspendedReason, suspendedReason) || other.suspendedReason == suspendedReason)&&(identical(other.billingSuspended, billingSuspended) || other.billingSuspended == billingSuspended)&&(identical(other.activeSpaces, activeSpaces) || other.activeSpaces == activeSpaces)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.upcomingBookings, upcomingBookings) || other.upcomingBookings == upcomingBookings)&&(identical(other.bookingsLast30, bookingsLast30) || other.bookingsLast30 == bookingsLast30)&&(identical(other.revenueLast30Cents, revenueLast30Cents) || other.revenueLast30Cents == revenueLast30Cents)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&(identical(other.band, band) || other.band == band));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,orgId,name,slug,timezone,currency,createdAt,suspendedAt,suspendedReason,billingSuspended,activeSpaces,memberCount,upcomingBookings,bookingsLast30,revenueLast30Cents,subscription,band);
}

@override
String toString() {
    return 'TenantSummary(orgId: $orgId, name: $name, slug: $slug, timezone: $timezone, currency: $currency, createdAt: $createdAt, suspendedAt: $suspendedAt, suspendedReason: $suspendedReason, billingSuspended: $billingSuspended, activeSpaces: $activeSpaces, memberCount: $memberCount, upcomingBookings: $upcomingBookings, bookingsLast30: $bookingsLast30, revenueLast30Cents: $revenueLast30Cents, subscription: $subscription, band: $band)';
}


}

/// @nodoc
abstract mixin class _$TenantSummaryCopyWith<$Res> implements $TenantSummaryCopyWith<$Res> {
  factory _$TenantSummaryCopyWith(_TenantSummary value, $Res Function(_TenantSummary) _then) = __$TenantSummaryCopyWithImpl;
@override @useResult
$Res call({
 String orgId, String name, String slug, String timezone, String currency, DateTime createdAt, DateTime? suspendedAt, String? suspendedReason, bool billingSuspended, int activeSpaces, int memberCount, int upcomingBookings, int bookingsLast30, int revenueLast30Cents, TenantSubscription subscription, TenantBand band
});


@override $TenantSubscriptionCopyWith<$Res> get subscription;@override $TenantBandCopyWith<$Res> get band;

}
/// @nodoc
class __$TenantSummaryCopyWithImpl<$Res>
    implements _$TenantSummaryCopyWith<$Res> {
  __$TenantSummaryCopyWithImpl(this._self, this._then);

  final _TenantSummary _self;
  final $Res Function(_TenantSummary) _then;

/// Create a copy of TenantSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orgId = null,Object? name = null,Object? slug = null,Object? timezone = null,Object? currency = null,Object? createdAt = null,Object? suspendedAt = freezed,Object? suspendedReason = freezed,Object? billingSuspended = null,Object? activeSpaces = null,Object? memberCount = null,Object? upcomingBookings = null,Object? bookingsLast30 = null,Object? revenueLast30Cents = null,Object? subscription = null,Object? band = null,}) {
  return _then(_TenantSummary(
orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,suspendedAt: freezed == suspendedAt ? _self.suspendedAt : suspendedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,suspendedReason: freezed == suspendedReason ? _self.suspendedReason : suspendedReason // ignore: cast_nullable_to_non_nullable
as String?,billingSuspended: null == billingSuspended ? _self.billingSuspended : billingSuspended // ignore: cast_nullable_to_non_nullable
as bool,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,upcomingBookings: null == upcomingBookings ? _self.upcomingBookings : upcomingBookings // ignore: cast_nullable_to_non_nullable
as int,bookingsLast30: null == bookingsLast30 ? _self.bookingsLast30 : bookingsLast30 // ignore: cast_nullable_to_non_nullable
as int,revenueLast30Cents: null == revenueLast30Cents ? _self.revenueLast30Cents : revenueLast30Cents // ignore: cast_nullable_to_non_nullable
as int,subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as TenantSubscription,band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as TenantBand,
  ));
}

/// Create a copy of TenantSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantSubscriptionCopyWith<$Res> get subscription {
  
  return $TenantSubscriptionCopyWith<$Res>(_self.subscription, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of TenantSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantBandCopyWith<$Res> get band {
  
  return $TenantBandCopyWith<$Res>(_self.band, (value) {
    return _then(_self.copyWith(band: value));
  });
}
}


/// @nodoc
mixin _$TenantSubscription {

 BillingStatus get status; int get trialDaysLeft; bool get dueNow;
/// Create a copy of TenantSubscription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantSubscriptionCopyWith<TenantSubscription> get copyWith => _$TenantSubscriptionCopyWithImpl<TenantSubscription>(this as TenantSubscription, _$identity);

  /// Serializes this TenantSubscription to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantSubscription;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantSubscription&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.trialDaysLeft, _this.trialDaysLeft) || other.trialDaysLeft == _this.trialDaysLeft)&&(identical(other.dueNow, _this.dueNow) || other.dueNow == _this.dueNow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantSubscription;
  return Object.hash(runtimeType,_this.status,_this.trialDaysLeft,_this.dueNow);
}

@override
String toString() {
  final _this = this as TenantSubscription;
  return 'TenantSubscription(status: ${_this.status}, trialDaysLeft: ${_this.trialDaysLeft}, dueNow: ${_this.dueNow})';
}


}

/// @nodoc
abstract mixin class $TenantSubscriptionCopyWith<$Res>  {
  factory $TenantSubscriptionCopyWith(TenantSubscription value, $Res Function(TenantSubscription) _then) = _$TenantSubscriptionCopyWithImpl;
@useResult
$Res call({
 BillingStatus status, int trialDaysLeft, bool dueNow
});




}
/// @nodoc
class _$TenantSubscriptionCopyWithImpl<$Res>
    implements $TenantSubscriptionCopyWith<$Res> {
  _$TenantSubscriptionCopyWithImpl(this._self, this._then);

  final TenantSubscription _self;
  final $Res Function(TenantSubscription) _then;

/// Create a copy of TenantSubscription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? trialDaysLeft = null,Object? dueNow = null,}) {
  return _then(TenantSubscription(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BillingStatus,trialDaysLeft: null == trialDaysLeft ? _self.trialDaysLeft : trialDaysLeft // ignore: cast_nullable_to_non_nullable
as int,dueNow: null == dueNow ? _self.dueNow : dueNow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantSubscription].
extension TenantSubscriptionPatterns on TenantSubscription {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantSubscription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantSubscription() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantSubscription value)  $default,){
final _that = this;
switch (_that) {
case _TenantSubscription():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantSubscription value)?  $default,){
final _that = this;
switch (_that) {
case _TenantSubscription() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BillingStatus status,  int trialDaysLeft,  bool dueNow)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantSubscription() when $default != null:
return $default(_that.status,_that.trialDaysLeft,_that.dueNow);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BillingStatus status,  int trialDaysLeft,  bool dueNow)  $default,) {final _that = this;
switch (_that) {
case _TenantSubscription():
return $default(_that.status,_that.trialDaysLeft,_that.dueNow);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BillingStatus status,  int trialDaysLeft,  bool dueNow)?  $default,) {final _that = this;
switch (_that) {
case _TenantSubscription() when $default != null:
return $default(_that.status,_that.trialDaysLeft,_that.dueNow);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantSubscription implements TenantSubscription {
  const _TenantSubscription({this.status = BillingStatus.trialing, this.trialDaysLeft = 0, this.dueNow = false});
  factory _TenantSubscription.fromJson(Map<String, dynamic> json) => _$TenantSubscriptionFromJson(json);

@override@JsonKey() final  BillingStatus status;
@override@JsonKey() final  int trialDaysLeft;
@override@JsonKey() final  bool dueNow;

/// Create a copy of TenantSubscription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantSubscriptionCopyWith<_TenantSubscription> get copyWith => __$TenantSubscriptionCopyWithImpl<_TenantSubscription>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantSubscriptionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantSubscription&&(identical(other.status, status) || other.status == status)&&(identical(other.trialDaysLeft, trialDaysLeft) || other.trialDaysLeft == trialDaysLeft)&&(identical(other.dueNow, dueNow) || other.dueNow == dueNow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,trialDaysLeft,dueNow);
}

@override
String toString() {
    return 'TenantSubscription(status: $status, trialDaysLeft: $trialDaysLeft, dueNow: $dueNow)';
}


}

/// @nodoc
abstract mixin class _$TenantSubscriptionCopyWith<$Res> implements $TenantSubscriptionCopyWith<$Res> {
  factory _$TenantSubscriptionCopyWith(_TenantSubscription value, $Res Function(_TenantSubscription) _then) = __$TenantSubscriptionCopyWithImpl;
@override @useResult
$Res call({
 BillingStatus status, int trialDaysLeft, bool dueNow
});




}
/// @nodoc
class __$TenantSubscriptionCopyWithImpl<$Res>
    implements _$TenantSubscriptionCopyWith<$Res> {
  __$TenantSubscriptionCopyWithImpl(this._self, this._then);

  final _TenantSubscription _self;
  final $Res Function(_TenantSubscription) _then;

/// Create a copy of TenantSubscription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? trialDaysLeft = null,Object? dueNow = null,}) {
  return _then(_TenantSubscription(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BillingStatus,trialDaysLeft: null == trialDaysLeft ? _self.trialDaysLeft : trialDaysLeft // ignore: cast_nullable_to_non_nullable
as int,dueNow: null == dueNow ? _self.dueNow : dueNow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TenantBand {

 String get name;/// Null for the quoted multi-site band.
 int? get priceCents;
/// Create a copy of TenantBand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantBandCopyWith<TenantBand> get copyWith => _$TenantBandCopyWithImpl<TenantBand>(this as TenantBand, _$identity);

  /// Serializes this TenantBand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantBand;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantBand&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.priceCents, _this.priceCents) || other.priceCents == _this.priceCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantBand;
  return Object.hash(runtimeType,_this.name,_this.priceCents);
}

@override
String toString() {
  final _this = this as TenantBand;
  return 'TenantBand(name: ${_this.name}, priceCents: ${_this.priceCents})';
}


}

/// @nodoc
abstract mixin class $TenantBandCopyWith<$Res>  {
  factory $TenantBandCopyWith(TenantBand value, $Res Function(TenantBand) _then) = _$TenantBandCopyWithImpl;
@useResult
$Res call({
 String name, int? priceCents
});




}
/// @nodoc
class _$TenantBandCopyWithImpl<$Res>
    implements $TenantBandCopyWith<$Res> {
  _$TenantBandCopyWithImpl(this._self, this._then);

  final TenantBand _self;
  final $Res Function(TenantBand) _then;

/// Create a copy of TenantBand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? priceCents = freezed,}) {
  return _then(TenantBand(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priceCents: freezed == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantBand].
extension TenantBandPatterns on TenantBand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantBand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantBand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantBand value)  $default,){
final _that = this;
switch (_that) {
case _TenantBand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantBand value)?  $default,){
final _that = this;
switch (_that) {
case _TenantBand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int? priceCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantBand() when $default != null:
return $default(_that.name,_that.priceCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int? priceCents)  $default,) {final _that = this;
switch (_that) {
case _TenantBand():
return $default(_that.name,_that.priceCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int? priceCents)?  $default,) {final _that = this;
switch (_that) {
case _TenantBand() when $default != null:
return $default(_that.name,_that.priceCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantBand implements TenantBand {
  const _TenantBand({required this.name, this.priceCents});
  factory _TenantBand.fromJson(Map<String, dynamic> json) => _$TenantBandFromJson(json);

@override final  String name;
/// Null for the quoted multi-site band.
@override final  int? priceCents;

/// Create a copy of TenantBand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantBandCopyWith<_TenantBand> get copyWith => __$TenantBandCopyWithImpl<_TenantBand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantBandToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantBand&&(identical(other.name, name) || other.name == name)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,priceCents);
}

@override
String toString() {
    return 'TenantBand(name: $name, priceCents: $priceCents)';
}


}

/// @nodoc
abstract mixin class _$TenantBandCopyWith<$Res> implements $TenantBandCopyWith<$Res> {
  factory _$TenantBandCopyWith(_TenantBand value, $Res Function(_TenantBand) _then) = __$TenantBandCopyWithImpl;
@override @useResult
$Res call({
 String name, int? priceCents
});




}
/// @nodoc
class __$TenantBandCopyWithImpl<$Res>
    implements _$TenantBandCopyWith<$Res> {
  __$TenantBandCopyWithImpl(this._self, this._then);

  final _TenantBand _self;
  final $Res Function(_TenantBand) _then;

/// Create a copy of TenantBand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? priceCents = freezed,}) {
  return _then(_TenantBand(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priceCents: freezed == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$AdminOverview {

 AdminTotals get totals; AdminRadar get radar; int get pendingPayments; List<GrowthPoint> get growth;
/// Create a copy of AdminOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminOverviewCopyWith<AdminOverview> get copyWith => _$AdminOverviewCopyWithImpl<AdminOverview>(this as AdminOverview, _$identity);

  /// Serializes this AdminOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AdminOverview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminOverview&&(identical(other.totals, _this.totals) || other.totals == _this.totals)&&(identical(other.radar, _this.radar) || other.radar == _this.radar)&&(identical(other.pendingPayments, _this.pendingPayments) || other.pendingPayments == _this.pendingPayments)&&const DeepCollectionEquality().equals(other.growth, _this.growth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AdminOverview;
  return Object.hash(runtimeType,_this.totals,_this.radar,_this.pendingPayments,const DeepCollectionEquality().hash(_this.growth));
}

@override
String toString() {
  final _this = this as AdminOverview;
  return 'AdminOverview(totals: ${_this.totals}, radar: ${_this.radar}, pendingPayments: ${_this.pendingPayments}, growth: ${_this.growth})';
}


}

/// @nodoc
abstract mixin class $AdminOverviewCopyWith<$Res>  {
  factory $AdminOverviewCopyWith(AdminOverview value, $Res Function(AdminOverview) _then) = _$AdminOverviewCopyWithImpl;
@useResult
$Res call({
 AdminTotals totals, AdminRadar radar, int pendingPayments, List<GrowthPoint> growth
});


$AdminTotalsCopyWith<$Res> get totals;$AdminRadarCopyWith<$Res> get radar;

}
/// @nodoc
class _$AdminOverviewCopyWithImpl<$Res>
    implements $AdminOverviewCopyWith<$Res> {
  _$AdminOverviewCopyWithImpl(this._self, this._then);

  final AdminOverview _self;
  final $Res Function(AdminOverview) _then;

/// Create a copy of AdminOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totals = null,Object? radar = null,Object? pendingPayments = null,Object? growth = null,}) {
  return _then(AdminOverview(
totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as AdminTotals,radar: null == radar ? _self.radar : radar // ignore: cast_nullable_to_non_nullable
as AdminRadar,pendingPayments: null == pendingPayments ? _self.pendingPayments : pendingPayments // ignore: cast_nullable_to_non_nullable
as int,growth: null == growth ? _self.growth : growth // ignore: cast_nullable_to_non_nullable
as List<GrowthPoint>,
  ));
}
/// Create a copy of AdminOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminTotalsCopyWith<$Res> get totals {
  
  return $AdminTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}/// Create a copy of AdminOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminRadarCopyWith<$Res> get radar {
  
  return $AdminRadarCopyWith<$Res>(_self.radar, (value) {
    return _then(_self.copyWith(radar: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminOverview].
extension AdminOverviewPatterns on AdminOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminOverview value)  $default,){
final _that = this;
switch (_that) {
case _AdminOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminOverview value)?  $default,){
final _that = this;
switch (_that) {
case _AdminOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AdminTotals totals,  AdminRadar radar,  int pendingPayments,  List<GrowthPoint> growth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminOverview() when $default != null:
return $default(_that.totals,_that.radar,_that.pendingPayments,_that.growth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AdminTotals totals,  AdminRadar radar,  int pendingPayments,  List<GrowthPoint> growth)  $default,) {final _that = this;
switch (_that) {
case _AdminOverview():
return $default(_that.totals,_that.radar,_that.pendingPayments,_that.growth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AdminTotals totals,  AdminRadar radar,  int pendingPayments,  List<GrowthPoint> growth)?  $default,) {final _that = this;
switch (_that) {
case _AdminOverview() when $default != null:
return $default(_that.totals,_that.radar,_that.pendingPayments,_that.growth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminOverview implements AdminOverview {
  const _AdminOverview({required this.totals, required this.radar, this.pendingPayments = 0,  List<GrowthPoint> growth = const <GrowthPoint>[]}): _growth = growth;
  factory _AdminOverview.fromJson(Map<String, dynamic> json) => _$AdminOverviewFromJson(json);

@override final  AdminTotals totals;
@override final  AdminRadar radar;
@override@JsonKey() final  int pendingPayments;
 final  List<GrowthPoint> _growth;
@override@JsonKey() List<GrowthPoint> get growth {
  if (_growth is EqualUnmodifiableListView) return _growth;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_growth);
}


/// Create a copy of AdminOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminOverviewCopyWith<_AdminOverview> get copyWith => __$AdminOverviewCopyWithImpl<_AdminOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminOverview&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.radar, radar) || other.radar == radar)&&(identical(other.pendingPayments, pendingPayments) || other.pendingPayments == pendingPayments)&&const DeepCollectionEquality().equals(other.growth, _growth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totals,radar,pendingPayments,const DeepCollectionEquality().hash(_growth));
}

@override
String toString() {
    return 'AdminOverview(totals: $totals, radar: $radar, pendingPayments: $pendingPayments, growth: $growth)';
}


}

/// @nodoc
abstract mixin class _$AdminOverviewCopyWith<$Res> implements $AdminOverviewCopyWith<$Res> {
  factory _$AdminOverviewCopyWith(_AdminOverview value, $Res Function(_AdminOverview) _then) = __$AdminOverviewCopyWithImpl;
@override @useResult
$Res call({
 AdminTotals totals, AdminRadar radar, int pendingPayments, List<GrowthPoint> growth
});


@override $AdminTotalsCopyWith<$Res> get totals;@override $AdminRadarCopyWith<$Res> get radar;

}
/// @nodoc
class __$AdminOverviewCopyWithImpl<$Res>
    implements _$AdminOverviewCopyWith<$Res> {
  __$AdminOverviewCopyWithImpl(this._self, this._then);

  final _AdminOverview _self;
  final $Res Function(_AdminOverview) _then;

/// Create a copy of AdminOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totals = null,Object? radar = null,Object? pendingPayments = null,Object? growth = null,}) {
  return _then(_AdminOverview(
totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as AdminTotals,radar: null == radar ? _self.radar : radar // ignore: cast_nullable_to_non_nullable
as AdminRadar,pendingPayments: null == pendingPayments ? _self.pendingPayments : pendingPayments // ignore: cast_nullable_to_non_nullable
as int,growth: null == growth ? _self._growth : growth // ignore: cast_nullable_to_non_nullable
as List<GrowthPoint>,
  ));
}

/// Create a copy of AdminOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminTotalsCopyWith<$Res> get totals {
  
  return $AdminTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}/// Create a copy of AdminOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminRadarCopyWith<$Res> get radar {
  
  return $AdminRadarCopyWith<$Res>(_self.radar, (value) {
    return _then(_self.copyWith(radar: value));
  });
}
}


/// @nodoc
mixin _$AdminTotals {

 int get tenants; int get suspended; int get activeSpaces; int get bookingsLast30; int get customers;/// What the platform would bill this month if every unsuspended venue
/// paid its band today.
 int get runRateCents;
/// Create a copy of AdminTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminTotalsCopyWith<AdminTotals> get copyWith => _$AdminTotalsCopyWithImpl<AdminTotals>(this as AdminTotals, _$identity);

  /// Serializes this AdminTotals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AdminTotals;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminTotals&&(identical(other.tenants, _this.tenants) || other.tenants == _this.tenants)&&(identical(other.suspended, _this.suspended) || other.suspended == _this.suspended)&&(identical(other.activeSpaces, _this.activeSpaces) || other.activeSpaces == _this.activeSpaces)&&(identical(other.bookingsLast30, _this.bookingsLast30) || other.bookingsLast30 == _this.bookingsLast30)&&(identical(other.customers, _this.customers) || other.customers == _this.customers)&&(identical(other.runRateCents, _this.runRateCents) || other.runRateCents == _this.runRateCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AdminTotals;
  return Object.hash(runtimeType,_this.tenants,_this.suspended,_this.activeSpaces,_this.bookingsLast30,_this.customers,_this.runRateCents);
}

@override
String toString() {
  final _this = this as AdminTotals;
  return 'AdminTotals(tenants: ${_this.tenants}, suspended: ${_this.suspended}, activeSpaces: ${_this.activeSpaces}, bookingsLast30: ${_this.bookingsLast30}, customers: ${_this.customers}, runRateCents: ${_this.runRateCents})';
}


}

/// @nodoc
abstract mixin class $AdminTotalsCopyWith<$Res>  {
  factory $AdminTotalsCopyWith(AdminTotals value, $Res Function(AdminTotals) _then) = _$AdminTotalsCopyWithImpl;
@useResult
$Res call({
 int tenants, int suspended, int activeSpaces, int bookingsLast30, int customers, int runRateCents
});




}
/// @nodoc
class _$AdminTotalsCopyWithImpl<$Res>
    implements $AdminTotalsCopyWith<$Res> {
  _$AdminTotalsCopyWithImpl(this._self, this._then);

  final AdminTotals _self;
  final $Res Function(AdminTotals) _then;

/// Create a copy of AdminTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tenants = null,Object? suspended = null,Object? activeSpaces = null,Object? bookingsLast30 = null,Object? customers = null,Object? runRateCents = null,}) {
  return _then(AdminTotals(
tenants: null == tenants ? _self.tenants : tenants // ignore: cast_nullable_to_non_nullable
as int,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as int,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,bookingsLast30: null == bookingsLast30 ? _self.bookingsLast30 : bookingsLast30 // ignore: cast_nullable_to_non_nullable
as int,customers: null == customers ? _self.customers : customers // ignore: cast_nullable_to_non_nullable
as int,runRateCents: null == runRateCents ? _self.runRateCents : runRateCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminTotals].
extension AdminTotalsPatterns on AdminTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminTotals value)  $default,){
final _that = this;
switch (_that) {
case _AdminTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminTotals value)?  $default,){
final _that = this;
switch (_that) {
case _AdminTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int tenants,  int suspended,  int activeSpaces,  int bookingsLast30,  int customers,  int runRateCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminTotals() when $default != null:
return $default(_that.tenants,_that.suspended,_that.activeSpaces,_that.bookingsLast30,_that.customers,_that.runRateCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int tenants,  int suspended,  int activeSpaces,  int bookingsLast30,  int customers,  int runRateCents)  $default,) {final _that = this;
switch (_that) {
case _AdminTotals():
return $default(_that.tenants,_that.suspended,_that.activeSpaces,_that.bookingsLast30,_that.customers,_that.runRateCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int tenants,  int suspended,  int activeSpaces,  int bookingsLast30,  int customers,  int runRateCents)?  $default,) {final _that = this;
switch (_that) {
case _AdminTotals() when $default != null:
return $default(_that.tenants,_that.suspended,_that.activeSpaces,_that.bookingsLast30,_that.customers,_that.runRateCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminTotals implements AdminTotals {
  const _AdminTotals({this.tenants = 0, this.suspended = 0, this.activeSpaces = 0, this.bookingsLast30 = 0, this.customers = 0, this.runRateCents = 0});
  factory _AdminTotals.fromJson(Map<String, dynamic> json) => _$AdminTotalsFromJson(json);

@override@JsonKey() final  int tenants;
@override@JsonKey() final  int suspended;
@override@JsonKey() final  int activeSpaces;
@override@JsonKey() final  int bookingsLast30;
@override@JsonKey() final  int customers;
/// What the platform would bill this month if every unsuspended venue
/// paid its band today.
@override@JsonKey() final  int runRateCents;

/// Create a copy of AdminTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminTotalsCopyWith<_AdminTotals> get copyWith => __$AdminTotalsCopyWithImpl<_AdminTotals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminTotalsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminTotals&&(identical(other.tenants, tenants) || other.tenants == tenants)&&(identical(other.suspended, suspended) || other.suspended == suspended)&&(identical(other.activeSpaces, activeSpaces) || other.activeSpaces == activeSpaces)&&(identical(other.bookingsLast30, bookingsLast30) || other.bookingsLast30 == bookingsLast30)&&(identical(other.customers, customers) || other.customers == customers)&&(identical(other.runRateCents, runRateCents) || other.runRateCents == runRateCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tenants,suspended,activeSpaces,bookingsLast30,customers,runRateCents);
}

@override
String toString() {
    return 'AdminTotals(tenants: $tenants, suspended: $suspended, activeSpaces: $activeSpaces, bookingsLast30: $bookingsLast30, customers: $customers, runRateCents: $runRateCents)';
}


}

/// @nodoc
abstract mixin class _$AdminTotalsCopyWith<$Res> implements $AdminTotalsCopyWith<$Res> {
  factory _$AdminTotalsCopyWith(_AdminTotals value, $Res Function(_AdminTotals) _then) = __$AdminTotalsCopyWithImpl;
@override @useResult
$Res call({
 int tenants, int suspended, int activeSpaces, int bookingsLast30, int customers, int runRateCents
});




}
/// @nodoc
class __$AdminTotalsCopyWithImpl<$Res>
    implements _$AdminTotalsCopyWith<$Res> {
  __$AdminTotalsCopyWithImpl(this._self, this._then);

  final _AdminTotals _self;
  final $Res Function(_AdminTotals) _then;

/// Create a copy of AdminTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tenants = null,Object? suspended = null,Object? activeSpaces = null,Object? bookingsLast30 = null,Object? customers = null,Object? runRateCents = null,}) {
  return _then(_AdminTotals(
tenants: null == tenants ? _self.tenants : tenants // ignore: cast_nullable_to_non_nullable
as int,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as int,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,bookingsLast30: null == bookingsLast30 ? _self.bookingsLast30 : bookingsLast30 // ignore: cast_nullable_to_non_nullable
as int,customers: null == customers ? _self.customers : customers // ignore: cast_nullable_to_non_nullable
as int,runRateCents: null == runRateCents ? _self.runRateCents : runRateCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AdminRadar {

/// Trials ending within five days.
 List<TenantSummary> get endingSoon;/// Overdue, not yet switched off.
 List<TenantSummary> get inGrace;/// Switched off by billing.
 List<TenantSummary> get suspended;
/// Create a copy of AdminRadar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminRadarCopyWith<AdminRadar> get copyWith => _$AdminRadarCopyWithImpl<AdminRadar>(this as AdminRadar, _$identity);

  /// Serializes this AdminRadar to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AdminRadar;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminRadar&&const DeepCollectionEquality().equals(other.endingSoon, _this.endingSoon)&&const DeepCollectionEquality().equals(other.inGrace, _this.inGrace)&&const DeepCollectionEquality().equals(other.suspended, _this.suspended));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AdminRadar;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.endingSoon),const DeepCollectionEquality().hash(_this.inGrace),const DeepCollectionEquality().hash(_this.suspended));
}

@override
String toString() {
  final _this = this as AdminRadar;
  return 'AdminRadar(endingSoon: ${_this.endingSoon}, inGrace: ${_this.inGrace}, suspended: ${_this.suspended})';
}


}

/// @nodoc
abstract mixin class $AdminRadarCopyWith<$Res>  {
  factory $AdminRadarCopyWith(AdminRadar value, $Res Function(AdminRadar) _then) = _$AdminRadarCopyWithImpl;
@useResult
$Res call({
 List<TenantSummary> endingSoon, List<TenantSummary> inGrace, List<TenantSummary> suspended
});




}
/// @nodoc
class _$AdminRadarCopyWithImpl<$Res>
    implements $AdminRadarCopyWith<$Res> {
  _$AdminRadarCopyWithImpl(this._self, this._then);

  final AdminRadar _self;
  final $Res Function(AdminRadar) _then;

/// Create a copy of AdminRadar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? endingSoon = null,Object? inGrace = null,Object? suspended = null,}) {
  return _then(AdminRadar(
endingSoon: null == endingSoon ? _self.endingSoon : endingSoon // ignore: cast_nullable_to_non_nullable
as List<TenantSummary>,inGrace: null == inGrace ? _self.inGrace : inGrace // ignore: cast_nullable_to_non_nullable
as List<TenantSummary>,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as List<TenantSummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminRadar].
extension AdminRadarPatterns on AdminRadar {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminRadar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminRadar() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminRadar value)  $default,){
final _that = this;
switch (_that) {
case _AdminRadar():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminRadar value)?  $default,){
final _that = this;
switch (_that) {
case _AdminRadar() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TenantSummary> endingSoon,  List<TenantSummary> inGrace,  List<TenantSummary> suspended)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminRadar() when $default != null:
return $default(_that.endingSoon,_that.inGrace,_that.suspended);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TenantSummary> endingSoon,  List<TenantSummary> inGrace,  List<TenantSummary> suspended)  $default,) {final _that = this;
switch (_that) {
case _AdminRadar():
return $default(_that.endingSoon,_that.inGrace,_that.suspended);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TenantSummary> endingSoon,  List<TenantSummary> inGrace,  List<TenantSummary> suspended)?  $default,) {final _that = this;
switch (_that) {
case _AdminRadar() when $default != null:
return $default(_that.endingSoon,_that.inGrace,_that.suspended);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminRadar extends AdminRadar {
  const _AdminRadar({ List<TenantSummary> endingSoon = const <TenantSummary>[],  List<TenantSummary> inGrace = const <TenantSummary>[],  List<TenantSummary> suspended = const <TenantSummary>[]}): _endingSoon = endingSoon,_inGrace = inGrace,_suspended = suspended,super._();
  factory _AdminRadar.fromJson(Map<String, dynamic> json) => _$AdminRadarFromJson(json);

/// Trials ending within five days.
 final  List<TenantSummary> _endingSoon;
/// Trials ending within five days.
@override@JsonKey() List<TenantSummary> get endingSoon {
  if (_endingSoon is EqualUnmodifiableListView) return _endingSoon;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_endingSoon);
}

/// Overdue, not yet switched off.
 final  List<TenantSummary> _inGrace;
/// Overdue, not yet switched off.
@override@JsonKey() List<TenantSummary> get inGrace {
  if (_inGrace is EqualUnmodifiableListView) return _inGrace;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inGrace);
}

/// Switched off by billing.
 final  List<TenantSummary> _suspended;
/// Switched off by billing.
@override@JsonKey() List<TenantSummary> get suspended {
  if (_suspended is EqualUnmodifiableListView) return _suspended;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suspended);
}


/// Create a copy of AdminRadar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminRadarCopyWith<_AdminRadar> get copyWith => __$AdminRadarCopyWithImpl<_AdminRadar>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminRadarToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminRadar&&const DeepCollectionEquality().equals(other.endingSoon, _endingSoon)&&const DeepCollectionEquality().equals(other.inGrace, _inGrace)&&const DeepCollectionEquality().equals(other.suspended, _suspended));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_endingSoon),const DeepCollectionEquality().hash(_inGrace),const DeepCollectionEquality().hash(_suspended));
}

@override
String toString() {
    return 'AdminRadar(endingSoon: $endingSoon, inGrace: $inGrace, suspended: $suspended)';
}


}

/// @nodoc
abstract mixin class _$AdminRadarCopyWith<$Res> implements $AdminRadarCopyWith<$Res> {
  factory _$AdminRadarCopyWith(_AdminRadar value, $Res Function(_AdminRadar) _then) = __$AdminRadarCopyWithImpl;
@override @useResult
$Res call({
 List<TenantSummary> endingSoon, List<TenantSummary> inGrace, List<TenantSummary> suspended
});




}
/// @nodoc
class __$AdminRadarCopyWithImpl<$Res>
    implements _$AdminRadarCopyWith<$Res> {
  __$AdminRadarCopyWithImpl(this._self, this._then);

  final _AdminRadar _self;
  final $Res Function(_AdminRadar) _then;

/// Create a copy of AdminRadar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? endingSoon = null,Object? inGrace = null,Object? suspended = null,}) {
  return _then(_AdminRadar(
endingSoon: null == endingSoon ? _self._endingSoon : endingSoon // ignore: cast_nullable_to_non_nullable
as List<TenantSummary>,inGrace: null == inGrace ? _self._inGrace : inGrace // ignore: cast_nullable_to_non_nullable
as List<TenantSummary>,suspended: null == suspended ? _self._suspended : suspended // ignore: cast_nullable_to_non_nullable
as List<TenantSummary>,
  ));
}


}


/// @nodoc
mixin _$GrowthPoint {

/// `YYYY-MM`.
 String get month; int get signups; int get cancellations; int get cumulative;
/// Create a copy of GrowthPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GrowthPointCopyWith<GrowthPoint> get copyWith => _$GrowthPointCopyWithImpl<GrowthPoint>(this as GrowthPoint, _$identity);

  /// Serializes this GrowthPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GrowthPoint;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GrowthPoint&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.signups, _this.signups) || other.signups == _this.signups)&&(identical(other.cancellations, _this.cancellations) || other.cancellations == _this.cancellations)&&(identical(other.cumulative, _this.cumulative) || other.cumulative == _this.cumulative));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GrowthPoint;
  return Object.hash(runtimeType,_this.month,_this.signups,_this.cancellations,_this.cumulative);
}

@override
String toString() {
  final _this = this as GrowthPoint;
  return 'GrowthPoint(month: ${_this.month}, signups: ${_this.signups}, cancellations: ${_this.cancellations}, cumulative: ${_this.cumulative})';
}


}

/// @nodoc
abstract mixin class $GrowthPointCopyWith<$Res>  {
  factory $GrowthPointCopyWith(GrowthPoint value, $Res Function(GrowthPoint) _then) = _$GrowthPointCopyWithImpl;
@useResult
$Res call({
 String month, int signups, int cancellations, int cumulative
});




}
/// @nodoc
class _$GrowthPointCopyWithImpl<$Res>
    implements $GrowthPointCopyWith<$Res> {
  _$GrowthPointCopyWithImpl(this._self, this._then);

  final GrowthPoint _self;
  final $Res Function(GrowthPoint) _then;

/// Create a copy of GrowthPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? signups = null,Object? cancellations = null,Object? cumulative = null,}) {
  return _then(GrowthPoint(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,signups: null == signups ? _self.signups : signups // ignore: cast_nullable_to_non_nullable
as int,cancellations: null == cancellations ? _self.cancellations : cancellations // ignore: cast_nullable_to_non_nullable
as int,cumulative: null == cumulative ? _self.cumulative : cumulative // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GrowthPoint].
extension GrowthPointPatterns on GrowthPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GrowthPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GrowthPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GrowthPoint value)  $default,){
final _that = this;
switch (_that) {
case _GrowthPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GrowthPoint value)?  $default,){
final _that = this;
switch (_that) {
case _GrowthPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  int signups,  int cancellations,  int cumulative)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GrowthPoint() when $default != null:
return $default(_that.month,_that.signups,_that.cancellations,_that.cumulative);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  int signups,  int cancellations,  int cumulative)  $default,) {final _that = this;
switch (_that) {
case _GrowthPoint():
return $default(_that.month,_that.signups,_that.cancellations,_that.cumulative);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  int signups,  int cancellations,  int cumulative)?  $default,) {final _that = this;
switch (_that) {
case _GrowthPoint() when $default != null:
return $default(_that.month,_that.signups,_that.cancellations,_that.cumulative);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GrowthPoint implements GrowthPoint {
  const _GrowthPoint({required this.month, this.signups = 0, this.cancellations = 0, this.cumulative = 0});
  factory _GrowthPoint.fromJson(Map<String, dynamic> json) => _$GrowthPointFromJson(json);

/// `YYYY-MM`.
@override final  String month;
@override@JsonKey() final  int signups;
@override@JsonKey() final  int cancellations;
@override@JsonKey() final  int cumulative;

/// Create a copy of GrowthPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GrowthPointCopyWith<_GrowthPoint> get copyWith => __$GrowthPointCopyWithImpl<_GrowthPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GrowthPointToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GrowthPoint&&(identical(other.month, month) || other.month == month)&&(identical(other.signups, signups) || other.signups == signups)&&(identical(other.cancellations, cancellations) || other.cancellations == cancellations)&&(identical(other.cumulative, cumulative) || other.cumulative == cumulative));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,month,signups,cancellations,cumulative);
}

@override
String toString() {
    return 'GrowthPoint(month: $month, signups: $signups, cancellations: $cancellations, cumulative: $cumulative)';
}


}

/// @nodoc
abstract mixin class _$GrowthPointCopyWith<$Res> implements $GrowthPointCopyWith<$Res> {
  factory _$GrowthPointCopyWith(_GrowthPoint value, $Res Function(_GrowthPoint) _then) = __$GrowthPointCopyWithImpl;
@override @useResult
$Res call({
 String month, int signups, int cancellations, int cumulative
});




}
/// @nodoc
class __$GrowthPointCopyWithImpl<$Res>
    implements _$GrowthPointCopyWith<$Res> {
  __$GrowthPointCopyWithImpl(this._self, this._then);

  final _GrowthPoint _self;
  final $Res Function(_GrowthPoint) _then;

/// Create a copy of GrowthPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? signups = null,Object? cancellations = null,Object? cumulative = null,}) {
  return _then(_GrowthPoint(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,signups: null == signups ? _self.signups : signups // ignore: cast_nullable_to_non_nullable
as int,cancellations: null == cancellations ? _self.cancellations : cancellations // ignore: cast_nullable_to_non_nullable
as int,cumulative: null == cumulative ? _self.cumulative : cumulative // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TenantDetail {

 TenantDetailSummary get tenant; List<TenantSpace> get spaces; List<TenantMember> get members; List<TenantBooking> get recentBookings; List<AdminPayment> get payments;
/// Create a copy of TenantDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantDetailCopyWith<TenantDetail> get copyWith => _$TenantDetailCopyWithImpl<TenantDetail>(this as TenantDetail, _$identity);

  /// Serializes this TenantDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantDetail&&(identical(other.tenant, _this.tenant) || other.tenant == _this.tenant)&&const DeepCollectionEquality().equals(other.spaces, _this.spaces)&&const DeepCollectionEquality().equals(other.members, _this.members)&&const DeepCollectionEquality().equals(other.recentBookings, _this.recentBookings)&&const DeepCollectionEquality().equals(other.payments, _this.payments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantDetail;
  return Object.hash(runtimeType,_this.tenant,const DeepCollectionEquality().hash(_this.spaces),const DeepCollectionEquality().hash(_this.members),const DeepCollectionEquality().hash(_this.recentBookings),const DeepCollectionEquality().hash(_this.payments));
}

@override
String toString() {
  final _this = this as TenantDetail;
  return 'TenantDetail(tenant: ${_this.tenant}, spaces: ${_this.spaces}, members: ${_this.members}, recentBookings: ${_this.recentBookings}, payments: ${_this.payments})';
}


}

/// @nodoc
abstract mixin class $TenantDetailCopyWith<$Res>  {
  factory $TenantDetailCopyWith(TenantDetail value, $Res Function(TenantDetail) _then) = _$TenantDetailCopyWithImpl;
@useResult
$Res call({
 TenantDetailSummary tenant, List<TenantSpace> spaces, List<TenantMember> members, List<TenantBooking> recentBookings, List<AdminPayment> payments
});


$TenantDetailSummaryCopyWith<$Res> get tenant;

}
/// @nodoc
class _$TenantDetailCopyWithImpl<$Res>
    implements $TenantDetailCopyWith<$Res> {
  _$TenantDetailCopyWithImpl(this._self, this._then);

  final TenantDetail _self;
  final $Res Function(TenantDetail) _then;

/// Create a copy of TenantDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tenant = null,Object? spaces = null,Object? members = null,Object? recentBookings = null,Object? payments = null,}) {
  return _then(TenantDetail(
tenant: null == tenant ? _self.tenant : tenant // ignore: cast_nullable_to_non_nullable
as TenantDetailSummary,spaces: null == spaces ? _self.spaces : spaces // ignore: cast_nullable_to_non_nullable
as List<TenantSpace>,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<TenantMember>,recentBookings: null == recentBookings ? _self.recentBookings : recentBookings // ignore: cast_nullable_to_non_nullable
as List<TenantBooking>,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<AdminPayment>,
  ));
}
/// Create a copy of TenantDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantDetailSummaryCopyWith<$Res> get tenant {
  
  return $TenantDetailSummaryCopyWith<$Res>(_self.tenant, (value) {
    return _then(_self.copyWith(tenant: value));
  });
}
}


/// Adds pattern-matching-related methods to [TenantDetail].
extension TenantDetailPatterns on TenantDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantDetail value)  $default,){
final _that = this;
switch (_that) {
case _TenantDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantDetail value)?  $default,){
final _that = this;
switch (_that) {
case _TenantDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TenantDetailSummary tenant,  List<TenantSpace> spaces,  List<TenantMember> members,  List<TenantBooking> recentBookings,  List<AdminPayment> payments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantDetail() when $default != null:
return $default(_that.tenant,_that.spaces,_that.members,_that.recentBookings,_that.payments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TenantDetailSummary tenant,  List<TenantSpace> spaces,  List<TenantMember> members,  List<TenantBooking> recentBookings,  List<AdminPayment> payments)  $default,) {final _that = this;
switch (_that) {
case _TenantDetail():
return $default(_that.tenant,_that.spaces,_that.members,_that.recentBookings,_that.payments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TenantDetailSummary tenant,  List<TenantSpace> spaces,  List<TenantMember> members,  List<TenantBooking> recentBookings,  List<AdminPayment> payments)?  $default,) {final _that = this;
switch (_that) {
case _TenantDetail() when $default != null:
return $default(_that.tenant,_that.spaces,_that.members,_that.recentBookings,_that.payments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantDetail implements TenantDetail {
  const _TenantDetail({required this.tenant,  List<TenantSpace> spaces = const <TenantSpace>[],  List<TenantMember> members = const <TenantMember>[],  List<TenantBooking> recentBookings = const <TenantBooking>[],  List<AdminPayment> payments = const <AdminPayment>[]}): _spaces = spaces,_members = members,_recentBookings = recentBookings,_payments = payments;
  factory _TenantDetail.fromJson(Map<String, dynamic> json) => _$TenantDetailFromJson(json);

@override final  TenantDetailSummary tenant;
 final  List<TenantSpace> _spaces;
@override@JsonKey() List<TenantSpace> get spaces {
  if (_spaces is EqualUnmodifiableListView) return _spaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_spaces);
}

 final  List<TenantMember> _members;
@override@JsonKey() List<TenantMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

 final  List<TenantBooking> _recentBookings;
@override@JsonKey() List<TenantBooking> get recentBookings {
  if (_recentBookings is EqualUnmodifiableListView) return _recentBookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentBookings);
}

 final  List<AdminPayment> _payments;
@override@JsonKey() List<AdminPayment> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}


/// Create a copy of TenantDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantDetailCopyWith<_TenantDetail> get copyWith => __$TenantDetailCopyWithImpl<_TenantDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantDetail&&(identical(other.tenant, tenant) || other.tenant == tenant)&&const DeepCollectionEquality().equals(other.spaces, _spaces)&&const DeepCollectionEquality().equals(other.members, _members)&&const DeepCollectionEquality().equals(other.recentBookings, _recentBookings)&&const DeepCollectionEquality().equals(other.payments, _payments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tenant,const DeepCollectionEquality().hash(_spaces),const DeepCollectionEquality().hash(_members),const DeepCollectionEquality().hash(_recentBookings),const DeepCollectionEquality().hash(_payments));
}

@override
String toString() {
    return 'TenantDetail(tenant: $tenant, spaces: $spaces, members: $members, recentBookings: $recentBookings, payments: $payments)';
}


}

/// @nodoc
abstract mixin class _$TenantDetailCopyWith<$Res> implements $TenantDetailCopyWith<$Res> {
  factory _$TenantDetailCopyWith(_TenantDetail value, $Res Function(_TenantDetail) _then) = __$TenantDetailCopyWithImpl;
@override @useResult
$Res call({
 TenantDetailSummary tenant, List<TenantSpace> spaces, List<TenantMember> members, List<TenantBooking> recentBookings, List<AdminPayment> payments
});


@override $TenantDetailSummaryCopyWith<$Res> get tenant;

}
/// @nodoc
class __$TenantDetailCopyWithImpl<$Res>
    implements _$TenantDetailCopyWith<$Res> {
  __$TenantDetailCopyWithImpl(this._self, this._then);

  final _TenantDetail _self;
  final $Res Function(_TenantDetail) _then;

/// Create a copy of TenantDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tenant = null,Object? spaces = null,Object? members = null,Object? recentBookings = null,Object? payments = null,}) {
  return _then(_TenantDetail(
tenant: null == tenant ? _self.tenant : tenant // ignore: cast_nullable_to_non_nullable
as TenantDetailSummary,spaces: null == spaces ? _self._spaces : spaces // ignore: cast_nullable_to_non_nullable
as List<TenantSpace>,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<TenantMember>,recentBookings: null == recentBookings ? _self._recentBookings : recentBookings // ignore: cast_nullable_to_non_nullable
as List<TenantBooking>,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<AdminPayment>,
  ));
}

/// Create a copy of TenantDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantDetailSummaryCopyWith<$Res> get tenant {
  
  return $TenantDetailSummaryCopyWith<$Res>(_self.tenant, (value) {
    return _then(_self.copyWith(tenant: value));
  });
}
}


/// @nodoc
mixin _$TenantDetailSummary {

 String get orgId; String get name; String get slug; String get timezone; String get currency; DateTime get createdAt; DateTime? get suspendedAt; String? get suspendedReason; bool get billingSuspended; int get activeSpaces; int get memberCount; int get upcomingBookings; int get bookingsLast30; int get revenueLast30Cents; TenantSubscription get subscription; TenantBand get band; DateTime? get paidUntil; DateTime? get trialEndsAt;
/// Create a copy of TenantDetailSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantDetailSummaryCopyWith<TenantDetailSummary> get copyWith => _$TenantDetailSummaryCopyWithImpl<TenantDetailSummary>(this as TenantDetailSummary, _$identity);

  /// Serializes this TenantDetailSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantDetailSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantDetailSummary&&(identical(other.orgId, _this.orgId) || other.orgId == _this.orgId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.timezone, _this.timezone) || other.timezone == _this.timezone)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.suspendedAt, _this.suspendedAt) || other.suspendedAt == _this.suspendedAt)&&(identical(other.suspendedReason, _this.suspendedReason) || other.suspendedReason == _this.suspendedReason)&&(identical(other.billingSuspended, _this.billingSuspended) || other.billingSuspended == _this.billingSuspended)&&(identical(other.activeSpaces, _this.activeSpaces) || other.activeSpaces == _this.activeSpaces)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&(identical(other.upcomingBookings, _this.upcomingBookings) || other.upcomingBookings == _this.upcomingBookings)&&(identical(other.bookingsLast30, _this.bookingsLast30) || other.bookingsLast30 == _this.bookingsLast30)&&(identical(other.revenueLast30Cents, _this.revenueLast30Cents) || other.revenueLast30Cents == _this.revenueLast30Cents)&&(identical(other.subscription, _this.subscription) || other.subscription == _this.subscription)&&(identical(other.band, _this.band) || other.band == _this.band)&&(identical(other.paidUntil, _this.paidUntil) || other.paidUntil == _this.paidUntil)&&(identical(other.trialEndsAt, _this.trialEndsAt) || other.trialEndsAt == _this.trialEndsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantDetailSummary;
  return Object.hash(runtimeType,_this.orgId,_this.name,_this.slug,_this.timezone,_this.currency,_this.createdAt,_this.suspendedAt,_this.suspendedReason,_this.billingSuspended,_this.activeSpaces,_this.memberCount,_this.upcomingBookings,_this.bookingsLast30,_this.revenueLast30Cents,_this.subscription,_this.band,_this.paidUntil,_this.trialEndsAt);
}

@override
String toString() {
  final _this = this as TenantDetailSummary;
  return 'TenantDetailSummary(orgId: ${_this.orgId}, name: ${_this.name}, slug: ${_this.slug}, timezone: ${_this.timezone}, currency: ${_this.currency}, createdAt: ${_this.createdAt}, suspendedAt: ${_this.suspendedAt}, suspendedReason: ${_this.suspendedReason}, billingSuspended: ${_this.billingSuspended}, activeSpaces: ${_this.activeSpaces}, memberCount: ${_this.memberCount}, upcomingBookings: ${_this.upcomingBookings}, bookingsLast30: ${_this.bookingsLast30}, revenueLast30Cents: ${_this.revenueLast30Cents}, subscription: ${_this.subscription}, band: ${_this.band}, paidUntil: ${_this.paidUntil}, trialEndsAt: ${_this.trialEndsAt})';
}


}

/// @nodoc
abstract mixin class $TenantDetailSummaryCopyWith<$Res>  {
  factory $TenantDetailSummaryCopyWith(TenantDetailSummary value, $Res Function(TenantDetailSummary) _then) = _$TenantDetailSummaryCopyWithImpl;
@useResult
$Res call({
 String orgId, String name, String slug, String timezone, String currency, DateTime createdAt, DateTime? suspendedAt, String? suspendedReason, bool billingSuspended, int activeSpaces, int memberCount, int upcomingBookings, int bookingsLast30, int revenueLast30Cents, TenantSubscription subscription, TenantBand band, DateTime? paidUntil, DateTime? trialEndsAt
});


$TenantSubscriptionCopyWith<$Res> get subscription;$TenantBandCopyWith<$Res> get band;

}
/// @nodoc
class _$TenantDetailSummaryCopyWithImpl<$Res>
    implements $TenantDetailSummaryCopyWith<$Res> {
  _$TenantDetailSummaryCopyWithImpl(this._self, this._then);

  final TenantDetailSummary _self;
  final $Res Function(TenantDetailSummary) _then;

/// Create a copy of TenantDetailSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orgId = null,Object? name = null,Object? slug = null,Object? timezone = null,Object? currency = null,Object? createdAt = null,Object? suspendedAt = freezed,Object? suspendedReason = freezed,Object? billingSuspended = null,Object? activeSpaces = null,Object? memberCount = null,Object? upcomingBookings = null,Object? bookingsLast30 = null,Object? revenueLast30Cents = null,Object? subscription = null,Object? band = null,Object? paidUntil = freezed,Object? trialEndsAt = freezed,}) {
  return _then(TenantDetailSummary(
orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,suspendedAt: freezed == suspendedAt ? _self.suspendedAt : suspendedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,suspendedReason: freezed == suspendedReason ? _self.suspendedReason : suspendedReason // ignore: cast_nullable_to_non_nullable
as String?,billingSuspended: null == billingSuspended ? _self.billingSuspended : billingSuspended // ignore: cast_nullable_to_non_nullable
as bool,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,upcomingBookings: null == upcomingBookings ? _self.upcomingBookings : upcomingBookings // ignore: cast_nullable_to_non_nullable
as int,bookingsLast30: null == bookingsLast30 ? _self.bookingsLast30 : bookingsLast30 // ignore: cast_nullable_to_non_nullable
as int,revenueLast30Cents: null == revenueLast30Cents ? _self.revenueLast30Cents : revenueLast30Cents // ignore: cast_nullable_to_non_nullable
as int,subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as TenantSubscription,band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as TenantBand,paidUntil: freezed == paidUntil ? _self.paidUntil : paidUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,trialEndsAt: freezed == trialEndsAt ? _self.trialEndsAt : trialEndsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of TenantDetailSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantSubscriptionCopyWith<$Res> get subscription {
  
  return $TenantSubscriptionCopyWith<$Res>(_self.subscription, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of TenantDetailSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantBandCopyWith<$Res> get band {
  
  return $TenantBandCopyWith<$Res>(_self.band, (value) {
    return _then(_self.copyWith(band: value));
  });
}
}


/// Adds pattern-matching-related methods to [TenantDetailSummary].
extension TenantDetailSummaryPatterns on TenantDetailSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantDetailSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantDetailSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantDetailSummary value)  $default,){
final _that = this;
switch (_that) {
case _TenantDetailSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantDetailSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TenantDetailSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orgId,  String name,  String slug,  String timezone,  String currency,  DateTime createdAt,  DateTime? suspendedAt,  String? suspendedReason,  bool billingSuspended,  int activeSpaces,  int memberCount,  int upcomingBookings,  int bookingsLast30,  int revenueLast30Cents,  TenantSubscription subscription,  TenantBand band,  DateTime? paidUntil,  DateTime? trialEndsAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantDetailSummary() when $default != null:
return $default(_that.orgId,_that.name,_that.slug,_that.timezone,_that.currency,_that.createdAt,_that.suspendedAt,_that.suspendedReason,_that.billingSuspended,_that.activeSpaces,_that.memberCount,_that.upcomingBookings,_that.bookingsLast30,_that.revenueLast30Cents,_that.subscription,_that.band,_that.paidUntil,_that.trialEndsAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orgId,  String name,  String slug,  String timezone,  String currency,  DateTime createdAt,  DateTime? suspendedAt,  String? suspendedReason,  bool billingSuspended,  int activeSpaces,  int memberCount,  int upcomingBookings,  int bookingsLast30,  int revenueLast30Cents,  TenantSubscription subscription,  TenantBand band,  DateTime? paidUntil,  DateTime? trialEndsAt)  $default,) {final _that = this;
switch (_that) {
case _TenantDetailSummary():
return $default(_that.orgId,_that.name,_that.slug,_that.timezone,_that.currency,_that.createdAt,_that.suspendedAt,_that.suspendedReason,_that.billingSuspended,_that.activeSpaces,_that.memberCount,_that.upcomingBookings,_that.bookingsLast30,_that.revenueLast30Cents,_that.subscription,_that.band,_that.paidUntil,_that.trialEndsAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orgId,  String name,  String slug,  String timezone,  String currency,  DateTime createdAt,  DateTime? suspendedAt,  String? suspendedReason,  bool billingSuspended,  int activeSpaces,  int memberCount,  int upcomingBookings,  int bookingsLast30,  int revenueLast30Cents,  TenantSubscription subscription,  TenantBand band,  DateTime? paidUntil,  DateTime? trialEndsAt)?  $default,) {final _that = this;
switch (_that) {
case _TenantDetailSummary() when $default != null:
return $default(_that.orgId,_that.name,_that.slug,_that.timezone,_that.currency,_that.createdAt,_that.suspendedAt,_that.suspendedReason,_that.billingSuspended,_that.activeSpaces,_that.memberCount,_that.upcomingBookings,_that.bookingsLast30,_that.revenueLast30Cents,_that.subscription,_that.band,_that.paidUntil,_that.trialEndsAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantDetailSummary extends TenantDetailSummary {
  const _TenantDetailSummary({required this.orgId, required this.name, required this.slug, this.timezone = 'Asia/Manila', this.currency = 'PHP', required this.createdAt, this.suspendedAt, this.suspendedReason, this.billingSuspended = false, this.activeSpaces = 0, this.memberCount = 0, this.upcomingBookings = 0, this.bookingsLast30 = 0, this.revenueLast30Cents = 0, required this.subscription, required this.band, this.paidUntil, this.trialEndsAt}): super._();
  factory _TenantDetailSummary.fromJson(Map<String, dynamic> json) => _$TenantDetailSummaryFromJson(json);

@override final  String orgId;
@override final  String name;
@override final  String slug;
@override@JsonKey() final  String timezone;
@override@JsonKey() final  String currency;
@override final  DateTime createdAt;
@override final  DateTime? suspendedAt;
@override final  String? suspendedReason;
@override@JsonKey() final  bool billingSuspended;
@override@JsonKey() final  int activeSpaces;
@override@JsonKey() final  int memberCount;
@override@JsonKey() final  int upcomingBookings;
@override@JsonKey() final  int bookingsLast30;
@override@JsonKey() final  int revenueLast30Cents;
@override final  TenantSubscription subscription;
@override final  TenantBand band;
@override final  DateTime? paidUntil;
@override final  DateTime? trialEndsAt;

/// Create a copy of TenantDetailSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantDetailSummaryCopyWith<_TenantDetailSummary> get copyWith => __$TenantDetailSummaryCopyWithImpl<_TenantDetailSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantDetailSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantDetailSummary&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.suspendedAt, suspendedAt) || other.suspendedAt == suspendedAt)&&(identical(other.suspendedReason, suspendedReason) || other.suspendedReason == suspendedReason)&&(identical(other.billingSuspended, billingSuspended) || other.billingSuspended == billingSuspended)&&(identical(other.activeSpaces, activeSpaces) || other.activeSpaces == activeSpaces)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.upcomingBookings, upcomingBookings) || other.upcomingBookings == upcomingBookings)&&(identical(other.bookingsLast30, bookingsLast30) || other.bookingsLast30 == bookingsLast30)&&(identical(other.revenueLast30Cents, revenueLast30Cents) || other.revenueLast30Cents == revenueLast30Cents)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&(identical(other.band, band) || other.band == band)&&(identical(other.paidUntil, paidUntil) || other.paidUntil == paidUntil)&&(identical(other.trialEndsAt, trialEndsAt) || other.trialEndsAt == trialEndsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,orgId,name,slug,timezone,currency,createdAt,suspendedAt,suspendedReason,billingSuspended,activeSpaces,memberCount,upcomingBookings,bookingsLast30,revenueLast30Cents,subscription,band,paidUntil,trialEndsAt);
}

@override
String toString() {
    return 'TenantDetailSummary(orgId: $orgId, name: $name, slug: $slug, timezone: $timezone, currency: $currency, createdAt: $createdAt, suspendedAt: $suspendedAt, suspendedReason: $suspendedReason, billingSuspended: $billingSuspended, activeSpaces: $activeSpaces, memberCount: $memberCount, upcomingBookings: $upcomingBookings, bookingsLast30: $bookingsLast30, revenueLast30Cents: $revenueLast30Cents, subscription: $subscription, band: $band, paidUntil: $paidUntil, trialEndsAt: $trialEndsAt)';
}


}

/// @nodoc
abstract mixin class _$TenantDetailSummaryCopyWith<$Res> implements $TenantDetailSummaryCopyWith<$Res> {
  factory _$TenantDetailSummaryCopyWith(_TenantDetailSummary value, $Res Function(_TenantDetailSummary) _then) = __$TenantDetailSummaryCopyWithImpl;
@override @useResult
$Res call({
 String orgId, String name, String slug, String timezone, String currency, DateTime createdAt, DateTime? suspendedAt, String? suspendedReason, bool billingSuspended, int activeSpaces, int memberCount, int upcomingBookings, int bookingsLast30, int revenueLast30Cents, TenantSubscription subscription, TenantBand band, DateTime? paidUntil, DateTime? trialEndsAt
});


@override $TenantSubscriptionCopyWith<$Res> get subscription;@override $TenantBandCopyWith<$Res> get band;

}
/// @nodoc
class __$TenantDetailSummaryCopyWithImpl<$Res>
    implements _$TenantDetailSummaryCopyWith<$Res> {
  __$TenantDetailSummaryCopyWithImpl(this._self, this._then);

  final _TenantDetailSummary _self;
  final $Res Function(_TenantDetailSummary) _then;

/// Create a copy of TenantDetailSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orgId = null,Object? name = null,Object? slug = null,Object? timezone = null,Object? currency = null,Object? createdAt = null,Object? suspendedAt = freezed,Object? suspendedReason = freezed,Object? billingSuspended = null,Object? activeSpaces = null,Object? memberCount = null,Object? upcomingBookings = null,Object? bookingsLast30 = null,Object? revenueLast30Cents = null,Object? subscription = null,Object? band = null,Object? paidUntil = freezed,Object? trialEndsAt = freezed,}) {
  return _then(_TenantDetailSummary(
orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,suspendedAt: freezed == suspendedAt ? _self.suspendedAt : suspendedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,suspendedReason: freezed == suspendedReason ? _self.suspendedReason : suspendedReason // ignore: cast_nullable_to_non_nullable
as String?,billingSuspended: null == billingSuspended ? _self.billingSuspended : billingSuspended // ignore: cast_nullable_to_non_nullable
as bool,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,upcomingBookings: null == upcomingBookings ? _self.upcomingBookings : upcomingBookings // ignore: cast_nullable_to_non_nullable
as int,bookingsLast30: null == bookingsLast30 ? _self.bookingsLast30 : bookingsLast30 // ignore: cast_nullable_to_non_nullable
as int,revenueLast30Cents: null == revenueLast30Cents ? _self.revenueLast30Cents : revenueLast30Cents // ignore: cast_nullable_to_non_nullable
as int,subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as TenantSubscription,band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as TenantBand,paidUntil: freezed == paidUntil ? _self.paidUntil : paidUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,trialEndsAt: freezed == trialEndsAt ? _self.trialEndsAt : trialEndsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of TenantDetailSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantSubscriptionCopyWith<$Res> get subscription {
  
  return $TenantSubscriptionCopyWith<$Res>(_self.subscription, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of TenantDetailSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantBandCopyWith<$Res> get band {
  
  return $TenantBandCopyWith<$Res>(_self.band, (value) {
    return _then(_self.copyWith(band: value));
  });
}
}


/// @nodoc
mixin _$TenantSpace {

 String get id; String get name; String get kind; int get priceCents; bool get active;
/// Create a copy of TenantSpace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantSpaceCopyWith<TenantSpace> get copyWith => _$TenantSpaceCopyWithImpl<TenantSpace>(this as TenantSpace, _$identity);

  /// Serializes this TenantSpace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantSpace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantSpace&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.priceCents, _this.priceCents) || other.priceCents == _this.priceCents)&&(identical(other.active, _this.active) || other.active == _this.active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantSpace;
  return Object.hash(runtimeType,_this.id,_this.name,_this.kind,_this.priceCents,_this.active);
}

@override
String toString() {
  final _this = this as TenantSpace;
  return 'TenantSpace(id: ${_this.id}, name: ${_this.name}, kind: ${_this.kind}, priceCents: ${_this.priceCents}, active: ${_this.active})';
}


}

/// @nodoc
abstract mixin class $TenantSpaceCopyWith<$Res>  {
  factory $TenantSpaceCopyWith(TenantSpace value, $Res Function(TenantSpace) _then) = _$TenantSpaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String kind, int priceCents, bool active
});




}
/// @nodoc
class _$TenantSpaceCopyWithImpl<$Res>
    implements $TenantSpaceCopyWith<$Res> {
  _$TenantSpaceCopyWithImpl(this._self, this._then);

  final TenantSpace _self;
  final $Res Function(TenantSpace) _then;

/// Create a copy of TenantSpace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? priceCents = null,Object? active = null,}) {
  return _then(TenantSpace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantSpace].
extension TenantSpacePatterns on TenantSpace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantSpace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantSpace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantSpace value)  $default,){
final _that = this;
switch (_that) {
case _TenantSpace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantSpace value)?  $default,){
final _that = this;
switch (_that) {
case _TenantSpace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String kind,  int priceCents,  bool active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantSpace() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.priceCents,_that.active);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String kind,  int priceCents,  bool active)  $default,) {final _that = this;
switch (_that) {
case _TenantSpace():
return $default(_that.id,_that.name,_that.kind,_that.priceCents,_that.active);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String kind,  int priceCents,  bool active)?  $default,) {final _that = this;
switch (_that) {
case _TenantSpace() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.priceCents,_that.active);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantSpace implements TenantSpace {
  const _TenantSpace({required this.id, required this.name, this.kind = 'other', this.priceCents = 0, this.active = true});
  factory _TenantSpace.fromJson(Map<String, dynamic> json) => _$TenantSpaceFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String kind;
@override@JsonKey() final  int priceCents;
@override@JsonKey() final  bool active;

/// Create a copy of TenantSpace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantSpaceCopyWith<_TenantSpace> get copyWith => __$TenantSpaceCopyWithImpl<_TenantSpace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantSpaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantSpace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,kind,priceCents,active);
}

@override
String toString() {
    return 'TenantSpace(id: $id, name: $name, kind: $kind, priceCents: $priceCents, active: $active)';
}


}

/// @nodoc
abstract mixin class _$TenantSpaceCopyWith<$Res> implements $TenantSpaceCopyWith<$Res> {
  factory _$TenantSpaceCopyWith(_TenantSpace value, $Res Function(_TenantSpace) _then) = __$TenantSpaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String kind, int priceCents, bool active
});




}
/// @nodoc
class __$TenantSpaceCopyWithImpl<$Res>
    implements _$TenantSpaceCopyWith<$Res> {
  __$TenantSpaceCopyWithImpl(this._self, this._then);

  final _TenantSpace _self;
  final $Res Function(_TenantSpace) _then;

/// Create a copy of TenantSpace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? priceCents = null,Object? active = null,}) {
  return _then(_TenantSpace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TenantMember {

 String? get name; String get email; String get role; DateTime get joinedAt;
/// Create a copy of TenantMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantMemberCopyWith<TenantMember> get copyWith => _$TenantMemberCopyWithImpl<TenantMember>(this as TenantMember, _$identity);

  /// Serializes this TenantMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantMember;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantMember&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.joinedAt, _this.joinedAt) || other.joinedAt == _this.joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantMember;
  return Object.hash(runtimeType,_this.name,_this.email,_this.role,_this.joinedAt);
}

@override
String toString() {
  final _this = this as TenantMember;
  return 'TenantMember(name: ${_this.name}, email: ${_this.email}, role: ${_this.role}, joinedAt: ${_this.joinedAt})';
}


}

/// @nodoc
abstract mixin class $TenantMemberCopyWith<$Res>  {
  factory $TenantMemberCopyWith(TenantMember value, $Res Function(TenantMember) _then) = _$TenantMemberCopyWithImpl;
@useResult
$Res call({
 String? name, String email, String role, DateTime joinedAt
});




}
/// @nodoc
class _$TenantMemberCopyWithImpl<$Res>
    implements $TenantMemberCopyWith<$Res> {
  _$TenantMemberCopyWithImpl(this._self, this._then);

  final TenantMember _self;
  final $Res Function(TenantMember) _then;

/// Create a copy of TenantMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? email = null,Object? role = null,Object? joinedAt = null,}) {
  return _then(TenantMember(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantMember].
extension TenantMemberPatterns on TenantMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantMember value)  $default,){
final _that = this;
switch (_that) {
case _TenantMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantMember value)?  $default,){
final _that = this;
switch (_that) {
case _TenantMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String email,  String role,  DateTime joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantMember() when $default != null:
return $default(_that.name,_that.email,_that.role,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String email,  String role,  DateTime joinedAt)  $default,) {final _that = this;
switch (_that) {
case _TenantMember():
return $default(_that.name,_that.email,_that.role,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String email,  String role,  DateTime joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _TenantMember() when $default != null:
return $default(_that.name,_that.email,_that.role,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantMember implements TenantMember {
  const _TenantMember({this.name, required this.email, required this.role, required this.joinedAt});
  factory _TenantMember.fromJson(Map<String, dynamic> json) => _$TenantMemberFromJson(json);

@override final  String? name;
@override final  String email;
@override final  String role;
@override final  DateTime joinedAt;

/// Create a copy of TenantMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantMemberCopyWith<_TenantMember> get copyWith => __$TenantMemberCopyWithImpl<_TenantMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantMemberToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantMember&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,email,role,joinedAt);
}

@override
String toString() {
    return 'TenantMember(name: $name, email: $email, role: $role, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$TenantMemberCopyWith<$Res> implements $TenantMemberCopyWith<$Res> {
  factory _$TenantMemberCopyWith(_TenantMember value, $Res Function(_TenantMember) _then) = __$TenantMemberCopyWithImpl;
@override @useResult
$Res call({
 String? name, String email, String role, DateTime joinedAt
});




}
/// @nodoc
class __$TenantMemberCopyWithImpl<$Res>
    implements _$TenantMemberCopyWith<$Res> {
  __$TenantMemberCopyWithImpl(this._self, this._then);

  final _TenantMember _self;
  final $Res Function(_TenantMember) _then;

/// Create a copy of TenantMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? email = null,Object? role = null,Object? joinedAt = null,}) {
  return _then(_TenantMember(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$TenantBooking {

 String get reference; String get status; String get spaceName; String? get customerName;/// Venue-local "DD Mon HH:MM", formatted by the server.
 String get label; int get amountCents;
/// Create a copy of TenantBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantBookingCopyWith<TenantBooking> get copyWith => _$TenantBookingCopyWithImpl<TenantBooking>(this as TenantBooking, _$identity);

  /// Serializes this TenantBooking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantBooking;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantBooking&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.spaceName, _this.spaceName) || other.spaceName == _this.spaceName)&&(identical(other.customerName, _this.customerName) || other.customerName == _this.customerName)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantBooking;
  return Object.hash(runtimeType,_this.reference,_this.status,_this.spaceName,_this.customerName,_this.label,_this.amountCents);
}

@override
String toString() {
  final _this = this as TenantBooking;
  return 'TenantBooking(reference: ${_this.reference}, status: ${_this.status}, spaceName: ${_this.spaceName}, customerName: ${_this.customerName}, label: ${_this.label}, amountCents: ${_this.amountCents})';
}


}

/// @nodoc
abstract mixin class $TenantBookingCopyWith<$Res>  {
  factory $TenantBookingCopyWith(TenantBooking value, $Res Function(TenantBooking) _then) = _$TenantBookingCopyWithImpl;
@useResult
$Res call({
 String reference, String status, String spaceName, String? customerName, String label, int amountCents
});




}
/// @nodoc
class _$TenantBookingCopyWithImpl<$Res>
    implements $TenantBookingCopyWith<$Res> {
  _$TenantBookingCopyWithImpl(this._self, this._then);

  final TenantBooking _self;
  final $Res Function(TenantBooking) _then;

/// Create a copy of TenantBooking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reference = null,Object? status = null,Object? spaceName = null,Object? customerName = freezed,Object? label = null,Object? amountCents = null,}) {
  return _then(TenantBooking(
reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,spaceName: null == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantBooking].
extension TenantBookingPatterns on TenantBooking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantBooking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantBooking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantBooking value)  $default,){
final _that = this;
switch (_that) {
case _TenantBooking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantBooking value)?  $default,){
final _that = this;
switch (_that) {
case _TenantBooking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reference,  String status,  String spaceName,  String? customerName,  String label,  int amountCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantBooking() when $default != null:
return $default(_that.reference,_that.status,_that.spaceName,_that.customerName,_that.label,_that.amountCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reference,  String status,  String spaceName,  String? customerName,  String label,  int amountCents)  $default,) {final _that = this;
switch (_that) {
case _TenantBooking():
return $default(_that.reference,_that.status,_that.spaceName,_that.customerName,_that.label,_that.amountCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reference,  String status,  String spaceName,  String? customerName,  String label,  int amountCents)?  $default,) {final _that = this;
switch (_that) {
case _TenantBooking() when $default != null:
return $default(_that.reference,_that.status,_that.spaceName,_that.customerName,_that.label,_that.amountCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantBooking implements TenantBooking {
  const _TenantBooking({required this.reference, required this.status, required this.spaceName, this.customerName, required this.label, this.amountCents = 0});
  factory _TenantBooking.fromJson(Map<String, dynamic> json) => _$TenantBookingFromJson(json);

@override final  String reference;
@override final  String status;
@override final  String spaceName;
@override final  String? customerName;
/// Venue-local "DD Mon HH:MM", formatted by the server.
@override final  String label;
@override@JsonKey() final  int amountCents;

/// Create a copy of TenantBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantBookingCopyWith<_TenantBooking> get copyWith => __$TenantBookingCopyWithImpl<_TenantBooking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantBookingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantBooking&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.status, status) || other.status == status)&&(identical(other.spaceName, spaceName) || other.spaceName == spaceName)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.label, label) || other.label == label)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,reference,status,spaceName,customerName,label,amountCents);
}

@override
String toString() {
    return 'TenantBooking(reference: $reference, status: $status, spaceName: $spaceName, customerName: $customerName, label: $label, amountCents: $amountCents)';
}


}

/// @nodoc
abstract mixin class _$TenantBookingCopyWith<$Res> implements $TenantBookingCopyWith<$Res> {
  factory _$TenantBookingCopyWith(_TenantBooking value, $Res Function(_TenantBooking) _then) = __$TenantBookingCopyWithImpl;
@override @useResult
$Res call({
 String reference, String status, String spaceName, String? customerName, String label, int amountCents
});




}
/// @nodoc
class __$TenantBookingCopyWithImpl<$Res>
    implements _$TenantBookingCopyWith<$Res> {
  __$TenantBookingCopyWithImpl(this._self, this._then);

  final _TenantBooking _self;
  final $Res Function(_TenantBooking) _then;

/// Create a copy of TenantBooking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reference = null,Object? status = null,Object? spaceName = null,Object? customerName = freezed,Object? label = null,Object? amountCents = null,}) {
  return _then(_TenantBooking(
reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,spaceName: null == spaceName ? _self.spaceName : spaceName // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AdminPayment {

 String get id; String? get orgId; String? get venueName; int get amountCents; String get reference;/// The date the owner says they transferred.
 DateTime get paidAt; String get status; String? get note; String? get receiptUrl; DateTime get createdAt;
/// Create a copy of AdminPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminPaymentCopyWith<AdminPayment> get copyWith => _$AdminPaymentCopyWithImpl<AdminPayment>(this as AdminPayment, _$identity);

  /// Serializes this AdminPayment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AdminPayment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminPayment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.orgId, _this.orgId) || other.orgId == _this.orgId)&&(identical(other.venueName, _this.venueName) || other.venueName == _this.venueName)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.paidAt, _this.paidAt) || other.paidAt == _this.paidAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.receiptUrl, _this.receiptUrl) || other.receiptUrl == _this.receiptUrl)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AdminPayment;
  return Object.hash(runtimeType,_this.id,_this.orgId,_this.venueName,_this.amountCents,_this.reference,_this.paidAt,_this.status,_this.note,_this.receiptUrl,_this.createdAt);
}

@override
String toString() {
  final _this = this as AdminPayment;
  return 'AdminPayment(id: ${_this.id}, orgId: ${_this.orgId}, venueName: ${_this.venueName}, amountCents: ${_this.amountCents}, reference: ${_this.reference}, paidAt: ${_this.paidAt}, status: ${_this.status}, note: ${_this.note}, receiptUrl: ${_this.receiptUrl}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $AdminPaymentCopyWith<$Res>  {
  factory $AdminPaymentCopyWith(AdminPayment value, $Res Function(AdminPayment) _then) = _$AdminPaymentCopyWithImpl;
@useResult
$Res call({
 String id, String? orgId, String? venueName, int amountCents, String reference, DateTime paidAt, String status, String? note, String? receiptUrl, DateTime createdAt
});




}
/// @nodoc
class _$AdminPaymentCopyWithImpl<$Res>
    implements $AdminPaymentCopyWith<$Res> {
  _$AdminPaymentCopyWithImpl(this._self, this._then);

  final AdminPayment _self;
  final $Res Function(AdminPayment) _then;

/// Create a copy of AdminPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orgId = freezed,Object? venueName = freezed,Object? amountCents = null,Object? reference = null,Object? paidAt = null,Object? status = null,Object? note = freezed,Object? receiptUrl = freezed,Object? createdAt = null,}) {
  return _then(AdminPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orgId: freezed == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String?,venueName: freezed == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String?,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminPayment].
extension AdminPaymentPatterns on AdminPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminPayment value)  $default,){
final _that = this;
switch (_that) {
case _AdminPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminPayment value)?  $default,){
final _that = this;
switch (_that) {
case _AdminPayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? orgId,  String? venueName,  int amountCents,  String reference,  DateTime paidAt,  String status,  String? note,  String? receiptUrl,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminPayment() when $default != null:
return $default(_that.id,_that.orgId,_that.venueName,_that.amountCents,_that.reference,_that.paidAt,_that.status,_that.note,_that.receiptUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? orgId,  String? venueName,  int amountCents,  String reference,  DateTime paidAt,  String status,  String? note,  String? receiptUrl,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AdminPayment():
return $default(_that.id,_that.orgId,_that.venueName,_that.amountCents,_that.reference,_that.paidAt,_that.status,_that.note,_that.receiptUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? orgId,  String? venueName,  int amountCents,  String reference,  DateTime paidAt,  String status,  String? note,  String? receiptUrl,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AdminPayment() when $default != null:
return $default(_that.id,_that.orgId,_that.venueName,_that.amountCents,_that.reference,_that.paidAt,_that.status,_that.note,_that.receiptUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminPayment implements AdminPayment {
  const _AdminPayment({required this.id, this.orgId, this.venueName, this.amountCents = 0, required this.reference, required this.paidAt, this.status = 'submitted', this.note, this.receiptUrl, required this.createdAt});
  factory _AdminPayment.fromJson(Map<String, dynamic> json) => _$AdminPaymentFromJson(json);

@override final  String id;
@override final  String? orgId;
@override final  String? venueName;
@override@JsonKey() final  int amountCents;
@override final  String reference;
/// The date the owner says they transferred.
@override final  DateTime paidAt;
@override@JsonKey() final  String status;
@override final  String? note;
@override final  String? receiptUrl;
@override final  DateTime createdAt;

/// Create a copy of AdminPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminPaymentCopyWith<_AdminPayment> get copyWith => __$AdminPaymentCopyWithImpl<_AdminPayment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminPaymentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,orgId,venueName,amountCents,reference,paidAt,status,note,receiptUrl,createdAt);
}

@override
String toString() {
    return 'AdminPayment(id: $id, orgId: $orgId, venueName: $venueName, amountCents: $amountCents, reference: $reference, paidAt: $paidAt, status: $status, note: $note, receiptUrl: $receiptUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AdminPaymentCopyWith<$Res> implements $AdminPaymentCopyWith<$Res> {
  factory _$AdminPaymentCopyWith(_AdminPayment value, $Res Function(_AdminPayment) _then) = __$AdminPaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String? orgId, String? venueName, int amountCents, String reference, DateTime paidAt, String status, String? note, String? receiptUrl, DateTime createdAt
});




}
/// @nodoc
class __$AdminPaymentCopyWithImpl<$Res>
    implements _$AdminPaymentCopyWith<$Res> {
  __$AdminPaymentCopyWithImpl(this._self, this._then);

  final _AdminPayment _self;
  final $Res Function(_AdminPayment) _then;

/// Create a copy of AdminPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orgId = freezed,Object? venueName = freezed,Object? amountCents = null,Object? reference = null,Object? paidAt = null,Object? status = null,Object? note = freezed,Object? receiptUrl = freezed,Object? createdAt = null,}) {
  return _then(_AdminPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orgId: freezed == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String?,venueName: freezed == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String?,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$InstapaySettings {

 String? get qrUrl; String? get payee; String? get account; bool get configured;
/// Create a copy of InstapaySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstapaySettingsCopyWith<InstapaySettings> get copyWith => _$InstapaySettingsCopyWithImpl<InstapaySettings>(this as InstapaySettings, _$identity);

  /// Serializes this InstapaySettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InstapaySettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstapaySettings&&(identical(other.qrUrl, _this.qrUrl) || other.qrUrl == _this.qrUrl)&&(identical(other.payee, _this.payee) || other.payee == _this.payee)&&(identical(other.account, _this.account) || other.account == _this.account)&&(identical(other.configured, _this.configured) || other.configured == _this.configured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InstapaySettings;
  return Object.hash(runtimeType,_this.qrUrl,_this.payee,_this.account,_this.configured);
}

@override
String toString() {
  final _this = this as InstapaySettings;
  return 'InstapaySettings(qrUrl: ${_this.qrUrl}, payee: ${_this.payee}, account: ${_this.account}, configured: ${_this.configured})';
}


}

/// @nodoc
abstract mixin class $InstapaySettingsCopyWith<$Res>  {
  factory $InstapaySettingsCopyWith(InstapaySettings value, $Res Function(InstapaySettings) _then) = _$InstapaySettingsCopyWithImpl;
@useResult
$Res call({
 String? qrUrl, String? payee, String? account, bool configured
});




}
/// @nodoc
class _$InstapaySettingsCopyWithImpl<$Res>
    implements $InstapaySettingsCopyWith<$Res> {
  _$InstapaySettingsCopyWithImpl(this._self, this._then);

  final InstapaySettings _self;
  final $Res Function(InstapaySettings) _then;

/// Create a copy of InstapaySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? qrUrl = freezed,Object? payee = freezed,Object? account = freezed,Object? configured = null,}) {
  return _then(InstapaySettings(
qrUrl: freezed == qrUrl ? _self.qrUrl : qrUrl // ignore: cast_nullable_to_non_nullable
as String?,payee: freezed == payee ? _self.payee : payee // ignore: cast_nullable_to_non_nullable
as String?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String?,configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InstapaySettings].
extension InstapaySettingsPatterns on InstapaySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstapaySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstapaySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstapaySettings value)  $default,){
final _that = this;
switch (_that) {
case _InstapaySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstapaySettings value)?  $default,){
final _that = this;
switch (_that) {
case _InstapaySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? qrUrl,  String? payee,  String? account,  bool configured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstapaySettings() when $default != null:
return $default(_that.qrUrl,_that.payee,_that.account,_that.configured);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? qrUrl,  String? payee,  String? account,  bool configured)  $default,) {final _that = this;
switch (_that) {
case _InstapaySettings():
return $default(_that.qrUrl,_that.payee,_that.account,_that.configured);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? qrUrl,  String? payee,  String? account,  bool configured)?  $default,) {final _that = this;
switch (_that) {
case _InstapaySettings() when $default != null:
return $default(_that.qrUrl,_that.payee,_that.account,_that.configured);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InstapaySettings implements InstapaySettings {
  const _InstapaySettings({this.qrUrl, this.payee, this.account, this.configured = false});
  factory _InstapaySettings.fromJson(Map<String, dynamic> json) => _$InstapaySettingsFromJson(json);

@override final  String? qrUrl;
@override final  String? payee;
@override final  String? account;
@override@JsonKey() final  bool configured;

/// Create a copy of InstapaySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstapaySettingsCopyWith<_InstapaySettings> get copyWith => __$InstapaySettingsCopyWithImpl<_InstapaySettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InstapaySettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstapaySettings&&(identical(other.qrUrl, qrUrl) || other.qrUrl == qrUrl)&&(identical(other.payee, payee) || other.payee == payee)&&(identical(other.account, account) || other.account == account)&&(identical(other.configured, configured) || other.configured == configured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,qrUrl,payee,account,configured);
}

@override
String toString() {
    return 'InstapaySettings(qrUrl: $qrUrl, payee: $payee, account: $account, configured: $configured)';
}


}

/// @nodoc
abstract mixin class _$InstapaySettingsCopyWith<$Res> implements $InstapaySettingsCopyWith<$Res> {
  factory _$InstapaySettingsCopyWith(_InstapaySettings value, $Res Function(_InstapaySettings) _then) = __$InstapaySettingsCopyWithImpl;
@override @useResult
$Res call({
 String? qrUrl, String? payee, String? account, bool configured
});




}
/// @nodoc
class __$InstapaySettingsCopyWithImpl<$Res>
    implements _$InstapaySettingsCopyWith<$Res> {
  __$InstapaySettingsCopyWithImpl(this._self, this._then);

  final _InstapaySettings _self;
  final $Res Function(_InstapaySettings) _then;

/// Create a copy of InstapaySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? qrUrl = freezed,Object? payee = freezed,Object? account = freezed,Object? configured = null,}) {
  return _then(_InstapaySettings(
qrUrl: freezed == qrUrl ? _self.qrUrl : qrUrl // ignore: cast_nullable_to_non_nullable
as String?,payee: freezed == payee ? _self.payee : payee // ignore: cast_nullable_to_non_nullable
as String?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String?,configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AuditEntry {

 String get id; String get actorName; String get actorEmail; String get action; String? get organizationName; String? get target; bool get impersonating; Map<String, dynamic>? get detail; DateTime get createdAt;
/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditEntryCopyWith<AuditEntry> get copyWith => _$AuditEntryCopyWithImpl<AuditEntry>(this as AuditEntry, _$identity);

  /// Serializes this AuditEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AuditEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.actorName, _this.actorName) || other.actorName == _this.actorName)&&(identical(other.actorEmail, _this.actorEmail) || other.actorEmail == _this.actorEmail)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.organizationName, _this.organizationName) || other.organizationName == _this.organizationName)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.impersonating, _this.impersonating) || other.impersonating == _this.impersonating)&&const DeepCollectionEquality().equals(other.detail, _this.detail)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AuditEntry;
  return Object.hash(runtimeType,_this.id,_this.actorName,_this.actorEmail,_this.action,_this.organizationName,_this.target,_this.impersonating,const DeepCollectionEquality().hash(_this.detail),_this.createdAt);
}

@override
String toString() {
  final _this = this as AuditEntry;
  return 'AuditEntry(id: ${_this.id}, actorName: ${_this.actorName}, actorEmail: ${_this.actorEmail}, action: ${_this.action}, organizationName: ${_this.organizationName}, target: ${_this.target}, impersonating: ${_this.impersonating}, detail: ${_this.detail}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $AuditEntryCopyWith<$Res>  {
  factory $AuditEntryCopyWith(AuditEntry value, $Res Function(AuditEntry) _then) = _$AuditEntryCopyWithImpl;
@useResult
$Res call({
 String id, String actorName, String actorEmail, String action, String? organizationName, String? target, bool impersonating, Map<String, dynamic>? detail, DateTime createdAt
});




}
/// @nodoc
class _$AuditEntryCopyWithImpl<$Res>
    implements $AuditEntryCopyWith<$Res> {
  _$AuditEntryCopyWithImpl(this._self, this._then);

  final AuditEntry _self;
  final $Res Function(AuditEntry) _then;

/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? actorName = null,Object? actorEmail = null,Object? action = null,Object? organizationName = freezed,Object? target = freezed,Object? impersonating = null,Object? detail = freezed,Object? createdAt = null,}) {
  return _then(AuditEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,actorName: null == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String,actorEmail: null == actorEmail ? _self.actorEmail : actorEmail // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,organizationName: freezed == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String?,impersonating: null == impersonating ? _self.impersonating : impersonating // ignore: cast_nullable_to_non_nullable
as bool,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditEntry].
extension AuditEntryPatterns on AuditEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditEntry value)  $default,){
final _that = this;
switch (_that) {
case _AuditEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String actorName,  String actorEmail,  String action,  String? organizationName,  String? target,  bool impersonating,  Map<String, dynamic>? detail,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
return $default(_that.id,_that.actorName,_that.actorEmail,_that.action,_that.organizationName,_that.target,_that.impersonating,_that.detail,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String actorName,  String actorEmail,  String action,  String? organizationName,  String? target,  bool impersonating,  Map<String, dynamic>? detail,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AuditEntry():
return $default(_that.id,_that.actorName,_that.actorEmail,_that.action,_that.organizationName,_that.target,_that.impersonating,_that.detail,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String actorName,  String actorEmail,  String action,  String? organizationName,  String? target,  bool impersonating,  Map<String, dynamic>? detail,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
return $default(_that.id,_that.actorName,_that.actorEmail,_that.action,_that.organizationName,_that.target,_that.impersonating,_that.detail,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditEntry extends AuditEntry {
  const _AuditEntry({required this.id, required this.actorName, required this.actorEmail, required this.action, this.organizationName, this.target, this.impersonating = false,  Map<String, dynamic>? detail, required this.createdAt}): _detail = detail,super._();
  factory _AuditEntry.fromJson(Map<String, dynamic> json) => _$AuditEntryFromJson(json);

@override final  String id;
@override final  String actorName;
@override final  String actorEmail;
@override final  String action;
@override final  String? organizationName;
@override final  String? target;
@override@JsonKey() final  bool impersonating;
 final  Map<String, dynamic>? _detail;
@override Map<String, dynamic>? get detail {
  final value = _detail;
  if (value == null) return null;
  if (_detail is EqualUnmodifiableMapView) return _detail;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime createdAt;

/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditEntryCopyWith<_AuditEntry> get copyWith => __$AuditEntryCopyWithImpl<_AuditEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.actorEmail, actorEmail) || other.actorEmail == actorEmail)&&(identical(other.action, action) || other.action == action)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.target, target) || other.target == target)&&(identical(other.impersonating, impersonating) || other.impersonating == impersonating)&&const DeepCollectionEquality().equals(other.detail, _detail)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,actorName,actorEmail,action,organizationName,target,impersonating,const DeepCollectionEquality().hash(_detail),createdAt);
}

@override
String toString() {
    return 'AuditEntry(id: $id, actorName: $actorName, actorEmail: $actorEmail, action: $action, organizationName: $organizationName, target: $target, impersonating: $impersonating, detail: $detail, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AuditEntryCopyWith<$Res> implements $AuditEntryCopyWith<$Res> {
  factory _$AuditEntryCopyWith(_AuditEntry value, $Res Function(_AuditEntry) _then) = __$AuditEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String actorName, String actorEmail, String action, String? organizationName, String? target, bool impersonating, Map<String, dynamic>? detail, DateTime createdAt
});




}
/// @nodoc
class __$AuditEntryCopyWithImpl<$Res>
    implements _$AuditEntryCopyWith<$Res> {
  __$AuditEntryCopyWithImpl(this._self, this._then);

  final _AuditEntry _self;
  final $Res Function(_AuditEntry) _then;

/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? actorName = null,Object? actorEmail = null,Object? action = null,Object? organizationName = freezed,Object? target = freezed,Object? impersonating = null,Object? detail = freezed,Object? createdAt = null,}) {
  return _then(_AuditEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,actorName: null == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String,actorEmail: null == actorEmail ? _self.actorEmail : actorEmail // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,organizationName: freezed == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String?,impersonating: null == impersonating ? _self.impersonating : impersonating // ignore: cast_nullable_to_non_nullable
as bool,detail: freezed == detail ? _self._detail : detail // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PlatformAdminEntry {

 String get userId; String? get name; String get email; DateTime get grantedAt; bool get isSelf;
/// Create a copy of PlatformAdminEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformAdminEntryCopyWith<PlatformAdminEntry> get copyWith => _$PlatformAdminEntryCopyWithImpl<PlatformAdminEntry>(this as PlatformAdminEntry, _$identity);

  /// Serializes this PlatformAdminEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlatformAdminEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformAdminEntry&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.grantedAt, _this.grantedAt) || other.grantedAt == _this.grantedAt)&&(identical(other.isSelf, _this.isSelf) || other.isSelf == _this.isSelf));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlatformAdminEntry;
  return Object.hash(runtimeType,_this.userId,_this.name,_this.email,_this.grantedAt,_this.isSelf);
}

@override
String toString() {
  final _this = this as PlatformAdminEntry;
  return 'PlatformAdminEntry(userId: ${_this.userId}, name: ${_this.name}, email: ${_this.email}, grantedAt: ${_this.grantedAt}, isSelf: ${_this.isSelf})';
}


}

/// @nodoc
abstract mixin class $PlatformAdminEntryCopyWith<$Res>  {
  factory $PlatformAdminEntryCopyWith(PlatformAdminEntry value, $Res Function(PlatformAdminEntry) _then) = _$PlatformAdminEntryCopyWithImpl;
@useResult
$Res call({
 String userId, String? name, String email, DateTime grantedAt, bool isSelf
});




}
/// @nodoc
class _$PlatformAdminEntryCopyWithImpl<$Res>
    implements $PlatformAdminEntryCopyWith<$Res> {
  _$PlatformAdminEntryCopyWithImpl(this._self, this._then);

  final PlatformAdminEntry _self;
  final $Res Function(PlatformAdminEntry) _then;

/// Create a copy of PlatformAdminEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? name = freezed,Object? email = null,Object? grantedAt = null,Object? isSelf = null,}) {
  return _then(PlatformAdminEntry(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,grantedAt: null == grantedAt ? _self.grantedAt : grantedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSelf: null == isSelf ? _self.isSelf : isSelf // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformAdminEntry].
extension PlatformAdminEntryPatterns on PlatformAdminEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformAdminEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformAdminEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformAdminEntry value)  $default,){
final _that = this;
switch (_that) {
case _PlatformAdminEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformAdminEntry value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformAdminEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String? name,  String email,  DateTime grantedAt,  bool isSelf)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformAdminEntry() when $default != null:
return $default(_that.userId,_that.name,_that.email,_that.grantedAt,_that.isSelf);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String? name,  String email,  DateTime grantedAt,  bool isSelf)  $default,) {final _that = this;
switch (_that) {
case _PlatformAdminEntry():
return $default(_that.userId,_that.name,_that.email,_that.grantedAt,_that.isSelf);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String? name,  String email,  DateTime grantedAt,  bool isSelf)?  $default,) {final _that = this;
switch (_that) {
case _PlatformAdminEntry() when $default != null:
return $default(_that.userId,_that.name,_that.email,_that.grantedAt,_that.isSelf);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformAdminEntry implements PlatformAdminEntry {
  const _PlatformAdminEntry({required this.userId, this.name, required this.email, required this.grantedAt, this.isSelf = false});
  factory _PlatformAdminEntry.fromJson(Map<String, dynamic> json) => _$PlatformAdminEntryFromJson(json);

@override final  String userId;
@override final  String? name;
@override final  String email;
@override final  DateTime grantedAt;
@override@JsonKey() final  bool isSelf;

/// Create a copy of PlatformAdminEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformAdminEntryCopyWith<_PlatformAdminEntry> get copyWith => __$PlatformAdminEntryCopyWithImpl<_PlatformAdminEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformAdminEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformAdminEntry&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.grantedAt, grantedAt) || other.grantedAt == grantedAt)&&(identical(other.isSelf, isSelf) || other.isSelf == isSelf));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,name,email,grantedAt,isSelf);
}

@override
String toString() {
    return 'PlatformAdminEntry(userId: $userId, name: $name, email: $email, grantedAt: $grantedAt, isSelf: $isSelf)';
}


}

/// @nodoc
abstract mixin class _$PlatformAdminEntryCopyWith<$Res> implements $PlatformAdminEntryCopyWith<$Res> {
  factory _$PlatformAdminEntryCopyWith(_PlatformAdminEntry value, $Res Function(_PlatformAdminEntry) _then) = __$PlatformAdminEntryCopyWithImpl;
@override @useResult
$Res call({
 String userId, String? name, String email, DateTime grantedAt, bool isSelf
});




}
/// @nodoc
class __$PlatformAdminEntryCopyWithImpl<$Res>
    implements _$PlatformAdminEntryCopyWith<$Res> {
  __$PlatformAdminEntryCopyWithImpl(this._self, this._then);

  final _PlatformAdminEntry _self;
  final $Res Function(_PlatformAdminEntry) _then;

/// Create a copy of PlatformAdminEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = freezed,Object? email = null,Object? grantedAt = null,Object? isSelf = null,}) {
  return _then(_PlatformAdminEntry(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,grantedAt: null == grantedAt ? _self.grantedAt : grantedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSelf: null == isSelf ? _self.isSelf : isSelf // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
