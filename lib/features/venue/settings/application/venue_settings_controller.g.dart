// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// G2 · Venue settings. One save for the whole form, because that is what
/// `updateVenueSettings` is: a single transaction over the organization and
/// the venue rows.

@ProviderFor(VenueSettingsController)
final venueSettingsControllerProvider = VenueSettingsControllerFamily._();

/// G2 · Venue settings. One save for the whole form, because that is what
/// `updateVenueSettings` is: a single transaction over the organization and
/// the venue rows.
final class VenueSettingsControllerProvider
    extends $AsyncNotifierProvider<VenueSettingsController, VenueSettings> {
  /// G2 · Venue settings. One save for the whole form, because that is what
  /// `updateVenueSettings` is: a single transaction over the organization and
  /// the venue rows.
  VenueSettingsControllerProvider._({
    required VenueSettingsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'venueSettingsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$venueSettingsControllerHash();

  @override
  String toString() {
    return r'venueSettingsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VenueSettingsController create() => VenueSettingsController();

  @override
  bool operator ==(Object other) {
    return other is VenueSettingsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$venueSettingsControllerHash() =>
    r'32d1b56d0f72b873644c6c144fed874f205242c0';

/// G2 · Venue settings. One save for the whole form, because that is what
/// `updateVenueSettings` is: a single transaction over the organization and
/// the venue rows.

final class VenueSettingsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          VenueSettingsController,
          AsyncValue<VenueSettings>,
          VenueSettings,
          FutureOr<VenueSettings>,
          String
        > {
  VenueSettingsControllerFamily._()
    : super(
        retry: null,
        name: r'venueSettingsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// G2 · Venue settings. One save for the whole form, because that is what
  /// `updateVenueSettings` is: a single transaction over the organization and
  /// the venue rows.

  VenueSettingsControllerProvider call(String venueSlug) =>
      VenueSettingsControllerProvider._(argument: venueSlug, from: this);

  @override
  String toString() => r'venueSettingsControllerProvider';
}

/// G2 · Venue settings. One save for the whole form, because that is what
/// `updateVenueSettings` is: a single transaction over the organization and
/// the venue rows.

abstract class _$VenueSettingsController extends $AsyncNotifier<VenueSettings> {
  late final _$args = ref.$arg as String;
  String get venueSlug => _$args;

  FutureOr<VenueSettings> build(String venueSlug);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<VenueSettings>, VenueSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VenueSettings>, VenueSettings>,
              AsyncValue<VenueSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
