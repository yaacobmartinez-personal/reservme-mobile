// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The public venue page. Opening one records it in Recent venues, which is
/// the only "history" a customer has on the Find screen.

@ProviderFor(venue)
final venueProvider = VenueFamily._();

/// The public venue page. Opening one records it in Recent venues, which is
/// the only "history" a customer has on the Find screen.

final class VenueProvider
    extends
        $FunctionalProvider<
          AsyncValue<PublicVenue>,
          PublicVenue,
          FutureOr<PublicVenue>
        >
    with $FutureModifier<PublicVenue>, $FutureProvider<PublicVenue> {
  /// The public venue page. Opening one records it in Recent venues, which is
  /// the only "history" a customer has on the Find screen.
  VenueProvider._({
    required VenueFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'venueProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$venueHash();

  @override
  String toString() {
    return r'venueProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PublicVenue> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PublicVenue> create(Ref ref) {
    final argument = this.argument as String;
    return venue(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VenueProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$venueHash() => r'a5108de7dc32709ae76ebec128e3489bc12bd0c8';

/// The public venue page. Opening one records it in Recent venues, which is
/// the only "history" a customer has on the Find screen.

final class VenueFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PublicVenue>, String> {
  VenueFamily._()
    : super(
        retry: null,
        name: r'venueProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The public venue page. Opening one records it in Recent venues, which is
  /// the only "history" a customer has on the Find screen.

  VenueProvider call(String slug) =>
      VenueProvider._(argument: slug, from: this);

  @override
  String toString() => r'venueProvider';
}

/// Venues this phone has opened, newest first.

@ProviderFor(recentVenues)
final recentVenuesProvider = RecentVenuesProvider._();

/// Venues this phone has opened, newest first.

final class RecentVenuesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RecentVenue>>,
          List<RecentVenue>,
          Stream<List<RecentVenue>>
        >
    with
        $FutureModifier<List<RecentVenue>>,
        $StreamProvider<List<RecentVenue>> {
  /// Venues this phone has opened, newest first.
  RecentVenuesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentVenuesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentVenuesHash();

  @$internal
  @override
  $StreamProviderElement<List<RecentVenue>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<RecentVenue>> create(Ref ref) {
    return recentVenues(ref);
  }
}

String _$recentVenuesHash() => r'ffb45201268ace9b14c516beae42b85fe353e4ac';
