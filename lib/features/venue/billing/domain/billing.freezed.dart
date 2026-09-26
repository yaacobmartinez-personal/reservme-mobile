// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'billing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Billing {

 BillingStatus get status; PlanBand get band; int get activeSpaces; DateTime get trialEndsAt; DateTime? get paidUntil;/// Whole days until the trial ends, never negative; null once not
/// trialing.
 int? get daysLeftInTrial; bool get dueNow;/// True once billing has switched the public booking page off.
 bool get suspended; BillingPayment? get pendingPayment; List<BillingPayment> get history; InstapayDetails? get instapay;
/// Create a copy of Billing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillingCopyWith<Billing> get copyWith => _$BillingCopyWithImpl<Billing>(this as Billing, _$identity);

  /// Serializes this Billing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Billing;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Billing&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.band, _this.band) || other.band == _this.band)&&(identical(other.activeSpaces, _this.activeSpaces) || other.activeSpaces == _this.activeSpaces)&&(identical(other.trialEndsAt, _this.trialEndsAt) || other.trialEndsAt == _this.trialEndsAt)&&(identical(other.paidUntil, _this.paidUntil) || other.paidUntil == _this.paidUntil)&&(identical(other.daysLeftInTrial, _this.daysLeftInTrial) || other.daysLeftInTrial == _this.daysLeftInTrial)&&(identical(other.dueNow, _this.dueNow) || other.dueNow == _this.dueNow)&&(identical(other.suspended, _this.suspended) || other.suspended == _this.suspended)&&(identical(other.pendingPayment, _this.pendingPayment) || other.pendingPayment == _this.pendingPayment)&&const DeepCollectionEquality().equals(other.history, _this.history)&&(identical(other.instapay, _this.instapay) || other.instapay == _this.instapay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Billing;
  return Object.hash(runtimeType,_this.status,_this.band,_this.activeSpaces,_this.trialEndsAt,_this.paidUntil,_this.daysLeftInTrial,_this.dueNow,_this.suspended,_this.pendingPayment,const DeepCollectionEquality().hash(_this.history),_this.instapay);
}

@override
String toString() {
  final _this = this as Billing;
  return 'Billing(status: ${_this.status}, band: ${_this.band}, activeSpaces: ${_this.activeSpaces}, trialEndsAt: ${_this.trialEndsAt}, paidUntil: ${_this.paidUntil}, daysLeftInTrial: ${_this.daysLeftInTrial}, dueNow: ${_this.dueNow}, suspended: ${_this.suspended}, pendingPayment: ${_this.pendingPayment}, history: ${_this.history}, instapay: ${_this.instapay})';
}


}

/// @nodoc
abstract mixin class $BillingCopyWith<$Res>  {
  factory $BillingCopyWith(Billing value, $Res Function(Billing) _then) = _$BillingCopyWithImpl;
@useResult
$Res call({
 BillingStatus status, PlanBand band, int activeSpaces, DateTime trialEndsAt, DateTime? paidUntil, int? daysLeftInTrial, bool dueNow, bool suspended, BillingPayment? pendingPayment, List<BillingPayment> history, InstapayDetails? instapay
});


$PlanBandCopyWith<$Res> get band;$BillingPaymentCopyWith<$Res>? get pendingPayment;$InstapayDetailsCopyWith<$Res>? get instapay;

}
/// @nodoc
class _$BillingCopyWithImpl<$Res>
    implements $BillingCopyWith<$Res> {
  _$BillingCopyWithImpl(this._self, this._then);

  final Billing _self;
  final $Res Function(Billing) _then;

/// Create a copy of Billing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? band = null,Object? activeSpaces = null,Object? trialEndsAt = null,Object? paidUntil = freezed,Object? daysLeftInTrial = freezed,Object? dueNow = null,Object? suspended = null,Object? pendingPayment = freezed,Object? history = null,Object? instapay = freezed,}) {
  return _then(Billing(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BillingStatus,band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as PlanBand,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,trialEndsAt: null == trialEndsAt ? _self.trialEndsAt : trialEndsAt // ignore: cast_nullable_to_non_nullable
as DateTime,paidUntil: freezed == paidUntil ? _self.paidUntil : paidUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,daysLeftInTrial: freezed == daysLeftInTrial ? _self.daysLeftInTrial : daysLeftInTrial // ignore: cast_nullable_to_non_nullable
as int?,dueNow: null == dueNow ? _self.dueNow : dueNow // ignore: cast_nullable_to_non_nullable
as bool,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,pendingPayment: freezed == pendingPayment ? _self.pendingPayment : pendingPayment // ignore: cast_nullable_to_non_nullable
as BillingPayment?,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<BillingPayment>,instapay: freezed == instapay ? _self.instapay : instapay // ignore: cast_nullable_to_non_nullable
as InstapayDetails?,
  ));
}
/// Create a copy of Billing
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanBandCopyWith<$Res> get band {
  
  return $PlanBandCopyWith<$Res>(_self.band, (value) {
    return _then(_self.copyWith(band: value));
  });
}/// Create a copy of Billing
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BillingPaymentCopyWith<$Res>? get pendingPayment {
    if (_self.pendingPayment == null) {
    return null;
  }

  return $BillingPaymentCopyWith<$Res>(_self.pendingPayment!, (value) {
    return _then(_self.copyWith(pendingPayment: value));
  });
}/// Create a copy of Billing
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InstapayDetailsCopyWith<$Res>? get instapay {
    if (_self.instapay == null) {
    return null;
  }

  return $InstapayDetailsCopyWith<$Res>(_self.instapay!, (value) {
    return _then(_self.copyWith(instapay: value));
  });
}
}


