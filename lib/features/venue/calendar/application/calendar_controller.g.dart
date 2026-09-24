// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// V7 · Calendar. Same cached-read shape as Today: a day that was fetched
/// successfully is kept, and shown with a stale marker when the connection
/// drops. Each date gets its own cache key, so yesterday's grid does not get
/// served for today.

@ProviderFor(Calendar)
final calendarProvider = CalendarFamily._();

/// V7 · Calendar. Same cached-read shape as Today: a day that was fetched
/// successfully is kept, and shown with a stale marker when the connection
/// drops. Each date gets its own cache key, so yesterday's grid does not get
/// served for today.
final class CalendarProvider
    extends $AsyncNotifierProvider<Calendar, CalendarState> {
  /// V7 · Calendar. Same cached-read shape as Today: a day that was fetched
  /// successfully is kept, and shown with a stale marker when the connection
  /// drops. Each date gets its own cache key, so yesterday's grid does not get
  /// served for today.
  CalendarProvider._({
    required CalendarFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'calendarProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$calendarHash();

  @override
  String toString() {
    return r'calendarProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  Calendar create() => Calendar();

  @override
  bool operator ==(Object other) {
    return other is CalendarProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$calendarHash() => r'8970d09060822130fd4658a3de08e11938c305c8';

/// V7 · Calendar. Same cached-read shape as Today: a day that was fetched
/// successfully is kept, and shown with a stale marker when the connection
/// drops. Each date gets its own cache key, so yesterday's grid does not get
/// served for today.

final class CalendarFamily extends $Family
    with
        $ClassFamilyOverride<
          Calendar,
          AsyncValue<CalendarState>,
          CalendarState,
          FutureOr<CalendarState>,
          (String, String)
        > {
  CalendarFamily._()
    : super(
        retry: null,
        name: r'calendarProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// V7 · Calendar. Same cached-read shape as Today: a day that was fetched
  /// successfully is kept, and shown with a stale marker when the connection
  /// drops. Each date gets its own cache key, so yesterday's grid does not get
  /// served for today.

  CalendarProvider call(String venueSlug, String date) =>
      CalendarProvider._(argument: (venueSlug, date), from: this);

  @override
  String toString() => r'calendarProvider';
}

/// V7 · Calendar. Same cached-read shape as Today: a day that was fetched
/// successfully is kept, and shown with a stale marker when the connection
/// drops. Each date gets its own cache key, so yesterday's grid does not get
/// served for today.

abstract class _$Calendar extends $AsyncNotifier<CalendarState> {
  late final _$args = ref.$arg as (String, String);
  String get venueSlug => _$args.$1;
  String get date => _$args.$2;

  FutureOr<CalendarState> build(String venueSlug, String date);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CalendarState>, CalendarState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CalendarState>, CalendarState>,
              AsyncValue<CalendarState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
