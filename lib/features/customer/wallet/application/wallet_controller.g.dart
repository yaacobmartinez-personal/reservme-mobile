// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Everything saved on this phone, split into upcoming and past.

@ProviderFor(wallet)
final walletProvider = WalletProvider._();

/// Everything saved on this phone, split into upcoming and past.

final class WalletProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Booking>>,
          List<Booking>,
          Stream<List<Booking>>
        >
    with $FutureModifier<List<Booking>>, $StreamProvider<List<Booking>> {
  /// Everything saved on this phone, split into upcoming and past.
  WalletProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walletProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$walletHash();

  @$internal
  @override
  $StreamProviderElement<List<Booking>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Booking>> create(Ref ref) {
    return wallet(ref);
  }
}

String _$walletHash() => r'3f8b5082e0f6c745410fc2e15fc21194120db9c2';

/// One booking. The saved snapshot renders immediately; a refresh from the
/// server follows and updates the row. Offline, the snapshot is all there is
/// and the screen says when it was last checked.

@ProviderFor(BookingDetail)
final bookingDetailProvider = BookingDetailFamily._();

/// One booking. The saved snapshot renders immediately; a refresh from the
/// server follows and updates the row. Offline, the snapshot is all there is
/// and the screen says when it was last checked.
final class BookingDetailProvider
    extends $AsyncNotifierProvider<BookingDetail, BookingView> {
  /// One booking. The saved snapshot renders immediately; a refresh from the
  /// server follows and updates the row. Offline, the snapshot is all there is
  /// and the screen says when it was last checked.
  BookingDetailProvider._({
    required BookingDetailFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'bookingDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookingDetailHash();

  @override
  String toString() {
    return r'bookingDetailProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  BookingDetail create() => BookingDetail();

  @override
  bool operator ==(Object other) {
    return other is BookingDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookingDetailHash() => r'8b1b89024e8c5a0b8686204c7aeccfcfa51f19ef';

/// One booking. The saved snapshot renders immediately; a refresh from the
/// server follows and updates the row. Offline, the snapshot is all there is
/// and the screen says when it was last checked.

final class BookingDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          BookingDetail,
          AsyncValue<BookingView>,
          BookingView,
          FutureOr<BookingView>,
          (String, String)
        > {
  BookingDetailFamily._()
    : super(
        retry: null,
        name: r'bookingDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One booking. The saved snapshot renders immediately; a refresh from the
  /// server follows and updates the row. Offline, the snapshot is all there is
  /// and the screen says when it was last checked.

  BookingDetailProvider call(String venueSlug, String token) =>
      BookingDetailProvider._(argument: (venueSlug, token), from: this);

  @override
  String toString() => r'bookingDetailProvider';
}

/// One booking. The saved snapshot renders immediately; a refresh from the
/// server follows and updates the row. Offline, the snapshot is all there is
/// and the screen says when it was last checked.

abstract class _$BookingDetail extends $AsyncNotifier<BookingView> {
  late final _$args = ref.$arg as (String, String);
  String get venueSlug => _$args.$1;
  String get token => _$args.$2;

  FutureOr<BookingView> build(String venueSlug, String token);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BookingView>, BookingView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BookingView>, BookingView>,
              AsyncValue<BookingView>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

/// Saves a booking opened from a manage link into the wallet (the deep-link
/// import, C11).

@ProviderFor(ImportBooking)
final importBookingProvider = ImportBookingProvider._();

/// Saves a booking opened from a manage link into the wallet (the deep-link
/// import, C11).
final class ImportBookingProvider
    extends $AsyncNotifierProvider<ImportBooking, Booking?> {
  /// Saves a booking opened from a manage link into the wallet (the deep-link
  /// import, C11).
  ImportBookingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'importBookingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$importBookingHash();

  @$internal
  @override
  ImportBooking create() => ImportBooking();
}

String _$importBookingHash() => r'86fb15e36b4228c1524d611a44c66b9749fd5241';

/// Saves a booking opened from a manage link into the wallet (the deep-link
/// import, C11).

abstract class _$ImportBooking extends $AsyncNotifier<Booking?> {
  FutureOr<Booking?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Booking?>, Booking?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Booking?>, Booking?>,
              AsyncValue<Booking?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
