// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reschedule_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Open slots on the same space over the next week (API-CONTRACT #7).

@ProviderFor(rescheduleOptions)
final rescheduleOptionsProvider = RescheduleOptionsFamily._();

/// Open slots on the same space over the next week (API-CONTRACT #7).

final class RescheduleOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RescheduleDay>>,
          List<RescheduleDay>,
          FutureOr<List<RescheduleDay>>
        >
    with
        $FutureModifier<List<RescheduleDay>>,
        $FutureProvider<List<RescheduleDay>> {
  /// Open slots on the same space over the next week (API-CONTRACT #7).
  RescheduleOptionsProvider._({
    required RescheduleOptionsFamily super.from,
    required ({String venueSlug, String token}) super.argument,
  }) : super(
         retry: null,
         name: r'rescheduleOptionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rescheduleOptionsHash();

  @override
  String toString() {
    return r'rescheduleOptionsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<RescheduleDay>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RescheduleDay>> create(Ref ref) {
    final argument = this.argument as ({String venueSlug, String token});
    return rescheduleOptions(
      ref,
      venueSlug: argument.venueSlug,
      token: argument.token,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RescheduleOptionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rescheduleOptionsHash() => r'8b157a9409f6697f31bcc3eb6ac62b5ad49938d3';

/// Open slots on the same space over the next week (API-CONTRACT #7).

final class RescheduleOptionsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<RescheduleDay>>,
          ({String venueSlug, String token})
        > {
  RescheduleOptionsFamily._()
    : super(
        retry: null,
        name: r'rescheduleOptionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Open slots on the same space over the next week (API-CONTRACT #7).

  RescheduleOptionsProvider call({
    required String venueSlug,
    required String token,
  }) => RescheduleOptionsProvider._(
    argument: (venueSlug: venueSlug, token: token),
    from: this,
  );

  @override
  String toString() => r'rescheduleOptionsProvider';
}

/// Moves a booking to another slot and updates the wallet copy.

@ProviderFor(RescheduleController)
final rescheduleControllerProvider = RescheduleControllerProvider._();

/// Moves a booking to another slot and updates the wallet copy.
final class RescheduleControllerProvider
    extends $AsyncNotifierProvider<RescheduleController, RescheduleOutcome?> {
  /// Moves a booking to another slot and updates the wallet copy.
  RescheduleControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rescheduleControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rescheduleControllerHash();

  @$internal
  @override
  RescheduleController create() => RescheduleController();
}

String _$rescheduleControllerHash() =>
    r'3c9302caedea190b84d79dba4b0418acb83acc93';

/// Moves a booking to another slot and updates the wallet copy.

abstract class _$RescheduleController
    extends $AsyncNotifier<RescheduleOutcome?> {
  FutureOr<RescheduleOutcome?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<RescheduleOutcome?>, RescheduleOutcome?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RescheduleOutcome?>, RescheduleOutcome?>,
              AsyncValue<RescheduleOutcome?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Joining the waitlist for a slot that is already taken (API-CONTRACT #9).

@ProviderFor(WaitlistController)
final waitlistControllerProvider = WaitlistControllerProvider._();

/// Joining the waitlist for a slot that is already taken (API-CONTRACT #9).
final class WaitlistControllerProvider
    extends $AsyncNotifierProvider<WaitlistController, bool> {
  /// Joining the waitlist for a slot that is already taken (API-CONTRACT #9).
  WaitlistControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'waitlistControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$waitlistControllerHash();

  @$internal
  @override
  WaitlistController create() => WaitlistController();
}

String _$waitlistControllerHash() =>
    r'50f8c207ad4b0d64542f15511f66c0411714092e';

/// Joining the waitlist for a slot that is already taken (API-CONTRACT #9).

abstract class _$WaitlistController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
