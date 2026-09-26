// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'growth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MembershipPlan {

 String get id; String get name; PlanKind get kind; int get priceCents; int? get credits;/// `one_time` | `monthly` — decided by [kind], never chosen separately.
 String get period; int? get discountPct; int? get validDays; bool get active; int get holders;
/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipPlanCopyWith<MembershipPlan> get copyWith => _$MembershipPlanCopyWithImpl<MembershipPlan>(this as MembershipPlan, _$identity);

  /// Serializes this MembershipPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MembershipPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MembershipPlan&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.priceCents, _this.priceCents) || other.priceCents == _this.priceCents)&&(identical(other.credits, _this.credits) || other.credits == _this.credits)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.discountPct, _this.discountPct) || other.discountPct == _this.discountPct)&&(identical(other.validDays, _this.validDays) || other.validDays == _this.validDays)&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.holders, _this.holders) || other.holders == _this.holders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MembershipPlan;
  return Object.hash(runtimeType,_this.id,_this.name,_this.kind,_this.priceCents,_this.credits,_this.period,_this.discountPct,_this.validDays,_this.active,_this.holders);
}

@override
String toString() {
  final _this = this as MembershipPlan;
  return 'MembershipPlan(id: ${_this.id}, name: ${_this.name}, kind: ${_this.kind}, priceCents: ${_this.priceCents}, credits: ${_this.credits}, period: ${_this.period}, discountPct: ${_this.discountPct}, validDays: ${_this.validDays}, active: ${_this.active}, holders: ${_this.holders})';
}


}

/// @nodoc
abstract mixin class $MembershipPlanCopyWith<$Res>  {
  factory $MembershipPlanCopyWith(MembershipPlan value, $Res Function(MembershipPlan) _then) = _$MembershipPlanCopyWithImpl;
@useResult
$Res call({
 String id, String name, PlanKind kind, int priceCents, int? credits, String period, int? discountPct, int? validDays, bool active, int holders
});




}
/// @nodoc
class _$MembershipPlanCopyWithImpl<$Res>
    implements $MembershipPlanCopyWith<$Res> {
  _$MembershipPlanCopyWithImpl(this._self, this._then);

  final MembershipPlan _self;
  final $Res Function(MembershipPlan) _then;

/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? priceCents = null,Object? credits = freezed,Object? period = null,Object? discountPct = freezed,Object? validDays = freezed,Object? active = null,Object? holders = null,}) {
  return _then(MembershipPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PlanKind,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int?,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,discountPct: freezed == discountPct ? _self.discountPct : discountPct // ignore: cast_nullable_to_non_nullable
as int?,validDays: freezed == validDays ? _self.validDays : validDays // ignore: cast_nullable_to_non_nullable
as int?,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,holders: null == holders ? _self.holders : holders // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MembershipPlan].
extension MembershipPlanPatterns on MembershipPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MembershipPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MembershipPlan value)  $default,){
final _that = this;
switch (_that) {
case _MembershipPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MembershipPlan value)?  $default,){
final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  PlanKind kind,  int priceCents,  int? credits,  String period,  int? discountPct,  int? validDays,  bool active,  int holders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.priceCents,_that.credits,_that.period,_that.discountPct,_that.validDays,_that.active,_that.holders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  PlanKind kind,  int priceCents,  int? credits,  String period,  int? discountPct,  int? validDays,  bool active,  int holders)  $default,) {final _that = this;
switch (_that) {
case _MembershipPlan():
return $default(_that.id,_that.name,_that.kind,_that.priceCents,_that.credits,_that.period,_that.discountPct,_that.validDays,_that.active,_that.holders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  PlanKind kind,  int priceCents,  int? credits,  String period,  int? discountPct,  int? validDays,  bool active,  int holders)?  $default,) {final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.priceCents,_that.credits,_that.period,_that.discountPct,_that.validDays,_that.active,_that.holders);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MembershipPlan extends MembershipPlan {
  const _MembershipPlan({required this.id, required this.name, this.kind = PlanKind.pass, this.priceCents = 0, this.credits, this.period = 'one_time', this.discountPct, this.validDays, this.active = true, this.holders = 0}): super._();
  factory _MembershipPlan.fromJson(Map<String, dynamic> json) => _$MembershipPlanFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  PlanKind kind;
@override@JsonKey() final  int priceCents;
@override final  int? credits;
/// `one_time` | `monthly` — decided by [kind], never chosen separately.
@override@JsonKey() final  String period;
@override final  int? discountPct;
@override final  int? validDays;
@override@JsonKey() final  bool active;
@override@JsonKey() final  int holders;

/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipPlanCopyWith<_MembershipPlan> get copyWith => __$MembershipPlanCopyWithImpl<_MembershipPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MembershipPlanToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembershipPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.credits, credits) || other.credits == credits)&&(identical(other.period, period) || other.period == period)&&(identical(other.discountPct, discountPct) || other.discountPct == discountPct)&&(identical(other.validDays, validDays) || other.validDays == validDays)&&(identical(other.active, active) || other.active == active)&&(identical(other.holders, holders) || other.holders == holders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,kind,priceCents,credits,period,discountPct,validDays,active,holders);
}

@override
String toString() {
    return 'MembershipPlan(id: $id, name: $name, kind: $kind, priceCents: $priceCents, credits: $credits, period: $period, discountPct: $discountPct, validDays: $validDays, active: $active, holders: $holders)';
}


}

/// @nodoc
abstract mixin class _$MembershipPlanCopyWith<$Res> implements $MembershipPlanCopyWith<$Res> {
  factory _$MembershipPlanCopyWith(_MembershipPlan value, $Res Function(_MembershipPlan) _then) = __$MembershipPlanCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, PlanKind kind, int priceCents, int? credits, String period, int? discountPct, int? validDays, bool active, int holders
});




}
/// @nodoc
class __$MembershipPlanCopyWithImpl<$Res>
    implements _$MembershipPlanCopyWith<$Res> {
  __$MembershipPlanCopyWithImpl(this._self, this._then);

  final _MembershipPlan _self;
  final $Res Function(_MembershipPlan) _then;

/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? priceCents = null,Object? credits = freezed,Object? period = null,Object? discountPct = freezed,Object? validDays = freezed,Object? active = null,Object? holders = null,}) {
  return _then(_MembershipPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PlanKind,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int?,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,discountPct: freezed == discountPct ? _self.discountPct : discountPct // ignore: cast_nullable_to_non_nullable
as int?,validDays: freezed == validDays ? _self.validDays : validDays // ignore: cast_nullable_to_non_nullable
as int?,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,holders: null == holders ? _self.holders : holders // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PlanInput {

 String get name; PlanKind get kind;/// Whole pesos, as typed.
 String get price; String get credits; String get discountPct; String get validDays;
/// Create a copy of PlanInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanInputCopyWith<PlanInput> get copyWith => _$PlanInputCopyWithImpl<PlanInput>(this as PlanInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlanInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanInput&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.credits, _this.credits) || other.credits == _this.credits)&&(identical(other.discountPct, _this.discountPct) || other.discountPct == _this.discountPct)&&(identical(other.validDays, _this.validDays) || other.validDays == _this.validDays));
}


@override
int get hashCode {
  final _this = this as PlanInput;
  return Object.hash(runtimeType,_this.name,_this.kind,_this.price,_this.credits,_this.discountPct,_this.validDays);
}

@override
String toString() {
  final _this = this as PlanInput;
  return 'PlanInput(name: ${_this.name}, kind: ${_this.kind}, price: ${_this.price}, credits: ${_this.credits}, discountPct: ${_this.discountPct}, validDays: ${_this.validDays})';
}


}

