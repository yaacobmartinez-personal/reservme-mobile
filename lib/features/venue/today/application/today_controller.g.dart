// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// V4 · Today. Fetches the run sheet, caches it, and falls back to that cache
/// when the desk's connection drops — a venue must still be able to read the
/// day's bookings when the wifi goes.
///
/// A 403 or 404 is a real error (wrong venue, membership revoked) and is not
/// papered over with stale data.

@ProviderFor(Today)
final todayProvider = TodayFamily._();

/// V4 · Today. Fetches the run sheet, caches it, and falls back to that cache
/// when the desk's connection drops — a venue must still be able to read the
/// day's bookings when the wifi goes.
///
/// A 403 or 404 is a real error (wrong venue, membership revoked) and is not
/// papered over with stale data.
final class TodayProvider extends $AsyncNotifierProvider<Today, TodayState> {
  /// V4 · Today. Fetches the run sheet, caches it, and falls back to that cache
  /// when the desk's connection drops — a venue must still be able to read the
  /// day's bookings when the wifi goes.
  ///
  /// A 403 or 404 is a real error (wrong venue, membership revoked) and is not
  /// papered over with stale data.
  TodayProvider._({
    required TodayFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'todayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$todayHash();

  @override
  String toString() {
    return r'todayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Today create() => Today();

  @override
  bool operator ==(Object other) {
    return other is TodayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$todayHash() => r'1b66d155da1e31e9e500e24d7d984bca238dba18';

/// V4 · Today. Fetches the run sheet, caches it, and falls back to that cache
/// when the desk's connection drops — a venue must still be able to read the
/// day's bookings when the wifi goes.
///
/// A 403 or 404 is a real error (wrong venue, membership revoked) and is not
/// papered over with stale data.

final class TodayFamily extends $Family
    with
        $ClassFamilyOverride<
          Today,
          AsyncValue<TodayState>,
          TodayState,
          FutureOr<TodayState>,
          String
        > {
  TodayFamily._()
    : super(
        retry: null,
        name: r'todayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// V4 · Today. Fetches the run sheet, caches it, and falls back to that cache
  /// when the desk's connection drops — a venue must still be able to read the
  /// day's bookings when the wifi goes.
  ///
  /// A 403 or 404 is a real error (wrong venue, membership revoked) and is not
  /// papered over with stale data.

  TodayProvider call(String venueSlug) =>
      TodayProvider._(argument: venueSlug, from: this);

  @override
  String toString() => r'todayProvider';
}

/// V4 · Today. Fetches the run sheet, caches it, and falls back to that cache
/// when the desk's connection drops — a venue must still be able to read the
/// day's bookings when the wifi goes.
///
/// A 403 or 404 is a real error (wrong venue, membership revoked) and is not
/// papered over with stale data.

abstract class _$Today extends $AsyncNotifier<TodayState> {
  late final _$args = ref.$arg as String;
  String get venueSlug => _$args;

  FutureOr<TodayState> build(String venueSlug);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TodayState>, TodayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TodayState>, TodayState>,
              AsyncValue<TodayState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
