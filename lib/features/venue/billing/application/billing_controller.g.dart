// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// G4 · Billing. The read is cheap and the band moves whenever a space is
/// paused, so the screen always refetches rather than trusting what it had.

@ProviderFor(BillingController)
final billingControllerProvider = BillingControllerFamily._();

/// G4 · Billing. The read is cheap and the band moves whenever a space is
/// paused, so the screen always refetches rather than trusting what it had.
final class BillingControllerProvider
    extends $AsyncNotifierProvider<BillingController, Billing> {
  /// G4 · Billing. The read is cheap and the band moves whenever a space is
  /// paused, so the screen always refetches rather than trusting what it had.
  BillingControllerProvider._({
    required BillingControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'billingControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$billingControllerHash();

  @override
  String toString() {
    return r'billingControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BillingController create() => BillingController();

  @override
  bool operator ==(Object other) {
    return other is BillingControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$billingControllerHash() => r'a6d67f6d211864657099ed43bb145799b05b2ece';

/// G4 · Billing. The read is cheap and the band moves whenever a space is
/// paused, so the screen always refetches rather than trusting what it had.

final class BillingControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BillingController,
          AsyncValue<Billing>,
          Billing,
          FutureOr<Billing>,
          String
        > {
  BillingControllerFamily._()
    : super(
        retry: null,
        name: r'billingControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// G4 · Billing. The read is cheap and the band moves whenever a space is
  /// paused, so the screen always refetches rather than trusting what it had.

  BillingControllerProvider call(String venueSlug) =>
      BillingControllerProvider._(argument: venueSlug, from: this);

  @override
  String toString() => r'billingControllerProvider';
}

/// G4 · Billing. The read is cheap and the band moves whenever a space is
/// paused, so the screen always refetches rather than trusting what it had.

abstract class _$BillingController extends $AsyncNotifier<Billing> {
  late final _$args = ref.$arg as String;
  String get venueSlug => _$args;

  FutureOr<Billing> build(String venueSlug);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Billing>, Billing>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Billing>, Billing>,
              AsyncValue<Billing>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
