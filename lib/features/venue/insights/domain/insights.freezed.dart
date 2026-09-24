// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insights.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Insights {

 InsightsRange get range; Kpi get bookedValueCents; Kpi get bookings;/// Percent, one decimal.
 Kpi get utilisationPct; Kpi get noShowRatePct; List<DayPoint> get bookedByDay;/// `[weekday 0..6][hour 0..23]` counts, Sunday first like the column.
 List<List<int>> get peakHours; BookingMix get mix; List<SpaceValue> get bySpace; CustomerMix get customers; NeedsYou get needsYou;
/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsightsCopyWith<Insights> get copyWith => _$InsightsCopyWithImpl<Insights>(this as Insights, _$identity);

  /// Serializes this Insights to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Insights;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Insights&&(identical(other.range, _this.range) || other.range == _this.range)&&(identical(other.bookedValueCents, _this.bookedValueCents) || other.bookedValueCents == _this.bookedValueCents)&&(identical(other.bookings, _this.bookings) || other.bookings == _this.bookings)&&(identical(other.utilisationPct, _this.utilisationPct) || other.utilisationPct == _this.utilisationPct)&&(identical(other.noShowRatePct, _this.noShowRatePct) || other.noShowRatePct == _this.noShowRatePct)&&const DeepCollectionEquality().equals(other.bookedByDay, _this.bookedByDay)&&const DeepCollectionEquality().equals(other.peakHours, _this.peakHours)&&(identical(other.mix, _this.mix) || other.mix == _this.mix)&&const DeepCollectionEquality().equals(other.bySpace, _this.bySpace)&&(identical(other.customers, _this.customers) || other.customers == _this.customers)&&(identical(other.needsYou, _this.needsYou) || other.needsYou == _this.needsYou));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Insights;
  return Object.hash(runtimeType,_this.range,_this.bookedValueCents,_this.bookings,_this.utilisationPct,_this.noShowRatePct,const DeepCollectionEquality().hash(_this.bookedByDay),const DeepCollectionEquality().hash(_this.peakHours),_this.mix,const DeepCollectionEquality().hash(_this.bySpace),_this.customers,_this.needsYou);
}

@override
String toString() {
  final _this = this as Insights;
  return 'Insights(range: ${_this.range}, bookedValueCents: ${_this.bookedValueCents}, bookings: ${_this.bookings}, utilisationPct: ${_this.utilisationPct}, noShowRatePct: ${_this.noShowRatePct}, bookedByDay: ${_this.bookedByDay}, peakHours: ${_this.peakHours}, mix: ${_this.mix}, bySpace: ${_this.bySpace}, customers: ${_this.customers}, needsYou: ${_this.needsYou})';
}


}

