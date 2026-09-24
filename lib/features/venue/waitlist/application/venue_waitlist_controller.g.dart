// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_waitlist_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// V13 · Waitlist — read-only in v1. The auto-fill that offers a freed slot
/// runs on the server; the venue watches the queue.

@ProviderFor(venueWaitlist)
final venueWaitlistProvider = VenueWaitlistFamily._();

/// V13 · Waitlist — read-only in v1. The auto-fill that offers a freed slot
/// runs on the server; the venue watches the queue.

final class VenueWaitlistProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WaitlistEntry>>,
          List<WaitlistEntry>,
          FutureOr<List<WaitlistEntry>>
        >
    with
        $FutureModifier<List<WaitlistEntry>>,
        $FutureProvider<List<WaitlistEntry>> {
  /// V13 · Waitlist — read-only in v1. The auto-fill that offers a freed slot
  /// runs on the server; the venue watches the queue.
  VenueWaitlistProvider._({
    required VenueWaitlistFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'venueWaitlistProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$venueWaitlistHash();

  @override
  String toString() {
    return r'venueWaitlistProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<WaitlistEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WaitlistEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return venueWaitlist(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VenueWaitlistProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$venueWaitlistHash() => r'7f513c983e2880f95214cff77ee863864b46d761';

/// V13 · Waitlist — read-only in v1. The auto-fill that offers a freed slot
/// runs on the server; the venue watches the queue.

final class VenueWaitlistFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<WaitlistEntry>>, String> {
  VenueWaitlistFamily._()
    : super(
        retry: null,
        name: r'venueWaitlistProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// V13 · Waitlist — read-only in v1. The auto-fill that offers a freed slot
  /// runs on the server; the venue watches the queue.

  VenueWaitlistProvider call(String venueSlug) =>
      VenueWaitlistProvider._(argument: venueSlug, from: this);

  @override
  String toString() => r'venueWaitlistProvider';
}