/// Adds pattern-matching-related methods to [Billing].
extension BillingPatterns on Billing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Billing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Billing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Billing value)  $default,){
final _that = this;
switch (_that) {
case _Billing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Billing value)?  $default,){
final _that = this;
switch (_that) {
case _Billing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BillingStatus status,  PlanBand band,  int activeSpaces,  DateTime trialEndsAt,  DateTime? paidUntil,  int? daysLeftInTrial,  bool dueNow,  bool suspended,  BillingPayment? pendingPayment,  List<BillingPayment> history,  InstapayDetails? instapay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Billing() when $default != null:
return $default(_that.status,_that.band,_that.activeSpaces,_that.trialEndsAt,_that.paidUntil,_that.daysLeftInTrial,_that.dueNow,_that.suspended,_that.pendingPayment,_that.history,_that.instapay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BillingStatus status,  PlanBand band,  int activeSpaces,  DateTime trialEndsAt,  DateTime? paidUntil,  int? daysLeftInTrial,  bool dueNow,  bool suspended,  BillingPayment? pendingPayment,  List<BillingPayment> history,  InstapayDetails? instapay)  $default,) {final _that = this;
switch (_that) {
case _Billing():
return $default(_that.status,_that.band,_that.activeSpaces,_that.trialEndsAt,_that.paidUntil,_that.daysLeftInTrial,_that.dueNow,_that.suspended,_that.pendingPayment,_that.history,_that.instapay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BillingStatus status,  PlanBand band,  int activeSpaces,  DateTime trialEndsAt,  DateTime? paidUntil,  int? daysLeftInTrial,  bool dueNow,  bool suspended,  BillingPayment? pendingPayment,  List<BillingPayment> history,  InstapayDetails? instapay)?  $default,) {final _that = this;
switch (_that) {
case _Billing() when $default != null:
return $default(_that.status,_that.band,_that.activeSpaces,_that.trialEndsAt,_that.paidUntil,_that.daysLeftInTrial,_that.dueNow,_that.suspended,_that.pendingPayment,_that.history,_that.instapay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Billing extends Billing {
  const _Billing({this.status = BillingStatus.trialing, required this.band, this.activeSpaces = 0, required this.trialEndsAt, this.paidUntil, this.daysLeftInTrial, this.dueNow = false, this.suspended = false, this.pendingPayment,  List<BillingPayment> history = const <BillingPayment>[], this.instapay}): _history = history,super._();
  factory _Billing.fromJson(Map<String, dynamic> json) => _$BillingFromJson(json);

@override@JsonKey() final  BillingStatus status;
@override final  PlanBand band;
@override@JsonKey() final  int activeSpaces;
@override final  DateTime trialEndsAt;
@override final  DateTime? paidUntil;
/// Whole days until the trial ends, never negative; null once not
/// trialing.
@override final  int? daysLeftInTrial;
@override@JsonKey() final  bool dueNow;
/// True once billing has switched the public booking page off.
@override@JsonKey() final  bool suspended;
@override final  BillingPayment? pendingPayment;
 final  List<BillingPayment> _history;
@override@JsonKey() List<BillingPayment> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override final  InstapayDetails? instapay;

/// Create a copy of Billing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillingCopyWith<_Billing> get copyWith => __$BillingCopyWithImpl<_Billing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Billing&&(identical(other.status, status) || other.status == status)&&(identical(other.band, band) || other.band == band)&&(identical(other.activeSpaces, activeSpaces) || other.activeSpaces == activeSpaces)&&(identical(other.trialEndsAt, trialEndsAt) || other.trialEndsAt == trialEndsAt)&&(identical(other.paidUntil, paidUntil) || other.paidUntil == paidUntil)&&(identical(other.daysLeftInTrial, daysLeftInTrial) || other.daysLeftInTrial == daysLeftInTrial)&&(identical(other.dueNow, dueNow) || other.dueNow == dueNow)&&(identical(other.suspended, suspended) || other.suspended == suspended)&&(identical(other.pendingPayment, pendingPayment) || other.pendingPayment == pendingPayment)&&const DeepCollectionEquality().equals(other.history, _history)&&(identical(other.instapay, instapay) || other.instapay == instapay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,band,activeSpaces,trialEndsAt,paidUntil,daysLeftInTrial,dueNow,suspended,pendingPayment,const DeepCollectionEquality().hash(_history),instapay);
}

@override
String toString() {
    return 'Billing(status: $status, band: $band, activeSpaces: $activeSpaces, trialEndsAt: $trialEndsAt, paidUntil: $paidUntil, daysLeftInTrial: $daysLeftInTrial, dueNow: $dueNow, suspended: $suspended, pendingPayment: $pendingPayment, history: $history, instapay: $instapay)';
}


}

/// @nodoc
abstract mixin class _$BillingCopyWith<$Res> implements $BillingCopyWith<$Res> {
  factory _$BillingCopyWith(_Billing value, $Res Function(_Billing) _then) = __$BillingCopyWithImpl;
@override @useResult
$Res call({
 BillingStatus status, PlanBand band, int activeSpaces, DateTime trialEndsAt, DateTime? paidUntil, int? daysLeftInTrial, bool dueNow, bool suspended, BillingPayment? pendingPayment, List<BillingPayment> history, InstapayDetails? instapay
});


@override $PlanBandCopyWith<$Res> get band;@override $BillingPaymentCopyWith<$Res>? get pendingPayment;@override $InstapayDetailsCopyWith<$Res>? get instapay;

}
/// @nodoc
class __$BillingCopyWithImpl<$Res>
    implements _$BillingCopyWith<$Res> {
  __$BillingCopyWithImpl(this._self, this._then);

  final _Billing _self;
  final $Res Function(_Billing) _then;

/// Create a copy of Billing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? band = null,Object? activeSpaces = null,Object? trialEndsAt = null,Object? paidUntil = freezed,Object? daysLeftInTrial = freezed,Object? dueNow = null,Object? suspended = null,Object? pendingPayment = freezed,Object? history = null,Object? instapay = freezed,}) {
  return _then(_Billing(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BillingStatus,band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as PlanBand,activeSpaces: null == activeSpaces ? _self.activeSpaces : activeSpaces // ignore: cast_nullable_to_non_nullable
as int,trialEndsAt: null == trialEndsAt ? _self.trialEndsAt : trialEndsAt // ignore: cast_nullable_to_non_nullable
as DateTime,paidUntil: freezed == paidUntil ? _self.paidUntil : paidUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,daysLeftInTrial: freezed == daysLeftInTrial ? _self.daysLeftInTrial : daysLeftInTrial // ignore: cast_nullable_to_non_nullable
as int?,dueNow: null == dueNow ? _self.dueNow : dueNow // ignore: cast_nullable_to_non_nullable
as bool,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,pendingPayment: freezed == pendingPayment ? _self.pendingPayment : pendingPayment // ignore: cast_nullable_to_non_nullable
as BillingPayment?,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<BillingPayment>,instapay: freezed == instapay ? _self.instapay : instapay // ignore: cast_nullable_to_non_nullable
as InstapayDetails?,
  ));
}

/// Create a copy of Billing
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanBandCopyWith<$Res> get band {
  
  return $PlanBandCopyWith<$Res>(_self.band, (value) {
    return _then(_self.copyWith(band: value));
  });
}/// Create a copy of Billing
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BillingPaymentCopyWith<$Res>? get pendingPayment {
    if (_self.pendingPayment == null) {
    return null;
  }

  return $BillingPaymentCopyWith<$Res>(_self.pendingPayment!, (value) {
    return _then(_self.copyWith(pendingPayment: value));
  });
}/// Create a copy of Billing
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InstapayDetailsCopyWith<$Res>? get instapay {
    if (_self.instapay == null) {
    return null;
  }

  return $InstapayDetailsCopyWith<$Res>(_self.instapay!, (value) {
    return _then(_self.copyWith(instapay: value));
  });
}
}


/// @nodoc
mixin _$PlanBand {

 String get id; String get name; int get minSpaces;/// Null means the band has no ceiling and is quoted, not listed.
 int? get maxSpaces; int? get pricePesos; String get blurb;
/// Create a copy of PlanBand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanBandCopyWith<PlanBand> get copyWith => _$PlanBandCopyWithImpl<PlanBand>(this as PlanBand, _$identity);

  /// Serializes this PlanBand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlanBand;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanBand&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.minSpaces, _this.minSpaces) || other.minSpaces == _this.minSpaces)&&(identical(other.maxSpaces, _this.maxSpaces) || other.maxSpaces == _this.maxSpaces)&&(identical(other.pricePesos, _this.pricePesos) || other.pricePesos == _this.pricePesos)&&(identical(other.blurb, _this.blurb) || other.blurb == _this.blurb));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlanBand;
  return Object.hash(runtimeType,_this.id,_this.name,_this.minSpaces,_this.maxSpaces,_this.pricePesos,_this.blurb);
}

@override
String toString() {
  final _this = this as PlanBand;
  return 'PlanBand(id: ${_this.id}, name: ${_this.name}, minSpaces: ${_this.minSpaces}, maxSpaces: ${_this.maxSpaces}, pricePesos: ${_this.pricePesos}, blurb: ${_this.blurb})';
}


}

/// @nodoc
abstract mixin class $PlanBandCopyWith<$Res>  {
  factory $PlanBandCopyWith(PlanBand value, $Res Function(PlanBand) _then) = _$PlanBandCopyWithImpl;
@useResult
$Res call({
 String id, String name, int minSpaces, int? maxSpaces, int? pricePesos, String blurb
});




}
/// @nodoc
class _$PlanBandCopyWithImpl<$Res>
    implements $PlanBandCopyWith<$Res> {
  _$PlanBandCopyWithImpl(this._self, this._then);

  final PlanBand _self;
  final $Res Function(PlanBand) _then;

/// Create a copy of PlanBand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? minSpaces = null,Object? maxSpaces = freezed,Object? pricePesos = freezed,Object? blurb = null,}) {
  return _then(PlanBand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,minSpaces: null == minSpaces ? _self.minSpaces : minSpaces // ignore: cast_nullable_to_non_nullable
as int,maxSpaces: freezed == maxSpaces ? _self.maxSpaces : maxSpaces // ignore: cast_nullable_to_non_nullable
as int?,pricePesos: freezed == pricePesos ? _self.pricePesos : pricePesos // ignore: cast_nullable_to_non_nullable
as int?,blurb: null == blurb ? _self.blurb : blurb // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanBand].
extension PlanBandPatterns on PlanBand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanBand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanBand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanBand value)  $default,){
final _that = this;
switch (_that) {
case _PlanBand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanBand value)?  $default,){
final _that = this;
switch (_that) {
case _PlanBand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int minSpaces,  int? maxSpaces,  int? pricePesos,  String blurb)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanBand() when $default != null:
return $default(_that.id,_that.name,_that.minSpaces,_that.maxSpaces,_that.pricePesos,_that.blurb);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int minSpaces,  int? maxSpaces,  int? pricePesos,  String blurb)  $default,) {final _that = this;
switch (_that) {
case _PlanBand():
return $default(_that.id,_that.name,_that.minSpaces,_that.maxSpaces,_that.pricePesos,_that.blurb);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int minSpaces,  int? maxSpaces,  int? pricePesos,  String blurb)?  $default,) {final _that = this;
switch (_that) {
case _PlanBand() when $default != null:
return $default(_that.id,_that.name,_that.minSpaces,_that.maxSpaces,_that.pricePesos,_that.blurb);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanBand extends PlanBand {
  const _PlanBand({required this.id, required this.name, required this.minSpaces, this.maxSpaces, this.pricePesos, required this.blurb}): super._();
  factory _PlanBand.fromJson(Map<String, dynamic> json) => _$PlanBandFromJson(json);

@override final  String id;
@override final  String name;
@override final  int minSpaces;
/// Null means the band has no ceiling and is quoted, not listed.
@override final  int? maxSpaces;
@override final  int? pricePesos;
@override final  String blurb;

/// Create a copy of PlanBand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanBandCopyWith<_PlanBand> get copyWith => __$PlanBandCopyWithImpl<_PlanBand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanBandToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanBand&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.minSpaces, minSpaces) || other.minSpaces == minSpaces)&&(identical(other.maxSpaces, maxSpaces) || other.maxSpaces == maxSpaces)&&(identical(other.pricePesos, pricePesos) || other.pricePesos == pricePesos)&&(identical(other.blurb, blurb) || other.blurb == blurb));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,minSpaces,maxSpaces,pricePesos,blurb);
}

@override
String toString() {
    return 'PlanBand(id: $id, name: $name, minSpaces: $minSpaces, maxSpaces: $maxSpaces, pricePesos: $pricePesos, blurb: $blurb)';
}


}

/// @nodoc
abstract mixin class _$PlanBandCopyWith<$Res> implements $PlanBandCopyWith<$Res> {
  factory _$PlanBandCopyWith(_PlanBand value, $Res Function(_PlanBand) _then) = __$PlanBandCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int minSpaces, int? maxSpaces, int? pricePesos, String blurb
});




}
/// @nodoc
class __$PlanBandCopyWithImpl<$Res>
    implements _$PlanBandCopyWith<$Res> {
  __$PlanBandCopyWithImpl(this._self, this._then);

  final _PlanBand _self;
  final $Res Function(_PlanBand) _then;

/// Create a copy of PlanBand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? minSpaces = null,Object? maxSpaces = freezed,Object? pricePesos = freezed,Object? blurb = null,}) {
  return _then(_PlanBand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,minSpaces: null == minSpaces ? _self.minSpaces : minSpaces // ignore: cast_nullable_to_non_nullable
as int,maxSpaces: freezed == maxSpaces ? _self.maxSpaces : maxSpaces // ignore: cast_nullable_to_non_nullable
as int?,pricePesos: freezed == pricePesos ? _self.pricePesos : pricePesos // ignore: cast_nullable_to_non_nullable
as int?,blurb: null == blurb ? _self.blurb : blurb // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BillingPayment {

 String get id; int get amountCents; String get reference;/// Venue-local date, "YYYY-MM-DD" — what the owner says they transferred.
 String get paidAt; PaymentStatus get status; String? get note;/// The screenshot of the transfer, when one was attached. Whoever
/// approves the payment is matching a reference against a statement by
/// hand, and this is what settles it.
 String? get receiptUrl; DateTime get createdAt;
/// Create a copy of BillingPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillingPaymentCopyWith<BillingPayment> get copyWith => _$BillingPaymentCopyWithImpl<BillingPayment>(this as BillingPayment, _$identity);

  /// Serializes this BillingPayment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BillingPayment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillingPayment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.paidAt, _this.paidAt) || other.paidAt == _this.paidAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.receiptUrl, _this.receiptUrl) || other.receiptUrl == _this.receiptUrl)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BillingPayment;
  return Object.hash(runtimeType,_this.id,_this.amountCents,_this.reference,_this.paidAt,_this.status,_this.note,_this.receiptUrl,_this.createdAt);
}

@override
String toString() {
  final _this = this as BillingPayment;
  return 'BillingPayment(id: ${_this.id}, amountCents: ${_this.amountCents}, reference: ${_this.reference}, paidAt: ${_this.paidAt}, status: ${_this.status}, note: ${_this.note}, receiptUrl: ${_this.receiptUrl}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $BillingPaymentCopyWith<$Res>  {
  factory $BillingPaymentCopyWith(BillingPayment value, $Res Function(BillingPayment) _then) = _$BillingPaymentCopyWithImpl;
@useResult
$Res call({
 String id, int amountCents, String reference, String paidAt, PaymentStatus status, String? note, String? receiptUrl, DateTime createdAt
});




}
/// @nodoc
class _$BillingPaymentCopyWithImpl<$Res>
    implements $BillingPaymentCopyWith<$Res> {
  _$BillingPaymentCopyWithImpl(this._self, this._then);

  final BillingPayment _self;
  final $Res Function(BillingPayment) _then;

/// Create a copy of BillingPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amountCents = null,Object? reference = null,Object? paidAt = null,Object? status = null,Object? note = freezed,Object? receiptUrl = freezed,Object? createdAt = null,}) {
  return _then(BillingPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BillingPayment].
extension BillingPaymentPatterns on BillingPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillingPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillingPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillingPayment value)  $default,){
final _that = this;
switch (_that) {
case _BillingPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillingPayment value)?  $default,){
final _that = this;
switch (_that) {
case _BillingPayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int amountCents,  String reference,  String paidAt,  PaymentStatus status,  String? note,  String? receiptUrl,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillingPayment() when $default != null:
return $default(_that.id,_that.amountCents,_that.reference,_that.paidAt,_that.status,_that.note,_that.receiptUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int amountCents,  String reference,  String paidAt,  PaymentStatus status,  String? note,  String? receiptUrl,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _BillingPayment():
return $default(_that.id,_that.amountCents,_that.reference,_that.paidAt,_that.status,_that.note,_that.receiptUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int amountCents,  String reference,  String paidAt,  PaymentStatus status,  String? note,  String? receiptUrl,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BillingPayment() when $default != null:
return $default(_that.id,_that.amountCents,_that.reference,_that.paidAt,_that.status,_that.note,_that.receiptUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BillingPayment extends BillingPayment {
  const _BillingPayment({required this.id, this.amountCents = 0, required this.reference, required this.paidAt, this.status = PaymentStatus.submitted, this.note, this.receiptUrl, required this.createdAt}): super._();
  factory _BillingPayment.fromJson(Map<String, dynamic> json) => _$BillingPaymentFromJson(json);

@override final  String id;
@override@JsonKey() final  int amountCents;
@override final  String reference;
/// Venue-local date, "YYYY-MM-DD" — what the owner says they transferred.
@override final  String paidAt;
@override@JsonKey() final  PaymentStatus status;
@override final  String? note;
/// The screenshot of the transfer, when one was attached. Whoever
/// approves the payment is matching a reference against a statement by
/// hand, and this is what settles it.
@override final  String? receiptUrl;
@override final  DateTime createdAt;

/// Create a copy of BillingPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillingPaymentCopyWith<_BillingPayment> get copyWith => __$BillingPaymentCopyWithImpl<_BillingPayment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillingPaymentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillingPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,amountCents,reference,paidAt,status,note,receiptUrl,createdAt);
}

@override
String toString() {
    return 'BillingPayment(id: $id, amountCents: $amountCents, reference: $reference, paidAt: $paidAt, status: $status, note: $note, receiptUrl: $receiptUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BillingPaymentCopyWith<$Res> implements $BillingPaymentCopyWith<$Res> {
  factory _$BillingPaymentCopyWith(_BillingPayment value, $Res Function(_BillingPayment) _then) = __$BillingPaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, int amountCents, String reference, String paidAt, PaymentStatus status, String? note, String? receiptUrl, DateTime createdAt
});




}
/// @nodoc
class __$BillingPaymentCopyWithImpl<$Res>
    implements _$BillingPaymentCopyWith<$Res> {
  __$BillingPaymentCopyWithImpl(this._self, this._then);

  final _BillingPayment _self;
  final $Res Function(_BillingPayment) _then;

/// Create a copy of BillingPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amountCents = null,Object? reference = null,Object? paidAt = null,Object? status = null,Object? note = freezed,Object? receiptUrl = freezed,Object? createdAt = null,}) {
  return _then(_BillingPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$InstapayDetails {

 String? get qrUrl; String? get payee; String? get account;
/// Create a copy of InstapayDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstapayDetailsCopyWith<InstapayDetails> get copyWith => _$InstapayDetailsCopyWithImpl<InstapayDetails>(this as InstapayDetails, _$identity);

  /// Serializes this InstapayDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InstapayDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstapayDetails&&(identical(other.qrUrl, _this.qrUrl) || other.qrUrl == _this.qrUrl)&&(identical(other.payee, _this.payee) || other.payee == _this.payee)&&(identical(other.account, _this.account) || other.account == _this.account));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InstapayDetails;
  return Object.hash(runtimeType,_this.qrUrl,_this.payee,_this.account);
}

@override
String toString() {
  final _this = this as InstapayDetails;
  return 'InstapayDetails(qrUrl: ${_this.qrUrl}, payee: ${_this.payee}, account: ${_this.account})';
}


}

/// @nodoc
abstract mixin class $InstapayDetailsCopyWith<$Res>  {
  factory $InstapayDetailsCopyWith(InstapayDetails value, $Res Function(InstapayDetails) _then) = _$InstapayDetailsCopyWithImpl;
@useResult
$Res call({
 String? qrUrl, String? payee, String? account
});




}
/// @nodoc
class _$InstapayDetailsCopyWithImpl<$Res>
    implements $InstapayDetailsCopyWith<$Res> {
  _$InstapayDetailsCopyWithImpl(this._self, this._then);

  final InstapayDetails _self;
  final $Res Function(InstapayDetails) _then;

/// Create a copy of InstapayDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? qrUrl = freezed,Object? payee = freezed,Object? account = freezed,}) {
  return _then(InstapayDetails(
qrUrl: freezed == qrUrl ? _self.qrUrl : qrUrl // ignore: cast_nullable_to_non_nullable
as String?,payee: freezed == payee ? _self.payee : payee // ignore: cast_nullable_to_non_nullable
as String?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InstapayDetails].
extension InstapayDetailsPatterns on InstapayDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstapayDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstapayDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstapayDetails value)  $default,){
final _that = this;
switch (_that) {
case _InstapayDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstapayDetails value)?  $default,){
final _that = this;
switch (_that) {
case _InstapayDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? qrUrl,  String? payee,  String? account)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstapayDetails() when $default != null:
return $default(_that.qrUrl,_that.payee,_that.account);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? qrUrl,  String? payee,  String? account)  $default,) {final _that = this;
switch (_that) {
case _InstapayDetails():
return $default(_that.qrUrl,_that.payee,_that.account);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? qrUrl,  String? payee,  String? account)?  $default,) {final _that = this;
switch (_that) {
case _InstapayDetails() when $default != null:
return $default(_that.qrUrl,_that.payee,_that.account);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InstapayDetails extends InstapayDetails {
  const _InstapayDetails({this.qrUrl, this.payee, this.account}): super._();
  factory _InstapayDetails.fromJson(Map<String, dynamic> json) => _$InstapayDetailsFromJson(json);

@override final  String? qrUrl;
@override final  String? payee;
@override final  String? account;

/// Create a copy of InstapayDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstapayDetailsCopyWith<_InstapayDetails> get copyWith => __$InstapayDetailsCopyWithImpl<_InstapayDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InstapayDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstapayDetails&&(identical(other.qrUrl, qrUrl) || other.qrUrl == qrUrl)&&(identical(other.payee, payee) || other.payee == payee)&&(identical(other.account, account) || other.account == account));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,qrUrl,payee,account);
}

@override
String toString() {
    return 'InstapayDetails(qrUrl: $qrUrl, payee: $payee, account: $account)';
}


}

/// @nodoc
abstract mixin class _$InstapayDetailsCopyWith<$Res> implements $InstapayDetailsCopyWith<$Res> {
  factory _$InstapayDetailsCopyWith(_InstapayDetails value, $Res Function(_InstapayDetails) _then) = __$InstapayDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? qrUrl, String? payee, String? account
});




}
/// @nodoc
class __$InstapayDetailsCopyWithImpl<$Res>
    implements _$InstapayDetailsCopyWith<$Res> {
  __$InstapayDetailsCopyWithImpl(this._self, this._then);

  final _InstapayDetails _self;
  final $Res Function(_InstapayDetails) _then;

/// Create a copy of InstapayDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? qrUrl = freezed,Object? payee = freezed,Object? account = freezed,}) {
  return _then(_InstapayDetails(
qrUrl: freezed == qrUrl ? _self.qrUrl : qrUrl // ignore: cast_nullable_to_non_nullable
as String?,payee: freezed == payee ? _self.payee : payee // ignore: cast_nullable_to_non_nullable
as String?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
