// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insights_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// G5 · Insights. Keyed by range, so switching period keeps the previous
/// window's answer on screen while the new one loads.

@ProviderFor(insights)
final insightsProvider = InsightsFamily._();

/// G5 · Insights. Keyed by range, so switching period keeps the previous
/// window's answer on screen while the new one loads.

final class InsightsProvider
    extends
        $FunctionalProvider<AsyncValue<Insights>, Insights, FutureOr<Insights>>
    with $FutureModifier<Insights>, $FutureProvider<Insights> {
  /// G5 · Insights. Keyed by range, so switching period keeps the previous
  /// window's answer on screen while the new one loads.
  InsightsProvider._({
    required InsightsFamily super.from,
    required (String, InsightsRange) super.argument,
  }) : super(
         retry: null,
         name: r'insightsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$insightsHash();

  @override
  String toString() {
    return r'insightsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Insights> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Insights> create(Ref ref) {
    final argument = this.argument as (String, InsightsRange);
    return insights(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is InsightsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$insightsHash() => r'84d2fa3496947829320f18cab18956cdb0bbf7f2';

/// G5 · Insights. Keyed by range, so switching period keeps the previous
/// window's answer on screen while the new one loads.

final class InsightsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<Insights>, (String, InsightsRange)> {
  InsightsFamily._()
    : super(
        retry: null,
        name: r'insightsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// G5 · Insights. Keyed by range, so switching period keeps the previous
  /// window's answer on screen while the new one loads.

  InsightsProvider call(String venueSlug, InsightsRange range) =>
      InsightsProvider._(argument: (venueSlug, range), from: this);

  @override
  String toString() => r'insightsProvider';
}

/// The period the owner last looked at, so the screen reopens on it.

@ProviderFor(InsightsRangeController)
final insightsRangeControllerProvider = InsightsRangeControllerProvider._();

/// The period the owner last looked at, so the screen reopens on it.
final class InsightsRangeControllerProvider
    extends $NotifierProvider<InsightsRangeController, InsightsRange> {
  /// The period the owner last looked at, so the screen reopens on it.
  InsightsRangeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'insightsRangeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$insightsRangeControllerHash();

  @$internal
  @override
  InsightsRangeController create() => InsightsRangeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InsightsRange value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InsightsRange>(value),
    );
  }
}

String _$insightsRangeControllerHash() =>
    r'df63a9c9d671d9e7c6fdaf5081f1bf95eb94d2ad';

/// The period the owner last looked at, so the screen reopens on it.

abstract class _$InsightsRangeController extends $Notifier<InsightsRange> {
  InsightsRange build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<InsightsRange, InsightsRange>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<InsightsRange, InsightsRange>,
              InsightsRange,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
