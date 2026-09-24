// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Repository wiring for the venue side.

@ProviderFor(todayRepository)
final todayRepositoryProvider = TodayRepositoryProvider._();

/// Repository wiring for the venue side.

final class TodayRepositoryProvider
    extends
        $FunctionalProvider<TodayRepository, TodayRepository, TodayRepository>
    with $Provider<TodayRepository> {
  /// Repository wiring for the venue side.
  TodayRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayRepositoryHash();

  @$internal
  @override
  $ProviderElement<TodayRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodayRepository create(Ref ref) {
    return todayRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodayRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodayRepository>(value),
    );
  }
}

String _$todayRepositoryHash() => r'a4d73b28408465702bc56cb54314c3a7b0de6d0a';

@ProviderFor(calendarRepository)
final calendarRepositoryProvider = CalendarRepositoryProvider._();

final class CalendarRepositoryProvider
    extends
        $FunctionalProvider<
          CalendarRepository,
          CalendarRepository,
          CalendarRepository
        >
    with $Provider<CalendarRepository> {
  CalendarRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarRepositoryHash();

  @$internal
  @override
  $ProviderElement<CalendarRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CalendarRepository create(Ref ref) {
    return calendarRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarRepository>(value),
    );
  }
}

String _$calendarRepositoryHash() =>
    r'0ccdfe6d3f8dfa2f7489dd8dda55e15056f2e7bb';

@ProviderFor(customersRepository)
final customersRepositoryProvider = CustomersRepositoryProvider._();

final class CustomersRepositoryProvider
    extends
        $FunctionalProvider<
          CustomersRepository,
          CustomersRepository,
          CustomersRepository
        >
    with $Provider<CustomersRepository> {
  CustomersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customersRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customersRepositoryHash();

  @$internal
  @override
  $ProviderElement<CustomersRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CustomersRepository create(Ref ref) {
    return customersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomersRepository>(value),
    );
  }
}

String _$customersRepositoryHash() =>
    r'78c8669ade1c0fb95ca4c2d13f5655f65b81c8ea';

@ProviderFor(venueWaitlistRepository)
final venueWaitlistRepositoryProvider = VenueWaitlistRepositoryProvider._();

final class VenueWaitlistRepositoryProvider
    extends
        $FunctionalProvider<
          VenueWaitlistRepository,
          VenueWaitlistRepository,
          VenueWaitlistRepository
        >
    with $Provider<VenueWaitlistRepository> {
  VenueWaitlistRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'venueWaitlistRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$venueWaitlistRepositoryHash();

  @$internal
  @override
  $ProviderElement<VenueWaitlistRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VenueWaitlistRepository create(Ref ref) {
    return venueWaitlistRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VenueWaitlistRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VenueWaitlistRepository>(value),
    );
  }
}

String _$venueWaitlistRepositoryHash() =>
    r'79029403eb92ded64d1f4ed4bba13bf273bc1670';

@ProviderFor(spacesRepository)
final spacesRepositoryProvider = SpacesRepositoryProvider._();

final class SpacesRepositoryProvider
    extends
        $FunctionalProvider<
          SpacesRepository,
          SpacesRepository,
          SpacesRepository
        >
    with $Provider<SpacesRepository> {
  SpacesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spacesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spacesRepositoryHash();

  @$internal
  @override
  $ProviderElement<SpacesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SpacesRepository create(Ref ref) {
    return spacesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpacesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpacesRepository>(value),
    );
  }
}

String _$spacesRepositoryHash() => r'9943b4d9130c71dc9cd0c251508104f08080ae56';
