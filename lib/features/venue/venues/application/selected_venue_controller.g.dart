// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_venue_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Which of the user's venues the venue shell is showing. Persisted by slug.
/// A slug that no longer appears in the memberships reads as "none", and a
/// single membership selects itself, so the picker only appears when there
/// is a real choice.

@ProviderFor(SelectedVenueSlug)
final selectedVenueSlugProvider = SelectedVenueSlugProvider._();

/// Which of the user's venues the venue shell is showing. Persisted by slug.
/// A slug that no longer appears in the memberships reads as "none", and a
/// single membership selects itself, so the picker only appears when there
/// is a real choice.
final class SelectedVenueSlugProvider
    extends $NotifierProvider<SelectedVenueSlug, String?> {
  /// Which of the user's venues the venue shell is showing. Persisted by slug.
  /// A slug that no longer appears in the memberships reads as "none", and a
  /// single membership selects itself, so the picker only appears when there
  /// is a real choice.
  SelectedVenueSlugProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedVenueSlugProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedVenueSlugHash();

  @$internal
  @override
  SelectedVenueSlug create() => SelectedVenueSlug();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedVenueSlugHash() => r'8b9b54c29405f755cc506ab7c1bf3df098a3e5d6';

/// Which of the user's venues the venue shell is showing. Persisted by slug.
/// A slug that no longer appears in the memberships reads as "none", and a
/// single membership selects itself, so the picker only appears when there
/// is a real choice.

abstract class _$SelectedVenueSlug extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The selected membership, or null when nothing is selected.

@ProviderFor(selectedVenue)
final selectedVenueProvider = SelectedVenueProvider._();

/// The selected membership, or null when nothing is selected.

final class SelectedVenueProvider
    extends
        $FunctionalProvider<
          VenueMembership?,
          VenueMembership?,
          VenueMembership?
        >
    with $Provider<VenueMembership?> {
  /// The selected membership, or null when nothing is selected.
  SelectedVenueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedVenueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedVenueHash();

  @$internal
  @override
  $ProviderElement<VenueMembership?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VenueMembership? create(Ref ref) {
    return selectedVenue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VenueMembership? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VenueMembership?>(value),
    );
  }
}

String _$selectedVenueHash() => r'72a00d448f53d6b66802cc9d26d611f7e1f51dd5';
