// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Repository wiring for the customer side. Each one is a `switch` over the
/// build's [ApiMode]; tests override the provider itself.

@ProviderFor(venuesRepository)
final venuesRepositoryProvider = VenuesRepositoryProvider._();

/// Repository wiring for the customer side. Each one is a `switch` over the
/// build's [ApiMode]; tests override the provider itself.

final class VenuesRepositoryProvider
    extends
        $FunctionalProvider<
          VenuesRepository,
          VenuesRepository,
          VenuesRepository
        >
    with $Provider<VenuesRepository> {
  /// Repository wiring for the customer side. Each one is a `switch` over the
  /// build's [ApiMode]; tests override the provider itself.
  VenuesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'venuesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$venuesRepositoryHash();

  @$internal
  @override
  $ProviderElement<VenuesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VenuesRepository create(Ref ref) {
    return venuesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VenuesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VenuesRepository>(value),
    );
  }
}

String _$venuesRepositoryHash() => r'd1ba918dc92c1f32327ec40b55a137f851a7d89c';

@ProviderFor(bookingRepository)
final bookingRepositoryProvider = BookingRepositoryProvider._();

final class BookingRepositoryProvider
    extends
        $FunctionalProvider<
          BookingRepository,
          BookingRepository,
          BookingRepository
        >
    with $Provider<BookingRepository> {
  BookingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookingRepository create(Ref ref) {
    return bookingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingRepository>(value),
    );
  }
}

String _$bookingRepositoryHash() => r'c8cf27a9f774b3e545008180618a4c03333b8a94';

@ProviderFor(manageRepository)
final manageRepositoryProvider = ManageRepositoryProvider._();

final class ManageRepositoryProvider
    extends
        $FunctionalProvider<
          ManageRepository,
          ManageRepository,
          ManageRepository
        >
    with $Provider<ManageRepository> {
  ManageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'manageRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$manageRepositoryHash();

  @$internal
  @override
  $ProviderElement<ManageRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ManageRepository create(Ref ref) {
    return manageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ManageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ManageRepository>(value),
    );
  }
}

String _$manageRepositoryHash() => r'ecd1e7aa419947335845e23922e89cfc08d5d9b4';
