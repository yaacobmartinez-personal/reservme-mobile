// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Which venue-local date the slot picker is showing. Defaults to today in
/// the venue's zone — not the phone's.

@ProviderFor(SelectedDate)
final selectedDateProvider = SelectedDateFamily._();

/// Which venue-local date the slot picker is showing. Defaults to today in
/// the venue's zone — not the phone's.
final class SelectedDateProvider
    extends $NotifierProvider<SelectedDate, String> {
  /// Which venue-local date the slot picker is showing. Defaults to today in
  /// the venue's zone — not the phone's.
  SelectedDateProvider._({
    required SelectedDateFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'selectedDateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedDateHash();

  @override
  String toString() {
    return r'selectedDateProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SelectedDate create() => SelectedDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedDateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedDateHash() => r'a1257b238337fc0a4e3709330865f7696c97fc16';

/// Which venue-local date the slot picker is showing. Defaults to today in
/// the venue's zone — not the phone's.

final class SelectedDateFamily extends $Family
    with
        $ClassFamilyOverride<
          SelectedDate,
          String,
          String,
          String,
          (String, String)
        > {
  SelectedDateFamily._()
    : super(
        retry: null,
        name: r'selectedDateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Which venue-local date the slot picker is showing. Defaults to today in
  /// the venue's zone — not the phone's.

  SelectedDateProvider call(String venueSlug, String timezone) =>
      SelectedDateProvider._(argument: (venueSlug, timezone), from: this);

  @override
  String toString() => r'selectedDateProvider';
}

/// Which venue-local date the slot picker is showing. Defaults to today in
/// the venue's zone — not the phone's.

abstract class _$SelectedDate extends $Notifier<String> {
  late final _$args = ref.$arg as (String, String);
  String get venueSlug => _$args.$1;
  String get timezone => _$args.$2;

  String build(String venueSlug, String timezone);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

/// Slots and sessions for one space on one date.

@ProviderFor(availability)
final availabilityProvider = AvailabilityFamily._();

/// Slots and sessions for one space on one date.

final class AvailabilityProvider
    extends
        $FunctionalProvider<
          AsyncValue<DayAvailability>,
          DayAvailability,
          FutureOr<DayAvailability>
        >
    with $FutureModifier<DayAvailability>, $FutureProvider<DayAvailability> {
  /// Slots and sessions for one space on one date.
  AvailabilityProvider._({
    required AvailabilityFamily super.from,
    required ({String venueSlug, String spaceId, String date}) super.argument,
  }) : super(
         retry: null,
         name: r'availabilityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$availabilityHash();

  @override
  String toString() {
    return r'availabilityProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<DayAvailability> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DayAvailability> create(Ref ref) {
    final argument =
        this.argument as ({String venueSlug, String spaceId, String date});
    return availability(
      ref,
      venueSlug: argument.venueSlug,
      spaceId: argument.spaceId,
      date: argument.date,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AvailabilityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$availabilityHash() => r'4f71d0953830e33516c9edfb142a100c3a7028d3';

/// Slots and sessions for one space on one date.

final class AvailabilityFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<DayAvailability>,
          ({String venueSlug, String spaceId, String date})
        > {
  AvailabilityFamily._()
    : super(
        retry: null,
        name: r'availabilityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Slots and sessions for one space on one date.

  AvailabilityProvider call({
    required String venueSlug,
    required String spaceId,
    required String date,
  }) => AvailabilityProvider._(
    argument: (venueSlug: venueSlug, spaceId: spaceId, date: date),
    from: this,
  );

  @override
  String toString() => r'availabilityProvider';
}

/// The dates the strip offers: today through the venue's booking horizon,
/// capped so the strip stays a strip.

@ProviderFor(bookableDates)
final bookableDatesProvider = BookableDatesFamily._();

/// The dates the strip offers: today through the venue's booking horizon,
/// capped so the strip stays a strip.

final class BookableDatesProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  /// The dates the strip offers: today through the venue's booking horizon,
  /// capped so the strip stays a strip.
  BookableDatesProvider._({
    required BookableDatesFamily super.from,
    required ({String timezone, int horizonDays, int limit}) super.argument,
  }) : super(
         retry: null,
         name: r'bookableDatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookableDatesHash();

  @override
  String toString() {
    return r'bookableDatesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    final argument =
        this.argument as ({String timezone, int horizonDays, int limit});
    return bookableDates(
      ref,
      timezone: argument.timezone,
      horizonDays: argument.horizonDays,
      limit: argument.limit,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BookableDatesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookableDatesHash() => r'ab28255d4c2ae1dadc4c317048fbe938318790f5';

/// The dates the strip offers: today through the venue's booking horizon,
/// capped so the strip stays a strip.

final class BookableDatesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          List<String>,
          ({String timezone, int horizonDays, int limit})
        > {
  BookableDatesFamily._()
    : super(
        retry: null,
        name: r'bookableDatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The dates the strip offers: today through the venue's booking horizon,
  /// capped so the strip stays a strip.

  BookableDatesProvider call({
    required String timezone,
    required int horizonDays,
    int limit = 14,
  }) => BookableDatesProvider._(
    argument: (timezone: timezone, horizonDays: horizonDays, limit: limit),
    from: this,
  );

  @override
  String toString() => r'bookableDatesProvider';
}