/// @nodoc
abstract mixin class $InsightsCopyWith<$Res>  {
  factory $InsightsCopyWith(Insights value, $Res Function(Insights) _then) = _$InsightsCopyWithImpl;
@useResult
$Res call({
 InsightsRange range, Kpi bookedValueCents, Kpi bookings, Kpi utilisationPct, Kpi noShowRatePct, List<DayPoint> bookedByDay, List<List<int>> peakHours, BookingMix mix, List<SpaceValue> bySpace, CustomerMix customers, NeedsYou needsYou
});


$KpiCopyWith<$Res> get bookedValueCents;$KpiCopyWith<$Res> get bookings;$KpiCopyWith<$Res> get utilisationPct;$KpiCopyWith<$Res> get noShowRatePct;$BookingMixCopyWith<$Res> get mix;$CustomerMixCopyWith<$Res> get customers;$NeedsYouCopyWith<$Res> get needsYou;

}
/// @nodoc
class _$InsightsCopyWithImpl<$Res>
    implements $InsightsCopyWith<$Res> {
  _$InsightsCopyWithImpl(this._self, this._then);

  final Insights _self;
  final $Res Function(Insights) _then;

/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? range = null,Object? bookedValueCents = null,Object? bookings = null,Object? utilisationPct = null,Object? noShowRatePct = null,Object? bookedByDay = null,Object? peakHours = null,Object? mix = null,Object? bySpace = null,Object? customers = null,Object? needsYou = null,}) {
  return _then(Insights(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as InsightsRange,bookedValueCents: null == bookedValueCents ? _self.bookedValueCents : bookedValueCents // ignore: cast_nullable_to_non_nullable
as Kpi,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as Kpi,utilisationPct: null == utilisationPct ? _self.utilisationPct : utilisationPct // ignore: cast_nullable_to_non_nullable
as Kpi,noShowRatePct: null == noShowRatePct ? _self.noShowRatePct : noShowRatePct // ignore: cast_nullable_to_non_nullable
as Kpi,bookedByDay: null == bookedByDay ? _self.bookedByDay : bookedByDay // ignore: cast_nullable_to_non_nullable
as List<DayPoint>,peakHours: null == peakHours ? _self.peakHours : peakHours // ignore: cast_nullable_to_non_nullable
as List<List<int>>,mix: null == mix ? _self.mix : mix // ignore: cast_nullable_to_non_nullable
as BookingMix,bySpace: null == bySpace ? _self.bySpace : bySpace // ignore: cast_nullable_to_non_nullable
as List<SpaceValue>,customers: null == customers ? _self.customers : customers // ignore: cast_nullable_to_non_nullable
as CustomerMix,needsYou: null == needsYou ? _self.needsYou : needsYou // ignore: cast_nullable_to_non_nullable
as NeedsYou,
  ));
}
/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpiCopyWith<$Res> get bookedValueCents {
  
  return $KpiCopyWith<$Res>(_self.bookedValueCents, (value) {
    return _then(_self.copyWith(bookedValueCents: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpiCopyWith<$Res> get bookings {
  
  return $KpiCopyWith<$Res>(_self.bookings, (value) {
    return _then(_self.copyWith(bookings: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpiCopyWith<$Res> get utilisationPct {
  
  return $KpiCopyWith<$Res>(_self.utilisationPct, (value) {
    return _then(_self.copyWith(utilisationPct: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpiCopyWith<$Res> get noShowRatePct {
  
  return $KpiCopyWith<$Res>(_self.noShowRatePct, (value) {
    return _then(_self.copyWith(noShowRatePct: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingMixCopyWith<$Res> get mix {
  
  return $BookingMixCopyWith<$Res>(_self.mix, (value) {
    return _then(_self.copyWith(mix: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerMixCopyWith<$Res> get customers {
  
  return $CustomerMixCopyWith<$Res>(_self.customers, (value) {
    return _then(_self.copyWith(customers: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NeedsYouCopyWith<$Res> get needsYou {
  
  return $NeedsYouCopyWith<$Res>(_self.needsYou, (value) {
    return _then(_self.copyWith(needsYou: value));
  });
}
}


/// Adds pattern-matching-related methods to [Insights].
extension InsightsPatterns on Insights {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Insights value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Insights() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Insights value)  $default,){
final _that = this;
switch (_that) {
case _Insights():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Insights value)?  $default,){
final _that = this;
switch (_that) {
case _Insights() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InsightsRange range,  Kpi bookedValueCents,  Kpi bookings,  Kpi utilisationPct,  Kpi noShowRatePct,  List<DayPoint> bookedByDay,  List<List<int>> peakHours,  BookingMix mix,  List<SpaceValue> bySpace,  CustomerMix customers,  NeedsYou needsYou)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Insights() when $default != null:
return $default(_that.range,_that.bookedValueCents,_that.bookings,_that.utilisationPct,_that.noShowRatePct,_that.bookedByDay,_that.peakHours,_that.mix,_that.bySpace,_that.customers,_that.needsYou);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InsightsRange range,  Kpi bookedValueCents,  Kpi bookings,  Kpi utilisationPct,  Kpi noShowRatePct,  List<DayPoint> bookedByDay,  List<List<int>> peakHours,  BookingMix mix,  List<SpaceValue> bySpace,  CustomerMix customers,  NeedsYou needsYou)  $default,) {final _that = this;
switch (_that) {
case _Insights():
return $default(_that.range,_that.bookedValueCents,_that.bookings,_that.utilisationPct,_that.noShowRatePct,_that.bookedByDay,_that.peakHours,_that.mix,_that.bySpace,_that.customers,_that.needsYou);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InsightsRange range,  Kpi bookedValueCents,  Kpi bookings,  Kpi utilisationPct,  Kpi noShowRatePct,  List<DayPoint> bookedByDay,  List<List<int>> peakHours,  BookingMix mix,  List<SpaceValue> bySpace,  CustomerMix customers,  NeedsYou needsYou)?  $default,) {final _that = this;
switch (_that) {
case _Insights() when $default != null:
return $default(_that.range,_that.bookedValueCents,_that.bookings,_that.utilisationPct,_that.noShowRatePct,_that.bookedByDay,_that.peakHours,_that.mix,_that.bySpace,_that.customers,_that.needsYou);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Insights extends Insights {
  const _Insights({this.range = InsightsRange.month, this.bookedValueCents = const Kpi(), this.bookings = const Kpi(), this.utilisationPct = const Kpi(), this.noShowRatePct = const Kpi(),  List<DayPoint> bookedByDay = const <DayPoint>[],  List<List<int>> peakHours = const <List<int>>[], this.mix = const BookingMix(),  List<SpaceValue> bySpace = const <SpaceValue>[], this.customers = const CustomerMix(), this.needsYou = const NeedsYou()}): _bookedByDay = bookedByDay,_peakHours = peakHours,_bySpace = bySpace,super._();
  factory _Insights.fromJson(Map<String, dynamic> json) => _$InsightsFromJson(json);

@override@JsonKey() final  InsightsRange range;
@override@JsonKey() final  Kpi bookedValueCents;
@override@JsonKey() final  Kpi bookings;
/// Percent, one decimal.
@override@JsonKey() final  Kpi utilisationPct;
@override@JsonKey() final  Kpi noShowRatePct;
 final  List<DayPoint> _bookedByDay;
@override@JsonKey() List<DayPoint> get bookedByDay {
  if (_bookedByDay is EqualUnmodifiableListView) return _bookedByDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookedByDay);
}

/// `[weekday 0..6][hour 0..23]` counts, Sunday first like the column.
 final  List<List<int>> _peakHours;
/// `[weekday 0..6][hour 0..23]` counts, Sunday first like the column.
@override@JsonKey() List<List<int>> get peakHours {
  if (_peakHours is EqualUnmodifiableListView) return _peakHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_peakHours);
}

@override@JsonKey() final  BookingMix mix;
 final  List<SpaceValue> _bySpace;
@override@JsonKey() List<SpaceValue> get bySpace {
  if (_bySpace is EqualUnmodifiableListView) return _bySpace;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bySpace);
}

@override@JsonKey() final  CustomerMix customers;
@override@JsonKey() final  NeedsYou needsYou;

/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InsightsCopyWith<_Insights> get copyWith => __$InsightsCopyWithImpl<_Insights>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InsightsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Insights&&(identical(other.range, range) || other.range == range)&&(identical(other.bookedValueCents, bookedValueCents) || other.bookedValueCents == bookedValueCents)&&(identical(other.bookings, bookings) || other.bookings == bookings)&&(identical(other.utilisationPct, utilisationPct) || other.utilisationPct == utilisationPct)&&(identical(other.noShowRatePct, noShowRatePct) || other.noShowRatePct == noShowRatePct)&&const DeepCollectionEquality().equals(other.bookedByDay, _bookedByDay)&&const DeepCollectionEquality().equals(other.peakHours, _peakHours)&&(identical(other.mix, mix) || other.mix == mix)&&const DeepCollectionEquality().equals(other.bySpace, _bySpace)&&(identical(other.customers, customers) || other.customers == customers)&&(identical(other.needsYou, needsYou) || other.needsYou == needsYou));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,range,bookedValueCents,bookings,utilisationPct,noShowRatePct,const DeepCollectionEquality().hash(_bookedByDay),const DeepCollectionEquality().hash(_peakHours),mix,const DeepCollectionEquality().hash(_bySpace),customers,needsYou);
}

@override
String toString() {
    return 'Insights(range: $range, bookedValueCents: $bookedValueCents, bookings: $bookings, utilisationPct: $utilisationPct, noShowRatePct: $noShowRatePct, bookedByDay: $bookedByDay, peakHours: $peakHours, mix: $mix, bySpace: $bySpace, customers: $customers, needsYou: $needsYou)';
}


}

/// @nodoc
abstract mixin class _$InsightsCopyWith<$Res> implements $InsightsCopyWith<$Res> {
  factory _$InsightsCopyWith(_Insights value, $Res Function(_Insights) _then) = __$InsightsCopyWithImpl;
@override @useResult
$Res call({
 InsightsRange range, Kpi bookedValueCents, Kpi bookings, Kpi utilisationPct, Kpi noShowRatePct, List<DayPoint> bookedByDay, List<List<int>> peakHours, BookingMix mix, List<SpaceValue> bySpace, CustomerMix customers, NeedsYou needsYou
});


@override $KpiCopyWith<$Res> get bookedValueCents;@override $KpiCopyWith<$Res> get bookings;@override $KpiCopyWith<$Res> get utilisationPct;@override $KpiCopyWith<$Res> get noShowRatePct;@override $BookingMixCopyWith<$Res> get mix;@override $CustomerMixCopyWith<$Res> get customers;@override $NeedsYouCopyWith<$Res> get needsYou;

}
/// @nodoc
class __$InsightsCopyWithImpl<$Res>
    implements _$InsightsCopyWith<$Res> {
  __$InsightsCopyWithImpl(this._self, this._then);

  final _Insights _self;
  final $Res Function(_Insights) _then;

/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? range = null,Object? bookedValueCents = null,Object? bookings = null,Object? utilisationPct = null,Object? noShowRatePct = null,Object? bookedByDay = null,Object? peakHours = null,Object? mix = null,Object? bySpace = null,Object? customers = null,Object? needsYou = null,}) {
  return _then(_Insights(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as InsightsRange,bookedValueCents: null == bookedValueCents ? _self.bookedValueCents : bookedValueCents // ignore: cast_nullable_to_non_nullable
as Kpi,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as Kpi,utilisationPct: null == utilisationPct ? _self.utilisationPct : utilisationPct // ignore: cast_nullable_to_non_nullable
as Kpi,noShowRatePct: null == noShowRatePct ? _self.noShowRatePct : noShowRatePct // ignore: cast_nullable_to_non_nullable
as Kpi,bookedByDay: null == bookedByDay ? _self._bookedByDay : bookedByDay // ignore: cast_nullable_to_non_nullable
as List<DayPoint>,peakHours: null == peakHours ? _self._peakHours : peakHours // ignore: cast_nullable_to_non_nullable
as List<List<int>>,mix: null == mix ? _self.mix : mix // ignore: cast_nullable_to_non_nullable
as BookingMix,bySpace: null == bySpace ? _self._bySpace : bySpace // ignore: cast_nullable_to_non_nullable
as List<SpaceValue>,customers: null == customers ? _self.customers : customers // ignore: cast_nullable_to_non_nullable
as CustomerMix,needsYou: null == needsYou ? _self.needsYou : needsYou // ignore: cast_nullable_to_non_nullable
as NeedsYou,
  ));
}

/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpiCopyWith<$Res> get bookedValueCents {
  
  return $KpiCopyWith<$Res>(_self.bookedValueCents, (value) {
    return _then(_self.copyWith(bookedValueCents: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpiCopyWith<$Res> get bookings {
  
  return $KpiCopyWith<$Res>(_self.bookings, (value) {
    return _then(_self.copyWith(bookings: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpiCopyWith<$Res> get utilisationPct {
  
  return $KpiCopyWith<$Res>(_self.utilisationPct, (value) {
    return _then(_self.copyWith(utilisationPct: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpiCopyWith<$Res> get noShowRatePct {
  
  return $KpiCopyWith<$Res>(_self.noShowRatePct, (value) {
    return _then(_self.copyWith(noShowRatePct: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingMixCopyWith<$Res> get mix {
  
  return $BookingMixCopyWith<$Res>(_self.mix, (value) {
    return _then(_self.copyWith(mix: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerMixCopyWith<$Res> get customers {
  
  return $CustomerMixCopyWith<$Res>(_self.customers, (value) {
    return _then(_self.copyWith(customers: value));
  });
}/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NeedsYouCopyWith<$Res> get needsYou {
  
  return $NeedsYouCopyWith<$Res>(_self.needsYou, (value) {
    return _then(_self.copyWith(needsYou: value));
  });
}
}


/// @nodoc
mixin _$Kpi {

 num get value; num get previous;/// Null when there is no baseline — a jump from zero is not "+∞%", it is
/// simply the first of something.
 double? get deltaPct; List<num> get series;
/// Create a copy of Kpi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KpiCopyWith<Kpi> get copyWith => _$KpiCopyWithImpl<Kpi>(this as Kpi, _$identity);

  /// Serializes this Kpi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Kpi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Kpi&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.previous, _this.previous) || other.previous == _this.previous)&&(identical(other.deltaPct, _this.deltaPct) || other.deltaPct == _this.deltaPct)&&const DeepCollectionEquality().equals(other.series, _this.series));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Kpi;
  return Object.hash(runtimeType,_this.value,_this.previous,_this.deltaPct,const DeepCollectionEquality().hash(_this.series));
}

@override
String toString() {
  final _this = this as Kpi;
  return 'Kpi(value: ${_this.value}, previous: ${_this.previous}, deltaPct: ${_this.deltaPct}, series: ${_this.series})';
}


}

/// @nodoc
abstract mixin class $KpiCopyWith<$Res>  {
  factory $KpiCopyWith(Kpi value, $Res Function(Kpi) _then) = _$KpiCopyWithImpl;
@useResult
$Res call({
 num value, num previous, double? deltaPct, List<num> series
});




}
/// @nodoc
class _$KpiCopyWithImpl<$Res>
    implements $KpiCopyWith<$Res> {
  _$KpiCopyWithImpl(this._self, this._then);

  final Kpi _self;
  final $Res Function(Kpi) _then;

/// Create a copy of Kpi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? previous = null,Object? deltaPct = freezed,Object? series = null,}) {
  return _then(Kpi(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,previous: null == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as num,deltaPct: freezed == deltaPct ? _self.deltaPct : deltaPct // ignore: cast_nullable_to_non_nullable
as double?,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as List<num>,
  ));
}

}


/// Adds pattern-matching-related methods to [Kpi].
extension KpiPatterns on Kpi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Kpi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Kpi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Kpi value)  $default,){
final _that = this;
switch (_that) {
case _Kpi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Kpi value)?  $default,){
final _that = this;
switch (_that) {
case _Kpi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num value,  num previous,  double? deltaPct,  List<num> series)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Kpi() when $default != null:
return $default(_that.value,_that.previous,_that.deltaPct,_that.series);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num value,  num previous,  double? deltaPct,  List<num> series)  $default,) {final _that = this;
switch (_that) {
case _Kpi():
return $default(_that.value,_that.previous,_that.deltaPct,_that.series);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num value,  num previous,  double? deltaPct,  List<num> series)?  $default,) {final _that = this;
switch (_that) {
case _Kpi() when $default != null:
return $default(_that.value,_that.previous,_that.deltaPct,_that.series);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Kpi extends Kpi {
  const _Kpi({this.value = 0, this.previous = 0, this.deltaPct,  List<num> series = const <num>[]}): _series = series,super._();
  factory _Kpi.fromJson(Map<String, dynamic> json) => _$KpiFromJson(json);

@override@JsonKey() final  num value;
@override@JsonKey() final  num previous;
/// Null when there is no baseline — a jump from zero is not "+∞%", it is
/// simply the first of something.
@override final  double? deltaPct;
 final  List<num> _series;
@override@JsonKey() List<num> get series {
  if (_series is EqualUnmodifiableListView) return _series;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_series);
}


/// Create a copy of Kpi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KpiCopyWith<_Kpi> get copyWith => __$KpiCopyWithImpl<_Kpi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KpiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Kpi&&(identical(other.value, value) || other.value == value)&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.deltaPct, deltaPct) || other.deltaPct == deltaPct)&&const DeepCollectionEquality().equals(other.series, _series));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,value,previous,deltaPct,const DeepCollectionEquality().hash(_series));
}

@override
String toString() {
    return 'Kpi(value: $value, previous: $previous, deltaPct: $deltaPct, series: $series)';
}


}

/// @nodoc
abstract mixin class _$KpiCopyWith<$Res> implements $KpiCopyWith<$Res> {
  factory _$KpiCopyWith(_Kpi value, $Res Function(_Kpi) _then) = __$KpiCopyWithImpl;
@override @useResult
$Res call({
 num value, num previous, double? deltaPct, List<num> series
});




}
/// @nodoc
class __$KpiCopyWithImpl<$Res>
    implements _$KpiCopyWith<$Res> {
  __$KpiCopyWithImpl(this._self, this._then);

  final _Kpi _self;
  final $Res Function(_Kpi) _then;

/// Create a copy of Kpi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? previous = null,Object? deltaPct = freezed,Object? series = null,}) {
  return _then(_Kpi(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,previous: null == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as num,deltaPct: freezed == deltaPct ? _self.deltaPct : deltaPct // ignore: cast_nullable_to_non_nullable
as double?,series: null == series ? _self._series : series // ignore: cast_nullable_to_non_nullable
as List<num>,
  ));
}


}


/// @nodoc
mixin _$DayPoint {

/// Venue-local "YYYY-MM-DD".
 String get day; int get cents; double get utilisationPct;
/// Create a copy of DayPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayPointCopyWith<DayPoint> get copyWith => _$DayPointCopyWithImpl<DayPoint>(this as DayPoint, _$identity);

  /// Serializes this DayPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DayPoint;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayPoint&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.cents, _this.cents) || other.cents == _this.cents)&&(identical(other.utilisationPct, _this.utilisationPct) || other.utilisationPct == _this.utilisationPct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DayPoint;
  return Object.hash(runtimeType,_this.day,_this.cents,_this.utilisationPct);
}

@override
String toString() {
  final _this = this as DayPoint;
  return 'DayPoint(day: ${_this.day}, cents: ${_this.cents}, utilisationPct: ${_this.utilisationPct})';
}


}

/// @nodoc
abstract mixin class $DayPointCopyWith<$Res>  {
  factory $DayPointCopyWith(DayPoint value, $Res Function(DayPoint) _then) = _$DayPointCopyWithImpl;
@useResult
$Res call({
 String day, int cents, double utilisationPct
});




}
/// @nodoc
class _$DayPointCopyWithImpl<$Res>
    implements $DayPointCopyWith<$Res> {
  _$DayPointCopyWithImpl(this._self, this._then);

  final DayPoint _self;
  final $Res Function(DayPoint) _then;

/// Create a copy of DayPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? cents = null,Object? utilisationPct = null,}) {
  return _then(DayPoint(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,cents: null == cents ? _self.cents : cents // ignore: cast_nullable_to_non_nullable
as int,utilisationPct: null == utilisationPct ? _self.utilisationPct : utilisationPct // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DayPoint].
extension DayPointPatterns on DayPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayPoint value)  $default,){
final _that = this;
switch (_that) {
case _DayPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayPoint value)?  $default,){
final _that = this;
switch (_that) {
case _DayPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String day,  int cents,  double utilisationPct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayPoint() when $default != null:
return $default(_that.day,_that.cents,_that.utilisationPct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String day,  int cents,  double utilisationPct)  $default,) {final _that = this;
switch (_that) {
case _DayPoint():
return $default(_that.day,_that.cents,_that.utilisationPct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String day,  int cents,  double utilisationPct)?  $default,) {final _that = this;
switch (_that) {
case _DayPoint() when $default != null:
return $default(_that.day,_that.cents,_that.utilisationPct);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DayPoint implements DayPoint {
  const _DayPoint({required this.day, this.cents = 0, this.utilisationPct = 0});
  factory _DayPoint.fromJson(Map<String, dynamic> json) => _$DayPointFromJson(json);

/// Venue-local "YYYY-MM-DD".
@override final  String day;
@override@JsonKey() final  int cents;
@override@JsonKey() final  double utilisationPct;

/// Create a copy of DayPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayPointCopyWith<_DayPoint> get copyWith => __$DayPointCopyWithImpl<_DayPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DayPointToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayPoint&&(identical(other.day, day) || other.day == day)&&(identical(other.cents, cents) || other.cents == cents)&&(identical(other.utilisationPct, utilisationPct) || other.utilisationPct == utilisationPct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,day,cents,utilisationPct);
}

@override
String toString() {
    return 'DayPoint(day: $day, cents: $cents, utilisationPct: $utilisationPct)';
}


}

/// @nodoc
abstract mixin class _$DayPointCopyWith<$Res> implements $DayPointCopyWith<$Res> {
  factory _$DayPointCopyWith(_DayPoint value, $Res Function(_DayPoint) _then) = __$DayPointCopyWithImpl;
@override @useResult
$Res call({
 String day, int cents, double utilisationPct
});




}
/// @nodoc
class __$DayPointCopyWithImpl<$Res>
    implements _$DayPointCopyWith<$Res> {
  __$DayPointCopyWithImpl(this._self, this._then);

  final _DayPoint _self;
  final $Res Function(_DayPoint) _then;

/// Create a copy of DayPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? cents = null,Object? utilisationPct = null,}) {
  return _then(_DayPoint(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,cents: null == cents ? _self.cents : cents // ignore: cast_nullable_to_non_nullable
as int,utilisationPct: null == utilisationPct ? _self.utilisationPct : utilisationPct // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$BookingMix {

 int get confirmed; int get cancelled; int get noShow;
/// Create a copy of BookingMix
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingMixCopyWith<BookingMix> get copyWith => _$BookingMixCopyWithImpl<BookingMix>(this as BookingMix, _$identity);

  /// Serializes this BookingMix to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BookingMix;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingMix&&(identical(other.confirmed, _this.confirmed) || other.confirmed == _this.confirmed)&&(identical(other.cancelled, _this.cancelled) || other.cancelled == _this.cancelled)&&(identical(other.noShow, _this.noShow) || other.noShow == _this.noShow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BookingMix;
  return Object.hash(runtimeType,_this.confirmed,_this.cancelled,_this.noShow);
}

@override
String toString() {
  final _this = this as BookingMix;
  return 'BookingMix(confirmed: ${_this.confirmed}, cancelled: ${_this.cancelled}, noShow: ${_this.noShow})';
}


}

/// @nodoc
abstract mixin class $BookingMixCopyWith<$Res>  {
  factory $BookingMixCopyWith(BookingMix value, $Res Function(BookingMix) _then) = _$BookingMixCopyWithImpl;
@useResult
$Res call({
 int confirmed, int cancelled, int noShow
});




}
/// @nodoc
class _$BookingMixCopyWithImpl<$Res>
    implements $BookingMixCopyWith<$Res> {
  _$BookingMixCopyWithImpl(this._self, this._then);

  final BookingMix _self;
  final $Res Function(BookingMix) _then;

/// Create a copy of BookingMix
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? confirmed = null,Object? cancelled = null,Object? noShow = null,}) {
  return _then(BookingMix(
confirmed: null == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as int,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as int,noShow: null == noShow ? _self.noShow : noShow // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingMix].
extension BookingMixPatterns on BookingMix {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingMix value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingMix() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingMix value)  $default,){
final _that = this;
switch (_that) {
case _BookingMix():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingMix value)?  $default,){
final _that = this;
switch (_that) {
case _BookingMix() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int confirmed,  int cancelled,  int noShow)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingMix() when $default != null:
return $default(_that.confirmed,_that.cancelled,_that.noShow);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int confirmed,  int cancelled,  int noShow)  $default,) {final _that = this;
switch (_that) {
case _BookingMix():
return $default(_that.confirmed,_that.cancelled,_that.noShow);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int confirmed,  int cancelled,  int noShow)?  $default,) {final _that = this;
switch (_that) {
case _BookingMix() when $default != null:
return $default(_that.confirmed,_that.cancelled,_that.noShow);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingMix extends BookingMix {
  const _BookingMix({this.confirmed = 0, this.cancelled = 0, this.noShow = 0}): super._();
  factory _BookingMix.fromJson(Map<String, dynamic> json) => _$BookingMixFromJson(json);

@override@JsonKey() final  int confirmed;
@override@JsonKey() final  int cancelled;
@override@JsonKey() final  int noShow;

/// Create a copy of BookingMix
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingMixCopyWith<_BookingMix> get copyWith => __$BookingMixCopyWithImpl<_BookingMix>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingMixToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingMix&&(identical(other.confirmed, confirmed) || other.confirmed == confirmed)&&(identical(other.cancelled, cancelled) || other.cancelled == cancelled)&&(identical(other.noShow, noShow) || other.noShow == noShow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,confirmed,cancelled,noShow);
}

@override
String toString() {
    return 'BookingMix(confirmed: $confirmed, cancelled: $cancelled, noShow: $noShow)';
}


}

/// @nodoc
abstract mixin class _$BookingMixCopyWith<$Res> implements $BookingMixCopyWith<$Res> {
  factory _$BookingMixCopyWith(_BookingMix value, $Res Function(_BookingMix) _then) = __$BookingMixCopyWithImpl;
@override @useResult
$Res call({
 int confirmed, int cancelled, int noShow
});




}
/// @nodoc
class __$BookingMixCopyWithImpl<$Res>
    implements _$BookingMixCopyWith<$Res> {
  __$BookingMixCopyWithImpl(this._self, this._then);

  final _BookingMix _self;
  final $Res Function(_BookingMix) _then;

/// Create a copy of BookingMix
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? confirmed = null,Object? cancelled = null,Object? noShow = null,}) {
  return _then(_BookingMix(
confirmed: null == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as int,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as int,noShow: null == noShow ? _self.noShow : noShow // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SpaceValue {

 String get spaceId; String get name; int get cents;
/// Create a copy of SpaceValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpaceValueCopyWith<SpaceValue> get copyWith => _$SpaceValueCopyWithImpl<SpaceValue>(this as SpaceValue, _$identity);

  /// Serializes this SpaceValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpaceValue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpaceValue&&(identical(other.spaceId, _this.spaceId) || other.spaceId == _this.spaceId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.cents, _this.cents) || other.cents == _this.cents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpaceValue;
  return Object.hash(runtimeType,_this.spaceId,_this.name,_this.cents);
}

@override
String toString() {
  final _this = this as SpaceValue;
  return 'SpaceValue(spaceId: ${_this.spaceId}, name: ${_this.name}, cents: ${_this.cents})';
}


}

/// @nodoc
abstract mixin class $SpaceValueCopyWith<$Res>  {
  factory $SpaceValueCopyWith(SpaceValue value, $Res Function(SpaceValue) _then) = _$SpaceValueCopyWithImpl;
@useResult
$Res call({
 String spaceId, String name, int cents
});




}
/// @nodoc
class _$SpaceValueCopyWithImpl<$Res>
    implements $SpaceValueCopyWith<$Res> {
  _$SpaceValueCopyWithImpl(this._self, this._then);

  final SpaceValue _self;
  final $Res Function(SpaceValue) _then;

/// Create a copy of SpaceValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? spaceId = null,Object? name = null,Object? cents = null,}) {
  return _then(SpaceValue(
spaceId: null == spaceId ? _self.spaceId : spaceId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cents: null == cents ? _self.cents : cents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpaceValue].
extension SpaceValuePatterns on SpaceValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpaceValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpaceValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpaceValue value)  $default,){
final _that = this;
switch (_that) {
case _SpaceValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpaceValue value)?  $default,){
final _that = this;
switch (_that) {
case _SpaceValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String spaceId,  String name,  int cents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpaceValue() when $default != null:
return $default(_that.spaceId,_that.name,_that.cents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String spaceId,  String name,  int cents)  $default,) {final _that = this;
switch (_that) {
case _SpaceValue():
return $default(_that.spaceId,_that.name,_that.cents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String spaceId,  String name,  int cents)?  $default,) {final _that = this;
switch (_that) {
case _SpaceValue() when $default != null:
return $default(_that.spaceId,_that.name,_that.cents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpaceValue implements SpaceValue {
  const _SpaceValue({required this.spaceId, required this.name, this.cents = 0});
  factory _SpaceValue.fromJson(Map<String, dynamic> json) => _$SpaceValueFromJson(json);

@override final  String spaceId;
@override final  String name;
@override@JsonKey() final  int cents;

/// Create a copy of SpaceValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpaceValueCopyWith<_SpaceValue> get copyWith => __$SpaceValueCopyWithImpl<_SpaceValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpaceValueToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpaceValue&&(identical(other.spaceId, spaceId) || other.spaceId == spaceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.cents, cents) || other.cents == cents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,spaceId,name,cents);
}

@override
String toString() {
    return 'SpaceValue(spaceId: $spaceId, name: $name, cents: $cents)';
}


}

/// @nodoc
abstract mixin class _$SpaceValueCopyWith<$Res> implements $SpaceValueCopyWith<$Res> {
  factory _$SpaceValueCopyWith(_SpaceValue value, $Res Function(_SpaceValue) _then) = __$SpaceValueCopyWithImpl;
@override @useResult
$Res call({
 String spaceId, String name, int cents
});




}
/// @nodoc
class __$SpaceValueCopyWithImpl<$Res>
    implements _$SpaceValueCopyWith<$Res> {
  __$SpaceValueCopyWithImpl(this._self, this._then);

  final _SpaceValue _self;
  final $Res Function(_SpaceValue) _then;

/// Create a copy of SpaceValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? spaceId = null,Object? name = null,Object? cents = null,}) {
  return _then(_SpaceValue(
spaceId: null == spaceId ? _self.spaceId : spaceId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cents: null == cents ? _self.cents : cents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CustomerMix {

 int get newCount; int get returningCount; int get repeatRatePct; List<TopCustomer> get top;
/// Create a copy of CustomerMix
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerMixCopyWith<CustomerMix> get copyWith => _$CustomerMixCopyWithImpl<CustomerMix>(this as CustomerMix, _$identity);

  /// Serializes this CustomerMix to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomerMix;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerMix&&(identical(other.newCount, _this.newCount) || other.newCount == _this.newCount)&&(identical(other.returningCount, _this.returningCount) || other.returningCount == _this.returningCount)&&(identical(other.repeatRatePct, _this.repeatRatePct) || other.repeatRatePct == _this.repeatRatePct)&&const DeepCollectionEquality().equals(other.top, _this.top));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomerMix;
  return Object.hash(runtimeType,_this.newCount,_this.returningCount,_this.repeatRatePct,const DeepCollectionEquality().hash(_this.top));
}

@override
String toString() {
  final _this = this as CustomerMix;
  return 'CustomerMix(newCount: ${_this.newCount}, returningCount: ${_this.returningCount}, repeatRatePct: ${_this.repeatRatePct}, top: ${_this.top})';
}


}

/// @nodoc
abstract mixin class $CustomerMixCopyWith<$Res>  {
  factory $CustomerMixCopyWith(CustomerMix value, $Res Function(CustomerMix) _then) = _$CustomerMixCopyWithImpl;
@useResult
$Res call({
 int newCount, int returningCount, int repeatRatePct, List<TopCustomer> top
});




}
/// @nodoc
class _$CustomerMixCopyWithImpl<$Res>
    implements $CustomerMixCopyWith<$Res> {
  _$CustomerMixCopyWithImpl(this._self, this._then);

  final CustomerMix _self;
  final $Res Function(CustomerMix) _then;

/// Create a copy of CustomerMix
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? newCount = null,Object? returningCount = null,Object? repeatRatePct = null,Object? top = null,}) {
  return _then(CustomerMix(
newCount: null == newCount ? _self.newCount : newCount // ignore: cast_nullable_to_non_nullable
as int,returningCount: null == returningCount ? _self.returningCount : returningCount // ignore: cast_nullable_to_non_nullable
as int,repeatRatePct: null == repeatRatePct ? _self.repeatRatePct : repeatRatePct // ignore: cast_nullable_to_non_nullable
as int,top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as List<TopCustomer>,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerMix].
extension CustomerMixPatterns on CustomerMix {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerMix value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerMix() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerMix value)  $default,){
final _that = this;
switch (_that) {
case _CustomerMix():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerMix value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerMix() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int newCount,  int returningCount,  int repeatRatePct,  List<TopCustomer> top)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerMix() when $default != null:
return $default(_that.newCount,_that.returningCount,_that.repeatRatePct,_that.top);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int newCount,  int returningCount,  int repeatRatePct,  List<TopCustomer> top)  $default,) {final _that = this;
switch (_that) {
case _CustomerMix():
return $default(_that.newCount,_that.returningCount,_that.repeatRatePct,_that.top);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int newCount,  int returningCount,  int repeatRatePct,  List<TopCustomer> top)?  $default,) {final _that = this;
switch (_that) {
case _CustomerMix() when $default != null:
return $default(_that.newCount,_that.returningCount,_that.repeatRatePct,_that.top);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerMix implements CustomerMix {
  const _CustomerMix({this.newCount = 0, this.returningCount = 0, this.repeatRatePct = 0,  List<TopCustomer> top = const <TopCustomer>[]}): _top = top;
  factory _CustomerMix.fromJson(Map<String, dynamic> json) => _$CustomerMixFromJson(json);

@override@JsonKey() final  int newCount;
@override@JsonKey() final  int returningCount;
@override@JsonKey() final  int repeatRatePct;
 final  List<TopCustomer> _top;
@override@JsonKey() List<TopCustomer> get top {
  if (_top is EqualUnmodifiableListView) return _top;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_top);
}


/// Create a copy of CustomerMix
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerMixCopyWith<_CustomerMix> get copyWith => __$CustomerMixCopyWithImpl<_CustomerMix>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerMixToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerMix&&(identical(other.newCount, newCount) || other.newCount == newCount)&&(identical(other.returningCount, returningCount) || other.returningCount == returningCount)&&(identical(other.repeatRatePct, repeatRatePct) || other.repeatRatePct == repeatRatePct)&&const DeepCollectionEquality().equals(other.top, _top));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,newCount,returningCount,repeatRatePct,const DeepCollectionEquality().hash(_top));
}

@override
String toString() {
    return 'CustomerMix(newCount: $newCount, returningCount: $returningCount, repeatRatePct: $repeatRatePct, top: $top)';
}


}

/// @nodoc
abstract mixin class _$CustomerMixCopyWith<$Res> implements $CustomerMixCopyWith<$Res> {
  factory _$CustomerMixCopyWith(_CustomerMix value, $Res Function(_CustomerMix) _then) = __$CustomerMixCopyWithImpl;
@override @useResult
$Res call({
 int newCount, int returningCount, int repeatRatePct, List<TopCustomer> top
});




}
/// @nodoc
class __$CustomerMixCopyWithImpl<$Res>
    implements _$CustomerMixCopyWith<$Res> {
  __$CustomerMixCopyWithImpl(this._self, this._then);

  final _CustomerMix _self;
  final $Res Function(_CustomerMix) _then;

/// Create a copy of CustomerMix
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? newCount = null,Object? returningCount = null,Object? repeatRatePct = null,Object? top = null,}) {
  return _then(_CustomerMix(
newCount: null == newCount ? _self.newCount : newCount // ignore: cast_nullable_to_non_nullable
as int,returningCount: null == returningCount ? _self.returningCount : returningCount // ignore: cast_nullable_to_non_nullable
as int,repeatRatePct: null == repeatRatePct ? _self.repeatRatePct : repeatRatePct // ignore: cast_nullable_to_non_nullable
as int,top: null == top ? _self._top : top // ignore: cast_nullable_to_non_nullable
as List<TopCustomer>,
  ));
}


}


/// @nodoc
mixin _$TopCustomer {

 String get customerId; String get name; int get bookings;
/// Create a copy of TopCustomer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopCustomerCopyWith<TopCustomer> get copyWith => _$TopCustomerCopyWithImpl<TopCustomer>(this as TopCustomer, _$identity);

  /// Serializes this TopCustomer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TopCustomer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopCustomer&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.bookings, _this.bookings) || other.bookings == _this.bookings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TopCustomer;
  return Object.hash(runtimeType,_this.customerId,_this.name,_this.bookings);
}

@override
String toString() {
  final _this = this as TopCustomer;
  return 'TopCustomer(customerId: ${_this.customerId}, name: ${_this.name}, bookings: ${_this.bookings})';
}


}

/// @nodoc
abstract mixin class $TopCustomerCopyWith<$Res>  {
  factory $TopCustomerCopyWith(TopCustomer value, $Res Function(TopCustomer) _then) = _$TopCustomerCopyWithImpl;
@useResult
$Res call({
 String customerId, String name, int bookings
});




}
/// @nodoc
class _$TopCustomerCopyWithImpl<$Res>
    implements $TopCustomerCopyWith<$Res> {
  _$TopCustomerCopyWithImpl(this._self, this._then);

  final TopCustomer _self;
  final $Res Function(TopCustomer) _then;

/// Create a copy of TopCustomer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerId = null,Object? name = null,Object? bookings = null,}) {
  return _then(TopCustomer(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TopCustomer].
extension TopCustomerPatterns on TopCustomer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopCustomer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopCustomer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopCustomer value)  $default,){
final _that = this;
switch (_that) {
case _TopCustomer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopCustomer value)?  $default,){
final _that = this;
switch (_that) {
case _TopCustomer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String customerId,  String name,  int bookings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopCustomer() when $default != null:
return $default(_that.customerId,_that.name,_that.bookings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String customerId,  String name,  int bookings)  $default,) {final _that = this;
switch (_that) {
case _TopCustomer():
return $default(_that.customerId,_that.name,_that.bookings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String customerId,  String name,  int bookings)?  $default,) {final _that = this;
switch (_that) {
case _TopCustomer() when $default != null:
return $default(_that.customerId,_that.name,_that.bookings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopCustomer implements TopCustomer {
  const _TopCustomer({required this.customerId, required this.name, this.bookings = 0});
  factory _TopCustomer.fromJson(Map<String, dynamic> json) => _$TopCustomerFromJson(json);

@override final  String customerId;
@override final  String name;
@override@JsonKey() final  int bookings;

/// Create a copy of TopCustomer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopCustomerCopyWith<_TopCustomer> get copyWith => __$TopCustomerCopyWithImpl<_TopCustomer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopCustomerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopCustomer&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.bookings, bookings) || other.bookings == bookings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,customerId,name,bookings);
}

@override
String toString() {
    return 'TopCustomer(customerId: $customerId, name: $name, bookings: $bookings)';
}


}

/// @nodoc
abstract mixin class _$TopCustomerCopyWith<$Res> implements $TopCustomerCopyWith<$Res> {
  factory _$TopCustomerCopyWith(_TopCustomer value, $Res Function(_TopCustomer) _then) = __$TopCustomerCopyWithImpl;
@override @useResult
$Res call({
 String customerId, String name, int bookings
});




}
/// @nodoc
class __$TopCustomerCopyWithImpl<$Res>
    implements _$TopCustomerCopyWith<$Res> {
  __$TopCustomerCopyWithImpl(this._self, this._then);

  final _TopCustomer _self;
  final $Res Function(_TopCustomer) _then;

/// Create a copy of TopCustomer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? name = null,Object? bookings = null,}) {
  return _then(_TopCustomer(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$NeedsYou {

 int get toCheckIn; List<HalfEmptySession> get halfEmptySessions;
/// Create a copy of NeedsYou
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NeedsYouCopyWith<NeedsYou> get copyWith => _$NeedsYouCopyWithImpl<NeedsYou>(this as NeedsYou, _$identity);

  /// Serializes this NeedsYou to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NeedsYou;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NeedsYou&&(identical(other.toCheckIn, _this.toCheckIn) || other.toCheckIn == _this.toCheckIn)&&const DeepCollectionEquality().equals(other.halfEmptySessions, _this.halfEmptySessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NeedsYou;
  return Object.hash(runtimeType,_this.toCheckIn,const DeepCollectionEquality().hash(_this.halfEmptySessions));
}

@override
String toString() {
  final _this = this as NeedsYou;
  return 'NeedsYou(toCheckIn: ${_this.toCheckIn}, halfEmptySessions: ${_this.halfEmptySessions})';
}


}

/// @nodoc
abstract mixin class $NeedsYouCopyWith<$Res>  {
  factory $NeedsYouCopyWith(NeedsYou value, $Res Function(NeedsYou) _then) = _$NeedsYouCopyWithImpl;
@useResult
$Res call({
 int toCheckIn, List<HalfEmptySession> halfEmptySessions
});




}
/// @nodoc
class _$NeedsYouCopyWithImpl<$Res>
    implements $NeedsYouCopyWith<$Res> {
  _$NeedsYouCopyWithImpl(this._self, this._then);

  final NeedsYou _self;
  final $Res Function(NeedsYou) _then;

/// Create a copy of NeedsYou
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? toCheckIn = null,Object? halfEmptySessions = null,}) {
  return _then(NeedsYou(
toCheckIn: null == toCheckIn ? _self.toCheckIn : toCheckIn // ignore: cast_nullable_to_non_nullable
as int,halfEmptySessions: null == halfEmptySessions ? _self.halfEmptySessions : halfEmptySessions // ignore: cast_nullable_to_non_nullable
as List<HalfEmptySession>,
  ));
}

}


/// Adds pattern-matching-related methods to [NeedsYou].
extension NeedsYouPatterns on NeedsYou {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NeedsYou value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NeedsYou() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NeedsYou value)  $default,){
final _that = this;
switch (_that) {
case _NeedsYou():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NeedsYou value)?  $default,){
final _that = this;
switch (_that) {
case _NeedsYou() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int toCheckIn,  List<HalfEmptySession> halfEmptySessions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NeedsYou() when $default != null:
return $default(_that.toCheckIn,_that.halfEmptySessions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int toCheckIn,  List<HalfEmptySession> halfEmptySessions)  $default,) {final _that = this;
switch (_that) {
case _NeedsYou():
return $default(_that.toCheckIn,_that.halfEmptySessions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int toCheckIn,  List<HalfEmptySession> halfEmptySessions)?  $default,) {final _that = this;
switch (_that) {
case _NeedsYou() when $default != null:
return $default(_that.toCheckIn,_that.halfEmptySessions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NeedsYou extends NeedsYou {
  const _NeedsYou({this.toCheckIn = 0,  List<HalfEmptySession> halfEmptySessions = const <HalfEmptySession>[]}): _halfEmptySessions = halfEmptySessions,super._();
  factory _NeedsYou.fromJson(Map<String, dynamic> json) => _$NeedsYouFromJson(json);

@override@JsonKey() final  int toCheckIn;
 final  List<HalfEmptySession> _halfEmptySessions;
@override@JsonKey() List<HalfEmptySession> get halfEmptySessions {
  if (_halfEmptySessions is EqualUnmodifiableListView) return _halfEmptySessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_halfEmptySessions);
}


/// Create a copy of NeedsYou
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NeedsYouCopyWith<_NeedsYou> get copyWith => __$NeedsYouCopyWithImpl<_NeedsYou>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NeedsYouToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NeedsYou&&(identical(other.toCheckIn, toCheckIn) || other.toCheckIn == toCheckIn)&&const DeepCollectionEquality().equals(other.halfEmptySessions, _halfEmptySessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,toCheckIn,const DeepCollectionEquality().hash(_halfEmptySessions));
}

@override
String toString() {
    return 'NeedsYou(toCheckIn: $toCheckIn, halfEmptySessions: $halfEmptySessions)';
}


}

/// @nodoc
abstract mixin class _$NeedsYouCopyWith<$Res> implements $NeedsYouCopyWith<$Res> {
  factory _$NeedsYouCopyWith(_NeedsYou value, $Res Function(_NeedsYou) _then) = __$NeedsYouCopyWithImpl;
@override @useResult
$Res call({
 int toCheckIn, List<HalfEmptySession> halfEmptySessions
});




}
/// @nodoc
class __$NeedsYouCopyWithImpl<$Res>
    implements _$NeedsYouCopyWith<$Res> {
  __$NeedsYouCopyWithImpl(this._self, this._then);

  final _NeedsYou _self;
  final $Res Function(_NeedsYou) _then;

/// Create a copy of NeedsYou
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? toCheckIn = null,Object? halfEmptySessions = null,}) {
  return _then(_NeedsYou(
toCheckIn: null == toCheckIn ? _self.toCheckIn : toCheckIn // ignore: cast_nullable_to_non_nullable
as int,halfEmptySessions: null == halfEmptySessions ? _self._halfEmptySessions : halfEmptySessions // ignore: cast_nullable_to_non_nullable
as List<HalfEmptySession>,
  ));
}


}


/// @nodoc
mixin _$HalfEmptySession {

 String get id; String get title; DateTime get startsAt; int get spotsLeft; int get capacity;
/// Create a copy of HalfEmptySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HalfEmptySessionCopyWith<HalfEmptySession> get copyWith => _$HalfEmptySessionCopyWithImpl<HalfEmptySession>(this as HalfEmptySession, _$identity);

  /// Serializes this HalfEmptySession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HalfEmptySession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HalfEmptySession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.spotsLeft, _this.spotsLeft) || other.spotsLeft == _this.spotsLeft)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HalfEmptySession;
  return Object.hash(runtimeType,_this.id,_this.title,_this.startsAt,_this.spotsLeft,_this.capacity);
}

@override
String toString() {
  final _this = this as HalfEmptySession;
  return 'HalfEmptySession(id: ${_this.id}, title: ${_this.title}, startsAt: ${_this.startsAt}, spotsLeft: ${_this.spotsLeft}, capacity: ${_this.capacity})';
}


}

/// @nodoc
abstract mixin class $HalfEmptySessionCopyWith<$Res>  {
  factory $HalfEmptySessionCopyWith(HalfEmptySession value, $Res Function(HalfEmptySession) _then) = _$HalfEmptySessionCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime startsAt, int spotsLeft, int capacity
});




}
/// @nodoc
class _$HalfEmptySessionCopyWithImpl<$Res>
    implements $HalfEmptySessionCopyWith<$Res> {
  _$HalfEmptySessionCopyWithImpl(this._self, this._then);

  final HalfEmptySession _self;
  final $Res Function(HalfEmptySession) _then;

/// Create a copy of HalfEmptySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? spotsLeft = null,Object? capacity = null,}) {
  return _then(HalfEmptySession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,spotsLeft: null == spotsLeft ? _self.spotsLeft : spotsLeft // ignore: cast_nullable_to_non_nullable
as int,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HalfEmptySession].
extension HalfEmptySessionPatterns on HalfEmptySession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HalfEmptySession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HalfEmptySession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HalfEmptySession value)  $default,){
final _that = this;
switch (_that) {
case _HalfEmptySession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HalfEmptySession value)?  $default,){
final _that = this;
switch (_that) {
case _HalfEmptySession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsAt,  int spotsLeft,  int capacity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HalfEmptySession() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.spotsLeft,_that.capacity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsAt,  int spotsLeft,  int capacity)  $default,) {final _that = this;
switch (_that) {
case _HalfEmptySession():
return $default(_that.id,_that.title,_that.startsAt,_that.spotsLeft,_that.capacity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime startsAt,  int spotsLeft,  int capacity)?  $default,) {final _that = this;
switch (_that) {
case _HalfEmptySession() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.spotsLeft,_that.capacity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HalfEmptySession implements HalfEmptySession {
  const _HalfEmptySession({required this.id, required this.title, required this.startsAt, this.spotsLeft = 0, this.capacity = 0});
  factory _HalfEmptySession.fromJson(Map<String, dynamic> json) => _$HalfEmptySessionFromJson(json);

@override final  String id;
@override final  String title;
@override final  DateTime startsAt;
@override@JsonKey() final  int spotsLeft;
@override@JsonKey() final  int capacity;

/// Create a copy of HalfEmptySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HalfEmptySessionCopyWith<_HalfEmptySession> get copyWith => __$HalfEmptySessionCopyWithImpl<_HalfEmptySession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HalfEmptySessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HalfEmptySession&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.spotsLeft, spotsLeft) || other.spotsLeft == spotsLeft)&&(identical(other.capacity, capacity) || other.capacity == capacity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,startsAt,spotsLeft,capacity);
}

@override
String toString() {
    return 'HalfEmptySession(id: $id, title: $title, startsAt: $startsAt, spotsLeft: $spotsLeft, capacity: $capacity)';
}


}

/// @nodoc
abstract mixin class _$HalfEmptySessionCopyWith<$Res> implements $HalfEmptySessionCopyWith<$Res> {
  factory _$HalfEmptySessionCopyWith(_HalfEmptySession value, $Res Function(_HalfEmptySession) _then) = __$HalfEmptySessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime startsAt, int spotsLeft, int capacity
});




}
/// @nodoc
class __$HalfEmptySessionCopyWithImpl<$Res>
    implements _$HalfEmptySessionCopyWith<$Res> {
  __$HalfEmptySessionCopyWithImpl(this._self, this._then);

  final _HalfEmptySession _self;
  final $Res Function(_HalfEmptySession) _then;

/// Create a copy of HalfEmptySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? spotsLeft = null,Object? capacity = null,}) {
  return _then(_HalfEmptySession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,spotsLeft: null == spotsLeft ? _self.spotsLeft : spotsLeft // ignore: cast_nullable_to_non_nullable
as int,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