/// @nodoc
abstract mixin class $PlanInputCopyWith<$Res>  {
  factory $PlanInputCopyWith(PlanInput value, $Res Function(PlanInput) _then) = _$PlanInputCopyWithImpl;
@useResult
$Res call({
 String name, PlanKind kind, String price, String credits, String discountPct, String validDays
});




}
/// @nodoc
class _$PlanInputCopyWithImpl<$Res>
    implements $PlanInputCopyWith<$Res> {
  _$PlanInputCopyWithImpl(this._self, this._then);

  final PlanInput _self;
  final $Res Function(PlanInput) _then;

/// Create a copy of PlanInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? kind = null,Object? price = null,Object? credits = null,Object? discountPct = null,Object? validDays = null,}) {
  return _then(PlanInput(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PlanKind,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as String,discountPct: null == discountPct ? _self.discountPct : discountPct // ignore: cast_nullable_to_non_nullable
as String,validDays: null == validDays ? _self.validDays : validDays // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanInput].
extension PlanInputPatterns on PlanInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanInput value)  $default,){
final _that = this;
switch (_that) {
case _PlanInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanInput value)?  $default,){
final _that = this;
switch (_that) {
case _PlanInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  PlanKind kind,  String price,  String credits,  String discountPct,  String validDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanInput() when $default != null:
return $default(_that.name,_that.kind,_that.price,_that.credits,_that.discountPct,_that.validDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  PlanKind kind,  String price,  String credits,  String discountPct,  String validDays)  $default,) {final _that = this;
switch (_that) {
case _PlanInput():
return $default(_that.name,_that.kind,_that.price,_that.credits,_that.discountPct,_that.validDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  PlanKind kind,  String price,  String credits,  String discountPct,  String validDays)?  $default,) {final _that = this;
switch (_that) {
case _PlanInput() when $default != null:
return $default(_that.name,_that.kind,_that.price,_that.credits,_that.discountPct,_that.validDays);case _:
  return null;

}
}

}

/// @nodoc


class _PlanInput extends PlanInput {
  const _PlanInput({required this.name, this.kind = PlanKind.pass, required this.price, this.credits = '', this.discountPct = '', this.validDays = ''}): super._();
  

@override final  String name;
@override@JsonKey() final  PlanKind kind;
/// Whole pesos, as typed.
@override final  String price;
@override@JsonKey() final  String credits;
@override@JsonKey() final  String discountPct;
@override@JsonKey() final  String validDays;

/// Create a copy of PlanInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanInputCopyWith<_PlanInput> get copyWith => __$PlanInputCopyWithImpl<_PlanInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanInput&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.price, price) || other.price == price)&&(identical(other.credits, credits) || other.credits == credits)&&(identical(other.discountPct, discountPct) || other.discountPct == discountPct)&&(identical(other.validDays, validDays) || other.validDays == validDays));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,kind,price,credits,discountPct,validDays);
}

@override
String toString() {
    return 'PlanInput(name: $name, kind: $kind, price: $price, credits: $credits, discountPct: $discountPct, validDays: $validDays)';
}


}

/// @nodoc
abstract mixin class _$PlanInputCopyWith<$Res> implements $PlanInputCopyWith<$Res> {
  factory _$PlanInputCopyWith(_PlanInput value, $Res Function(_PlanInput) _then) = __$PlanInputCopyWithImpl;
@override @useResult
$Res call({
 String name, PlanKind kind, String price, String credits, String discountPct, String validDays
});




}
/// @nodoc
class __$PlanInputCopyWithImpl<$Res>
    implements _$PlanInputCopyWith<$Res> {
  __$PlanInputCopyWithImpl(this._self, this._then);

  final _PlanInput _self;
  final $Res Function(_PlanInput) _then;

/// Create a copy of PlanInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? kind = null,Object? price = null,Object? credits = null,Object? discountPct = null,Object? validDays = null,}) {
  return _then(_PlanInput(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PlanKind,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as String,discountPct: null == discountPct ? _self.discountPct : discountPct // ignore: cast_nullable_to_non_nullable
as String,validDays: null == validDays ? _self.validDays : validDays // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Holding {

 String get id; String get planId; String get planName; PlanKind get kind; int get creditsRemaining; int? get discountPct;/// active | expired | cancelled
 String get status; DateTime? get expiresAt;
/// Create a copy of Holding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HoldingCopyWith<Holding> get copyWith => _$HoldingCopyWithImpl<Holding>(this as Holding, _$identity);

  /// Serializes this Holding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Holding;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Holding&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.planId, _this.planId) || other.planId == _this.planId)&&(identical(other.planName, _this.planName) || other.planName == _this.planName)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.creditsRemaining, _this.creditsRemaining) || other.creditsRemaining == _this.creditsRemaining)&&(identical(other.discountPct, _this.discountPct) || other.discountPct == _this.discountPct)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Holding;
  return Object.hash(runtimeType,_this.id,_this.planId,_this.planName,_this.kind,_this.creditsRemaining,_this.discountPct,_this.status,_this.expiresAt);
}

@override
String toString() {
  final _this = this as Holding;
  return 'Holding(id: ${_this.id}, planId: ${_this.planId}, planName: ${_this.planName}, kind: ${_this.kind}, creditsRemaining: ${_this.creditsRemaining}, discountPct: ${_this.discountPct}, status: ${_this.status}, expiresAt: ${_this.expiresAt})';
}


}

/// @nodoc
abstract mixin class $HoldingCopyWith<$Res>  {
  factory $HoldingCopyWith(Holding value, $Res Function(Holding) _then) = _$HoldingCopyWithImpl;
@useResult
$Res call({
 String id, String planId, String planName, PlanKind kind, int creditsRemaining, int? discountPct, String status, DateTime? expiresAt
});




}
/// @nodoc
class _$HoldingCopyWithImpl<$Res>
    implements $HoldingCopyWith<$Res> {
  _$HoldingCopyWithImpl(this._self, this._then);

  final Holding _self;
  final $Res Function(Holding) _then;

/// Create a copy of Holding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? planId = null,Object? planName = null,Object? kind = null,Object? creditsRemaining = null,Object? discountPct = freezed,Object? status = null,Object? expiresAt = freezed,}) {
  return _then(Holding(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PlanKind,creditsRemaining: null == creditsRemaining ? _self.creditsRemaining : creditsRemaining // ignore: cast_nullable_to_non_nullable
as int,discountPct: freezed == discountPct ? _self.discountPct : discountPct // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Holding].
extension HoldingPatterns on Holding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Holding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Holding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Holding value)  $default,){
final _that = this;
switch (_that) {
case _Holding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Holding value)?  $default,){
final _that = this;
switch (_that) {
case _Holding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String planId,  String planName,  PlanKind kind,  int creditsRemaining,  int? discountPct,  String status,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Holding() when $default != null:
return $default(_that.id,_that.planId,_that.planName,_that.kind,_that.creditsRemaining,_that.discountPct,_that.status,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String planId,  String planName,  PlanKind kind,  int creditsRemaining,  int? discountPct,  String status,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _Holding():
return $default(_that.id,_that.planId,_that.planName,_that.kind,_that.creditsRemaining,_that.discountPct,_that.status,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String planId,  String planName,  PlanKind kind,  int creditsRemaining,  int? discountPct,  String status,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _Holding() when $default != null:
return $default(_that.id,_that.planId,_that.planName,_that.kind,_that.creditsRemaining,_that.discountPct,_that.status,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Holding extends Holding {
  const _Holding({required this.id, required this.planId, required this.planName, this.kind = PlanKind.pass, this.creditsRemaining = 0, this.discountPct, this.status = 'active', this.expiresAt}): super._();
  factory _Holding.fromJson(Map<String, dynamic> json) => _$HoldingFromJson(json);

@override final  String id;
@override final  String planId;
@override final  String planName;
@override@JsonKey() final  PlanKind kind;
@override@JsonKey() final  int creditsRemaining;
@override final  int? discountPct;
/// active | expired | cancelled
@override@JsonKey() final  String status;
@override final  DateTime? expiresAt;

/// Create a copy of Holding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HoldingCopyWith<_Holding> get copyWith => __$HoldingCopyWithImpl<_Holding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HoldingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Holding&&(identical(other.id, id) || other.id == id)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.creditsRemaining, creditsRemaining) || other.creditsRemaining == creditsRemaining)&&(identical(other.discountPct, discountPct) || other.discountPct == discountPct)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,planId,planName,kind,creditsRemaining,discountPct,status,expiresAt);
}

@override
String toString() {
    return 'Holding(id: $id, planId: $planId, planName: $planName, kind: $kind, creditsRemaining: $creditsRemaining, discountPct: $discountPct, status: $status, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$HoldingCopyWith<$Res> implements $HoldingCopyWith<$Res> {
  factory _$HoldingCopyWith(_Holding value, $Res Function(_Holding) _then) = __$HoldingCopyWithImpl;
@override @useResult
$Res call({
 String id, String planId, String planName, PlanKind kind, int creditsRemaining, int? discountPct, String status, DateTime? expiresAt
});




}
/// @nodoc
class __$HoldingCopyWithImpl<$Res>
    implements _$HoldingCopyWith<$Res> {
  __$HoldingCopyWithImpl(this._self, this._then);

  final _Holding _self;
  final $Res Function(_Holding) _then;

/// Create a copy of Holding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? planId = null,Object? planName = null,Object? kind = null,Object? creditsRemaining = null,Object? discountPct = freezed,Object? status = null,Object? expiresAt = freezed,}) {
  return _then(_Holding(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PlanKind,creditsRemaining: null == creditsRemaining ? _self.creditsRemaining : creditsRemaining // ignore: cast_nullable_to_non_nullable
as int,discountPct: freezed == discountPct ? _self.discountPct : discountPct // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PromoCode {

 String get id; String get code; PromoKind get kind; int? get percent; int? get amountCents; int? get maxUses; int get uses; DateTime? get expiresAt; bool get active;
/// Create a copy of PromoCode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromoCodeCopyWith<PromoCode> get copyWith => _$PromoCodeCopyWithImpl<PromoCode>(this as PromoCode, _$identity);

  /// Serializes this PromoCode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PromoCode;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromoCode&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.percent, _this.percent) || other.percent == _this.percent)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.maxUses, _this.maxUses) || other.maxUses == _this.maxUses)&&(identical(other.uses, _this.uses) || other.uses == _this.uses)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.active, _this.active) || other.active == _this.active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PromoCode;
  return Object.hash(runtimeType,_this.id,_this.code,_this.kind,_this.percent,_this.amountCents,_this.maxUses,_this.uses,_this.expiresAt,_this.active);
}

@override
String toString() {
  final _this = this as PromoCode;
  return 'PromoCode(id: ${_this.id}, code: ${_this.code}, kind: ${_this.kind}, percent: ${_this.percent}, amountCents: ${_this.amountCents}, maxUses: ${_this.maxUses}, uses: ${_this.uses}, expiresAt: ${_this.expiresAt}, active: ${_this.active})';
}


}

/// @nodoc
abstract mixin class $PromoCodeCopyWith<$Res>  {
  factory $PromoCodeCopyWith(PromoCode value, $Res Function(PromoCode) _then) = _$PromoCodeCopyWithImpl;
@useResult
$Res call({
 String id, String code, PromoKind kind, int? percent, int? amountCents, int? maxUses, int uses, DateTime? expiresAt, bool active
});




}
/// @nodoc
class _$PromoCodeCopyWithImpl<$Res>
    implements $PromoCodeCopyWith<$Res> {
  _$PromoCodeCopyWithImpl(this._self, this._then);

  final PromoCode _self;
  final $Res Function(PromoCode) _then;

/// Create a copy of PromoCode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? kind = null,Object? percent = freezed,Object? amountCents = freezed,Object? maxUses = freezed,Object? uses = null,Object? expiresAt = freezed,Object? active = null,}) {
  return _then(PromoCode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PromoKind,percent: freezed == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as int?,amountCents: freezed == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,uses: null == uses ? _self.uses : uses // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PromoCode].
extension PromoCodePatterns on PromoCode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PromoCode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PromoCode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PromoCode value)  $default,){
final _that = this;
switch (_that) {
case _PromoCode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PromoCode value)?  $default,){
final _that = this;
switch (_that) {
case _PromoCode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  PromoKind kind,  int? percent,  int? amountCents,  int? maxUses,  int uses,  DateTime? expiresAt,  bool active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PromoCode() when $default != null:
return $default(_that.id,_that.code,_that.kind,_that.percent,_that.amountCents,_that.maxUses,_that.uses,_that.expiresAt,_that.active);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  PromoKind kind,  int? percent,  int? amountCents,  int? maxUses,  int uses,  DateTime? expiresAt,  bool active)  $default,) {final _that = this;
switch (_that) {
case _PromoCode():
return $default(_that.id,_that.code,_that.kind,_that.percent,_that.amountCents,_that.maxUses,_that.uses,_that.expiresAt,_that.active);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  PromoKind kind,  int? percent,  int? amountCents,  int? maxUses,  int uses,  DateTime? expiresAt,  bool active)?  $default,) {final _that = this;
switch (_that) {
case _PromoCode() when $default != null:
return $default(_that.id,_that.code,_that.kind,_that.percent,_that.amountCents,_that.maxUses,_that.uses,_that.expiresAt,_that.active);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PromoCode extends PromoCode {
  const _PromoCode({required this.id, required this.code, this.kind = PromoKind.percent, this.percent, this.amountCents, this.maxUses, this.uses = 0, this.expiresAt, this.active = true}): super._();
  factory _PromoCode.fromJson(Map<String, dynamic> json) => _$PromoCodeFromJson(json);

@override final  String id;
@override final  String code;
@override@JsonKey() final  PromoKind kind;
@override final  int? percent;
@override final  int? amountCents;
@override final  int? maxUses;
@override@JsonKey() final  int uses;
@override final  DateTime? expiresAt;
@override@JsonKey() final  bool active;

/// Create a copy of PromoCode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromoCodeCopyWith<_PromoCode> get copyWith => __$PromoCodeCopyWithImpl<_PromoCode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PromoCodeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PromoCode&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.percent, percent) || other.percent == percent)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.uses, uses) || other.uses == uses)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,code,kind,percent,amountCents,maxUses,uses,expiresAt,active);
}

@override
String toString() {
    return 'PromoCode(id: $id, code: $code, kind: $kind, percent: $percent, amountCents: $amountCents, maxUses: $maxUses, uses: $uses, expiresAt: $expiresAt, active: $active)';
}


}

/// @nodoc
abstract mixin class _$PromoCodeCopyWith<$Res> implements $PromoCodeCopyWith<$Res> {
  factory _$PromoCodeCopyWith(_PromoCode value, $Res Function(_PromoCode) _then) = __$PromoCodeCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, PromoKind kind, int? percent, int? amountCents, int? maxUses, int uses, DateTime? expiresAt, bool active
});




}
/// @nodoc
class __$PromoCodeCopyWithImpl<$Res>
    implements _$PromoCodeCopyWith<$Res> {
  __$PromoCodeCopyWithImpl(this._self, this._then);

  final _PromoCode _self;
  final $Res Function(_PromoCode) _then;

/// Create a copy of PromoCode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? kind = null,Object? percent = freezed,Object? amountCents = freezed,Object? maxUses = freezed,Object? uses = null,Object? expiresAt = freezed,Object? active = null,}) {
  return _then(_PromoCode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PromoKind,percent: freezed == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as int?,amountCents: freezed == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,uses: null == uses ? _self.uses : uses // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$PromoInput {

 String get code; PromoKind get kind;/// A percentage, or whole pesos off.
 String get value; String get maxUses;/// Venue-local `YYYY-MM-DD`, inclusive; null for no expiry.
 String? get expiresAt;
/// Create a copy of PromoInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromoInputCopyWith<PromoInput> get copyWith => _$PromoInputCopyWithImpl<PromoInput>(this as PromoInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PromoInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromoInput&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.maxUses, _this.maxUses) || other.maxUses == _this.maxUses)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt));
}


@override
int get hashCode {
  final _this = this as PromoInput;
  return Object.hash(runtimeType,_this.code,_this.kind,_this.value,_this.maxUses,_this.expiresAt);
}

@override
String toString() {
  final _this = this as PromoInput;
  return 'PromoInput(code: ${_this.code}, kind: ${_this.kind}, value: ${_this.value}, maxUses: ${_this.maxUses}, expiresAt: ${_this.expiresAt})';
}


}

/// @nodoc
abstract mixin class $PromoInputCopyWith<$Res>  {
  factory $PromoInputCopyWith(PromoInput value, $Res Function(PromoInput) _then) = _$PromoInputCopyWithImpl;
@useResult
$Res call({
 String code, PromoKind kind, String value, String maxUses, String? expiresAt
});




}
/// @nodoc
class _$PromoInputCopyWithImpl<$Res>
    implements $PromoInputCopyWith<$Res> {
  _$PromoInputCopyWithImpl(this._self, this._then);

  final PromoInput _self;
  final $Res Function(PromoInput) _then;

/// Create a copy of PromoInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? kind = null,Object? value = null,Object? maxUses = null,Object? expiresAt = freezed,}) {
  return _then(PromoInput(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PromoKind,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,maxUses: null == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PromoInput].
extension PromoInputPatterns on PromoInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PromoInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PromoInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PromoInput value)  $default,){
final _that = this;
switch (_that) {
case _PromoInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PromoInput value)?  $default,){
final _that = this;
switch (_that) {
case _PromoInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  PromoKind kind,  String value,  String maxUses,  String? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PromoInput() when $default != null:
return $default(_that.code,_that.kind,_that.value,_that.maxUses,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  PromoKind kind,  String value,  String maxUses,  String? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _PromoInput():
return $default(_that.code,_that.kind,_that.value,_that.maxUses,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  PromoKind kind,  String value,  String maxUses,  String? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _PromoInput() when $default != null:
return $default(_that.code,_that.kind,_that.value,_that.maxUses,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _PromoInput extends PromoInput {
  const _PromoInput({required this.code, this.kind = PromoKind.percent, required this.value, this.maxUses = '', this.expiresAt}): super._();
  

@override final  String code;
@override@JsonKey() final  PromoKind kind;
/// A percentage, or whole pesos off.
@override final  String value;
@override@JsonKey() final  String maxUses;
/// Venue-local `YYYY-MM-DD`, inclusive; null for no expiry.
@override final  String? expiresAt;

/// Create a copy of PromoInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromoInputCopyWith<_PromoInput> get copyWith => __$PromoInputCopyWithImpl<_PromoInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PromoInput&&(identical(other.code, code) || other.code == code)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.value, value) || other.value == value)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,code,kind,value,maxUses,expiresAt);
}

@override
String toString() {
    return 'PromoInput(code: $code, kind: $kind, value: $value, maxUses: $maxUses, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$PromoInputCopyWith<$Res> implements $PromoInputCopyWith<$Res> {
  factory _$PromoInputCopyWith(_PromoInput value, $Res Function(_PromoInput) _then) = __$PromoInputCopyWithImpl;
@override @useResult
$Res call({
 String code, PromoKind kind, String value, String maxUses, String? expiresAt
});




}
/// @nodoc
class __$PromoInputCopyWithImpl<$Res>
    implements _$PromoInputCopyWith<$Res> {
  __$PromoInputCopyWithImpl(this._self, this._then);

  final _PromoInput _self;
  final $Res Function(_PromoInput) _then;

/// Create a copy of PromoInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? kind = null,Object? value = null,Object? maxUses = null,Object? expiresAt = freezed,}) {
  return _then(_PromoInput(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PromoKind,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,maxUses: null == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MarketingSettings {

 String? get reviewUrl; LoyaltyRules get loyalty;
/// Create a copy of MarketingSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketingSettingsCopyWith<MarketingSettings> get copyWith => _$MarketingSettingsCopyWithImpl<MarketingSettings>(this as MarketingSettings, _$identity);

  /// Serializes this MarketingSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MarketingSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketingSettings&&(identical(other.reviewUrl, _this.reviewUrl) || other.reviewUrl == _this.reviewUrl)&&(identical(other.loyalty, _this.loyalty) || other.loyalty == _this.loyalty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MarketingSettings;
  return Object.hash(runtimeType,_this.reviewUrl,_this.loyalty);
}

@override
String toString() {
  final _this = this as MarketingSettings;
  return 'MarketingSettings(reviewUrl: ${_this.reviewUrl}, loyalty: ${_this.loyalty})';
}


}

/// @nodoc
abstract mixin class $MarketingSettingsCopyWith<$Res>  {
  factory $MarketingSettingsCopyWith(MarketingSettings value, $Res Function(MarketingSettings) _then) = _$MarketingSettingsCopyWithImpl;
@useResult
$Res call({
 String? reviewUrl, LoyaltyRules loyalty
});


$LoyaltyRulesCopyWith<$Res> get loyalty;

}
/// @nodoc
class _$MarketingSettingsCopyWithImpl<$Res>
    implements $MarketingSettingsCopyWith<$Res> {
  _$MarketingSettingsCopyWithImpl(this._self, this._then);

  final MarketingSettings _self;
  final $Res Function(MarketingSettings) _then;

/// Create a copy of MarketingSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reviewUrl = freezed,Object? loyalty = null,}) {
  return _then(MarketingSettings(
reviewUrl: freezed == reviewUrl ? _self.reviewUrl : reviewUrl // ignore: cast_nullable_to_non_nullable
as String?,loyalty: null == loyalty ? _self.loyalty : loyalty // ignore: cast_nullable_to_non_nullable
as LoyaltyRules,
  ));
}
/// Create a copy of MarketingSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoyaltyRulesCopyWith<$Res> get loyalty {
  
  return $LoyaltyRulesCopyWith<$Res>(_self.loyalty, (value) {
    return _then(_self.copyWith(loyalty: value));
  });
}
}


/// Adds pattern-matching-related methods to [MarketingSettings].
extension MarketingSettingsPatterns on MarketingSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketingSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketingSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketingSettings value)  $default,){
final _that = this;
switch (_that) {
case _MarketingSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketingSettings value)?  $default,){
final _that = this;
switch (_that) {
case _MarketingSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? reviewUrl,  LoyaltyRules loyalty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketingSettings() when $default != null:
return $default(_that.reviewUrl,_that.loyalty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? reviewUrl,  LoyaltyRules loyalty)  $default,) {final _that = this;
switch (_that) {
case _MarketingSettings():
return $default(_that.reviewUrl,_that.loyalty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? reviewUrl,  LoyaltyRules loyalty)?  $default,) {final _that = this;
switch (_that) {
case _MarketingSettings() when $default != null:
return $default(_that.reviewUrl,_that.loyalty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketingSettings implements MarketingSettings {
  const _MarketingSettings({this.reviewUrl, this.loyalty = const LoyaltyRules()});
  factory _MarketingSettings.fromJson(Map<String, dynamic> json) => _$MarketingSettingsFromJson(json);

@override final  String? reviewUrl;
@override@JsonKey() final  LoyaltyRules loyalty;

/// Create a copy of MarketingSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketingSettingsCopyWith<_MarketingSettings> get copyWith => __$MarketingSettingsCopyWithImpl<_MarketingSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketingSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketingSettings&&(identical(other.reviewUrl, reviewUrl) || other.reviewUrl == reviewUrl)&&(identical(other.loyalty, loyalty) || other.loyalty == loyalty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,reviewUrl,loyalty);
}

@override
String toString() {
    return 'MarketingSettings(reviewUrl: $reviewUrl, loyalty: $loyalty)';
}


}

/// @nodoc
abstract mixin class _$MarketingSettingsCopyWith<$Res> implements $MarketingSettingsCopyWith<$Res> {
  factory _$MarketingSettingsCopyWith(_MarketingSettings value, $Res Function(_MarketingSettings) _then) = __$MarketingSettingsCopyWithImpl;
@override @useResult
$Res call({
 String? reviewUrl, LoyaltyRules loyalty
});


@override $LoyaltyRulesCopyWith<$Res> get loyalty;

}
/// @nodoc
class __$MarketingSettingsCopyWithImpl<$Res>
    implements _$MarketingSettingsCopyWith<$Res> {
  __$MarketingSettingsCopyWithImpl(this._self, this._then);

  final _MarketingSettings _self;
  final $Res Function(_MarketingSettings) _then;

/// Create a copy of MarketingSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reviewUrl = freezed,Object? loyalty = null,}) {
  return _then(_MarketingSettings(
reviewUrl: freezed == reviewUrl ? _self.reviewUrl : reviewUrl // ignore: cast_nullable_to_non_nullable
as String?,loyalty: null == loyalty ? _self.loyalty : loyalty // ignore: cast_nullable_to_non_nullable
as LoyaltyRules,
  ));
}

/// Create a copy of MarketingSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoyaltyRulesCopyWith<$Res> get loyalty {
  
  return $LoyaltyRulesCopyWith<$Res>(_self.loyalty, (value) {
    return _then(_self.copyWith(loyalty: value));
  });
}
}


/// @nodoc
mixin _$LoyaltyRules {

/// One point for every this-many pesos of a confirmed booking.
 int get pesosPerPoint;/// A customer with no visit in this many days gets one win-back email.
 int get winbackAfterDays;
/// Create a copy of LoyaltyRules
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoyaltyRulesCopyWith<LoyaltyRules> get copyWith => _$LoyaltyRulesCopyWithImpl<LoyaltyRules>(this as LoyaltyRules, _$identity);

  /// Serializes this LoyaltyRules to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LoyaltyRules;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoyaltyRules&&(identical(other.pesosPerPoint, _this.pesosPerPoint) || other.pesosPerPoint == _this.pesosPerPoint)&&(identical(other.winbackAfterDays, _this.winbackAfterDays) || other.winbackAfterDays == _this.winbackAfterDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LoyaltyRules;
  return Object.hash(runtimeType,_this.pesosPerPoint,_this.winbackAfterDays);
}

@override
String toString() {
  final _this = this as LoyaltyRules;
  return 'LoyaltyRules(pesosPerPoint: ${_this.pesosPerPoint}, winbackAfterDays: ${_this.winbackAfterDays})';
}


}

/// @nodoc
abstract mixin class $LoyaltyRulesCopyWith<$Res>  {
  factory $LoyaltyRulesCopyWith(LoyaltyRules value, $Res Function(LoyaltyRules) _then) = _$LoyaltyRulesCopyWithImpl;
@useResult
$Res call({
 int pesosPerPoint, int winbackAfterDays
});




}
/// @nodoc
class _$LoyaltyRulesCopyWithImpl<$Res>
    implements $LoyaltyRulesCopyWith<$Res> {
  _$LoyaltyRulesCopyWithImpl(this._self, this._then);

  final LoyaltyRules _self;
  final $Res Function(LoyaltyRules) _then;

/// Create a copy of LoyaltyRules
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pesosPerPoint = null,Object? winbackAfterDays = null,}) {
  return _then(LoyaltyRules(
pesosPerPoint: null == pesosPerPoint ? _self.pesosPerPoint : pesosPerPoint // ignore: cast_nullable_to_non_nullable
as int,winbackAfterDays: null == winbackAfterDays ? _self.winbackAfterDays : winbackAfterDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LoyaltyRules].
extension LoyaltyRulesPatterns on LoyaltyRules {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoyaltyRules value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoyaltyRules() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoyaltyRules value)  $default,){
final _that = this;
switch (_that) {
case _LoyaltyRules():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoyaltyRules value)?  $default,){
final _that = this;
switch (_that) {
case _LoyaltyRules() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pesosPerPoint,  int winbackAfterDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoyaltyRules() when $default != null:
return $default(_that.pesosPerPoint,_that.winbackAfterDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pesosPerPoint,  int winbackAfterDays)  $default,) {final _that = this;
switch (_that) {
case _LoyaltyRules():
return $default(_that.pesosPerPoint,_that.winbackAfterDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pesosPerPoint,  int winbackAfterDays)?  $default,) {final _that = this;
switch (_that) {
case _LoyaltyRules() when $default != null:
return $default(_that.pesosPerPoint,_that.winbackAfterDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoyaltyRules implements LoyaltyRules {
  const _LoyaltyRules({this.pesosPerPoint = 100, this.winbackAfterDays = 60});
  factory _LoyaltyRules.fromJson(Map<String, dynamic> json) => _$LoyaltyRulesFromJson(json);

/// One point for every this-many pesos of a confirmed booking.
@override@JsonKey() final  int pesosPerPoint;
/// A customer with no visit in this many days gets one win-back email.
@override@JsonKey() final  int winbackAfterDays;

/// Create a copy of LoyaltyRules
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoyaltyRulesCopyWith<_LoyaltyRules> get copyWith => __$LoyaltyRulesCopyWithImpl<_LoyaltyRules>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoyaltyRulesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoyaltyRules&&(identical(other.pesosPerPoint, pesosPerPoint) || other.pesosPerPoint == pesosPerPoint)&&(identical(other.winbackAfterDays, winbackAfterDays) || other.winbackAfterDays == winbackAfterDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,pesosPerPoint,winbackAfterDays);
}

@override
String toString() {
    return 'LoyaltyRules(pesosPerPoint: $pesosPerPoint, winbackAfterDays: $winbackAfterDays)';
}


}

/// @nodoc
abstract mixin class _$LoyaltyRulesCopyWith<$Res> implements $LoyaltyRulesCopyWith<$Res> {
  factory _$LoyaltyRulesCopyWith(_LoyaltyRules value, $Res Function(_LoyaltyRules) _then) = __$LoyaltyRulesCopyWithImpl;
@override @useResult
$Res call({
 int pesosPerPoint, int winbackAfterDays
});




}
/// @nodoc
class __$LoyaltyRulesCopyWithImpl<$Res>
    implements _$LoyaltyRulesCopyWith<$Res> {
  __$LoyaltyRulesCopyWithImpl(this._self, this._then);

  final _LoyaltyRules _self;
  final $Res Function(_LoyaltyRules) _then;

/// Create a copy of LoyaltyRules
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pesosPerPoint = null,Object? winbackAfterDays = null,}) {
  return _then(_LoyaltyRules(
pesosPerPoint: null == pesosPerPoint ? _self.pesosPerPoint : pesosPerPoint // ignore: cast_nullable_to_non_nullable
as int,winbackAfterDays: null == winbackAfterDays ? _self.winbackAfterDays : winbackAfterDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Integrations {

 String? get icalUrl; List<String> get webhookEvents; List<Webhook> get webhooks; List<ApiKeyInfo> get apiKeys;
/// Create a copy of Integrations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntegrationsCopyWith<Integrations> get copyWith => _$IntegrationsCopyWithImpl<Integrations>(this as Integrations, _$identity);

  /// Serializes this Integrations to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Integrations;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Integrations&&(identical(other.icalUrl, _this.icalUrl) || other.icalUrl == _this.icalUrl)&&const DeepCollectionEquality().equals(other.webhookEvents, _this.webhookEvents)&&const DeepCollectionEquality().equals(other.webhooks, _this.webhooks)&&const DeepCollectionEquality().equals(other.apiKeys, _this.apiKeys));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Integrations;
  return Object.hash(runtimeType,_this.icalUrl,const DeepCollectionEquality().hash(_this.webhookEvents),const DeepCollectionEquality().hash(_this.webhooks),const DeepCollectionEquality().hash(_this.apiKeys));
}

@override
String toString() {
  final _this = this as Integrations;
  return 'Integrations(icalUrl: ${_this.icalUrl}, webhookEvents: ${_this.webhookEvents}, webhooks: ${_this.webhooks}, apiKeys: ${_this.apiKeys})';
}


}

/// @nodoc
abstract mixin class $IntegrationsCopyWith<$Res>  {
  factory $IntegrationsCopyWith(Integrations value, $Res Function(Integrations) _then) = _$IntegrationsCopyWithImpl;
@useResult
$Res call({
 String? icalUrl, List<String> webhookEvents, List<Webhook> webhooks, List<ApiKeyInfo> apiKeys
});




}
/// @nodoc
class _$IntegrationsCopyWithImpl<$Res>
    implements $IntegrationsCopyWith<$Res> {
  _$IntegrationsCopyWithImpl(this._self, this._then);

  final Integrations _self;
  final $Res Function(Integrations) _then;

/// Create a copy of Integrations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? icalUrl = freezed,Object? webhookEvents = null,Object? webhooks = null,Object? apiKeys = null,}) {
  return _then(Integrations(
icalUrl: freezed == icalUrl ? _self.icalUrl : icalUrl // ignore: cast_nullable_to_non_nullable
as String?,webhookEvents: null == webhookEvents ? _self.webhookEvents : webhookEvents // ignore: cast_nullable_to_non_nullable
as List<String>,webhooks: null == webhooks ? _self.webhooks : webhooks // ignore: cast_nullable_to_non_nullable
as List<Webhook>,apiKeys: null == apiKeys ? _self.apiKeys : apiKeys // ignore: cast_nullable_to_non_nullable
as List<ApiKeyInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [Integrations].
extension IntegrationsPatterns on Integrations {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Integrations value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Integrations() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Integrations value)  $default,){
final _that = this;
switch (_that) {
case _Integrations():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Integrations value)?  $default,){
final _that = this;
switch (_that) {
case _Integrations() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? icalUrl,  List<String> webhookEvents,  List<Webhook> webhooks,  List<ApiKeyInfo> apiKeys)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Integrations() when $default != null:
return $default(_that.icalUrl,_that.webhookEvents,_that.webhooks,_that.apiKeys);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? icalUrl,  List<String> webhookEvents,  List<Webhook> webhooks,  List<ApiKeyInfo> apiKeys)  $default,) {final _that = this;
switch (_that) {
case _Integrations():
return $default(_that.icalUrl,_that.webhookEvents,_that.webhooks,_that.apiKeys);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? icalUrl,  List<String> webhookEvents,  List<Webhook> webhooks,  List<ApiKeyInfo> apiKeys)?  $default,) {final _that = this;
switch (_that) {
case _Integrations() when $default != null:
return $default(_that.icalUrl,_that.webhookEvents,_that.webhooks,_that.apiKeys);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Integrations implements Integrations {
  const _Integrations({this.icalUrl,  List<String> webhookEvents = const <String>['booking.created', 'booking.cancelled'],  List<Webhook> webhooks = const <Webhook>[],  List<ApiKeyInfo> apiKeys = const <ApiKeyInfo>[]}): _webhookEvents = webhookEvents,_webhooks = webhooks,_apiKeys = apiKeys;
  factory _Integrations.fromJson(Map<String, dynamic> json) => _$IntegrationsFromJson(json);

@override final  String? icalUrl;
 final  List<String> _webhookEvents;
@override@JsonKey() List<String> get webhookEvents {
  if (_webhookEvents is EqualUnmodifiableListView) return _webhookEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_webhookEvents);
}

 final  List<Webhook> _webhooks;
@override@JsonKey() List<Webhook> get webhooks {
  if (_webhooks is EqualUnmodifiableListView) return _webhooks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_webhooks);
}

 final  List<ApiKeyInfo> _apiKeys;
@override@JsonKey() List<ApiKeyInfo> get apiKeys {
  if (_apiKeys is EqualUnmodifiableListView) return _apiKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_apiKeys);
}


/// Create a copy of Integrations
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntegrationsCopyWith<_Integrations> get copyWith => __$IntegrationsCopyWithImpl<_Integrations>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntegrationsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Integrations&&(identical(other.icalUrl, icalUrl) || other.icalUrl == icalUrl)&&const DeepCollectionEquality().equals(other.webhookEvents, _webhookEvents)&&const DeepCollectionEquality().equals(other.webhooks, _webhooks)&&const DeepCollectionEquality().equals(other.apiKeys, _apiKeys));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,icalUrl,const DeepCollectionEquality().hash(_webhookEvents),const DeepCollectionEquality().hash(_webhooks),const DeepCollectionEquality().hash(_apiKeys));
}

@override
String toString() {
    return 'Integrations(icalUrl: $icalUrl, webhookEvents: $webhookEvents, webhooks: $webhooks, apiKeys: $apiKeys)';
}


}

/// @nodoc
abstract mixin class _$IntegrationsCopyWith<$Res> implements $IntegrationsCopyWith<$Res> {
  factory _$IntegrationsCopyWith(_Integrations value, $Res Function(_Integrations) _then) = __$IntegrationsCopyWithImpl;
@override @useResult
$Res call({
 String? icalUrl, List<String> webhookEvents, List<Webhook> webhooks, List<ApiKeyInfo> apiKeys
});




}
/// @nodoc
class __$IntegrationsCopyWithImpl<$Res>
    implements _$IntegrationsCopyWith<$Res> {
  __$IntegrationsCopyWithImpl(this._self, this._then);

  final _Integrations _self;
  final $Res Function(_Integrations) _then;

/// Create a copy of Integrations
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? icalUrl = freezed,Object? webhookEvents = null,Object? webhooks = null,Object? apiKeys = null,}) {
  return _then(_Integrations(
icalUrl: freezed == icalUrl ? _self.icalUrl : icalUrl // ignore: cast_nullable_to_non_nullable
as String?,webhookEvents: null == webhookEvents ? _self._webhookEvents : webhookEvents // ignore: cast_nullable_to_non_nullable
as List<String>,webhooks: null == webhooks ? _self._webhooks : webhooks // ignore: cast_nullable_to_non_nullable
as List<Webhook>,apiKeys: null == apiKeys ? _self._apiKeys : apiKeys // ignore: cast_nullable_to_non_nullable
as List<ApiKeyInfo>,
  ));
}


}


/// @nodoc
mixin _$Webhook {

 String get id; String get url;/// Signs every delivery (HMAC-SHA256 of the body); the receiver needs it.
 String get secret; List<String> get events; bool get active; DateTime get createdAt;
/// Create a copy of Webhook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebhookCopyWith<Webhook> get copyWith => _$WebhookCopyWithImpl<Webhook>(this as Webhook, _$identity);

  /// Serializes this Webhook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Webhook;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Webhook&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.secret, _this.secret) || other.secret == _this.secret)&&const DeepCollectionEquality().equals(other.events, _this.events)&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Webhook;
  return Object.hash(runtimeType,_this.id,_this.url,_this.secret,const DeepCollectionEquality().hash(_this.events),_this.active,_this.createdAt);
}

@override
String toString() {
  final _this = this as Webhook;
  return 'Webhook(id: ${_this.id}, url: ${_this.url}, secret: ${_this.secret}, events: ${_this.events}, active: ${_this.active}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $WebhookCopyWith<$Res>  {
  factory $WebhookCopyWith(Webhook value, $Res Function(Webhook) _then) = _$WebhookCopyWithImpl;
@useResult
$Res call({
 String id, String url, String secret, List<String> events, bool active, DateTime createdAt
});




}
/// @nodoc
class _$WebhookCopyWithImpl<$Res>
    implements $WebhookCopyWith<$Res> {
  _$WebhookCopyWithImpl(this._self, this._then);

  final Webhook _self;
  final $Res Function(Webhook) _then;

/// Create a copy of Webhook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? secret = null,Object? events = null,Object? active = null,Object? createdAt = null,}) {
  return _then(Webhook(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<String>,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Webhook].
extension WebhookPatterns on Webhook {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Webhook value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Webhook() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Webhook value)  $default,){
final _that = this;
switch (_that) {
case _Webhook():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Webhook value)?  $default,){
final _that = this;
switch (_that) {
case _Webhook() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String url,  String secret,  List<String> events,  bool active,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Webhook() when $default != null:
return $default(_that.id,_that.url,_that.secret,_that.events,_that.active,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String url,  String secret,  List<String> events,  bool active,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Webhook():
return $default(_that.id,_that.url,_that.secret,_that.events,_that.active,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String url,  String secret,  List<String> events,  bool active,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Webhook() when $default != null:
return $default(_that.id,_that.url,_that.secret,_that.events,_that.active,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Webhook implements Webhook {
  const _Webhook({required this.id, required this.url, required this.secret,  List<String> events = const <String>[], this.active = true, required this.createdAt}): _events = events;
  factory _Webhook.fromJson(Map<String, dynamic> json) => _$WebhookFromJson(json);

@override final  String id;
@override final  String url;
/// Signs every delivery (HMAC-SHA256 of the body); the receiver needs it.
@override final  String secret;
 final  List<String> _events;
@override@JsonKey() List<String> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override@JsonKey() final  bool active;
@override final  DateTime createdAt;

/// Create a copy of Webhook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebhookCopyWith<_Webhook> get copyWith => __$WebhookCopyWithImpl<_Webhook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebhookToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Webhook&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.secret, secret) || other.secret == secret)&&const DeepCollectionEquality().equals(other.events, _events)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,url,secret,const DeepCollectionEquality().hash(_events),active,createdAt);
}

@override
String toString() {
    return 'Webhook(id: $id, url: $url, secret: $secret, events: $events, active: $active, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WebhookCopyWith<$Res> implements $WebhookCopyWith<$Res> {
  factory _$WebhookCopyWith(_Webhook value, $Res Function(_Webhook) _then) = __$WebhookCopyWithImpl;
@override @useResult
$Res call({
 String id, String url, String secret, List<String> events, bool active, DateTime createdAt
});




}
/// @nodoc
class __$WebhookCopyWithImpl<$Res>
    implements _$WebhookCopyWith<$Res> {
  __$WebhookCopyWithImpl(this._self, this._then);

  final _Webhook _self;
  final $Res Function(_Webhook) _then;

/// Create a copy of Webhook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? secret = null,Object? events = null,Object? active = null,Object? createdAt = null,}) {
  return _then(_Webhook(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<String>,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ApiKeyInfo {

 String get id; String get name; String get prefix; DateTime? get lastUsedAt; DateTime get createdAt; DateTime? get revokedAt;
/// Create a copy of ApiKeyInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiKeyInfoCopyWith<ApiKeyInfo> get copyWith => _$ApiKeyInfoCopyWithImpl<ApiKeyInfo>(this as ApiKeyInfo, _$identity);

  /// Serializes this ApiKeyInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ApiKeyInfo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiKeyInfo&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.prefix, _this.prefix) || other.prefix == _this.prefix)&&(identical(other.lastUsedAt, _this.lastUsedAt) || other.lastUsedAt == _this.lastUsedAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.revokedAt, _this.revokedAt) || other.revokedAt == _this.revokedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApiKeyInfo;
  return Object.hash(runtimeType,_this.id,_this.name,_this.prefix,_this.lastUsedAt,_this.createdAt,_this.revokedAt);
}

@override
String toString() {
  final _this = this as ApiKeyInfo;
  return 'ApiKeyInfo(id: ${_this.id}, name: ${_this.name}, prefix: ${_this.prefix}, lastUsedAt: ${_this.lastUsedAt}, createdAt: ${_this.createdAt}, revokedAt: ${_this.revokedAt})';
}


}

/// @nodoc
abstract mixin class $ApiKeyInfoCopyWith<$Res>  {
  factory $ApiKeyInfoCopyWith(ApiKeyInfo value, $Res Function(ApiKeyInfo) _then) = _$ApiKeyInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String prefix, DateTime? lastUsedAt, DateTime createdAt, DateTime? revokedAt
});




}
/// @nodoc
class _$ApiKeyInfoCopyWithImpl<$Res>
    implements $ApiKeyInfoCopyWith<$Res> {
  _$ApiKeyInfoCopyWithImpl(this._self, this._then);

  final ApiKeyInfo _self;
  final $Res Function(ApiKeyInfo) _then;

/// Create a copy of ApiKeyInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? prefix = null,Object? lastUsedAt = freezed,Object? createdAt = null,Object? revokedAt = freezed,}) {
  return _then(ApiKeyInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prefix: null == prefix ? _self.prefix : prefix // ignore: cast_nullable_to_non_nullable
as String,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiKeyInfo].
extension ApiKeyInfoPatterns on ApiKeyInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiKeyInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiKeyInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiKeyInfo value)  $default,){
final _that = this;
switch (_that) {
case _ApiKeyInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiKeyInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ApiKeyInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String prefix,  DateTime? lastUsedAt,  DateTime createdAt,  DateTime? revokedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiKeyInfo() when $default != null:
return $default(_that.id,_that.name,_that.prefix,_that.lastUsedAt,_that.createdAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String prefix,  DateTime? lastUsedAt,  DateTime createdAt,  DateTime? revokedAt)  $default,) {final _that = this;
switch (_that) {
case _ApiKeyInfo():
return $default(_that.id,_that.name,_that.prefix,_that.lastUsedAt,_that.createdAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String prefix,  DateTime? lastUsedAt,  DateTime createdAt,  DateTime? revokedAt)?  $default,) {final _that = this;
switch (_that) {
case _ApiKeyInfo() when $default != null:
return $default(_that.id,_that.name,_that.prefix,_that.lastUsedAt,_that.createdAt,_that.revokedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiKeyInfo extends ApiKeyInfo {
  const _ApiKeyInfo({required this.id, required this.name, required this.prefix, this.lastUsedAt, required this.createdAt, this.revokedAt}): super._();
  factory _ApiKeyInfo.fromJson(Map<String, dynamic> json) => _$ApiKeyInfoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String prefix;
@override final  DateTime? lastUsedAt;
@override final  DateTime createdAt;
@override final  DateTime? revokedAt;

/// Create a copy of ApiKeyInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiKeyInfoCopyWith<_ApiKeyInfo> get copyWith => __$ApiKeyInfoCopyWithImpl<_ApiKeyInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiKeyInfoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiKeyInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.prefix, prefix) || other.prefix == prefix)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,prefix,lastUsedAt,createdAt,revokedAt);
}

@override
String toString() {
    return 'ApiKeyInfo(id: $id, name: $name, prefix: $prefix, lastUsedAt: $lastUsedAt, createdAt: $createdAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class _$ApiKeyInfoCopyWith<$Res> implements $ApiKeyInfoCopyWith<$Res> {
  factory _$ApiKeyInfoCopyWith(_ApiKeyInfo value, $Res Function(_ApiKeyInfo) _then) = __$ApiKeyInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String prefix, DateTime? lastUsedAt, DateTime createdAt, DateTime? revokedAt
});




}
/// @nodoc
class __$ApiKeyInfoCopyWithImpl<$Res>
    implements _$ApiKeyInfoCopyWith<$Res> {
  __$ApiKeyInfoCopyWithImpl(this._self, this._then);

  final _ApiKeyInfo _self;
  final $Res Function(_ApiKeyInfo) _then;

/// Create a copy of ApiKeyInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? prefix = null,Object? lastUsedAt = freezed,Object? createdAt = null,Object? revokedAt = freezed,}) {
  return _then(_ApiKeyInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prefix: null == prefix ? _self.prefix : prefix // ignore: cast_nullable_to_non_nullable
as String,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
