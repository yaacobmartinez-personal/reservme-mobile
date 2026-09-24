// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_commands.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The calendar's writes. Each one refreshes the day it touched — a booking
/// changes the grid, and a move can change two days at once.
///
/// `keepAlive` because these are invoked with `ref.read` from a button: an
/// auto-dispose notifier is gone before the future completes.

@ProviderFor(CalendarCommands)
final calendarCommandsProvider = CalendarCommandsProvider._();

/// The calendar's writes. Each one refreshes the day it touched — a booking
/// changes the grid, and a move can change two days at once.
///
/// `keepAlive` because these are invoked with `ref.read` from a button: an
/// auto-dispose notifier is gone before the future completes.
final class CalendarCommandsProvider
    extends $NotifierProvider<CalendarCommands, void> {
  /// The calendar's writes. Each one refreshes the day it touched — a booking
  /// changes the grid, and a move can change two days at once.
  ///
  /// `keepAlive` because these are invoked with `ref.read` from a button: an
  /// auto-dispose notifier is gone before the future completes.
  CalendarCommandsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarCommandsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarCommandsHash();

  @$internal
  @override
  CalendarCommands create() => CalendarCommands();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$calendarCommandsHash() => r'35e21ce6673e10343c396a413674742303334a15';

/// The calendar's writes. Each one refreshes the day it touched — a booking
/// changes the grid, and a move can change two days at once.
///
/// `keepAlive` because these are invoked with `ref.read` from a button: an
/// auto-dispose notifier is gone before the future completes.

abstract class _$CalendarCommands extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Typeahead for the booking sheet (API-CONTRACT #20). Debounced by the
/// widget; this just asks.

@ProviderFor(customerSearch)
final customerSearchProvider = CustomerSearchFamily._();

/// Typeahead for the booking sheet (API-CONTRACT #20). Debounced by the
/// widget; this just asks.

final class CustomerSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CustomerHit>>,
          List<CustomerHit>,
          FutureOr<List<CustomerHit>>
        >
    with
        $FutureModifier<List<CustomerHit>>,
        $FutureProvider<List<CustomerHit>> {
  /// Typeahead for the booking sheet (API-CONTRACT #20). Debounced by the
  /// widget; this just asks.
  CustomerSearchProvider._({
    required CustomerSearchFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'customerSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerSearchHash();

  @override
  String toString() {
    return r'customerSearchProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<CustomerHit>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CustomerHit>> create(Ref ref) {
    final argument = this.argument as (String, String);
    return customerSearch(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerSearchHash() => r'32a309673c8a253f7ca382af5e733cba0748893c';

/// Typeahead for the booking sheet (API-CONTRACT #20). Debounced by the
/// widget; this just asks.

final class CustomerSearchFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<CustomerHit>>,
          (String, String)
        > {
  CustomerSearchFamily._()
    : super(
        retry: null,
        name: r'customerSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Typeahead for the booking sheet (API-CONTRACT #20). Debounced by the
  /// widget; this just asks.

  CustomerSearchProvider call(String venueSlug, String query) =>
      CustomerSearchProvider._(argument: (venueSlug, query), from: this);

  @override
  String toString() => r'customerSearchProvider';
}
