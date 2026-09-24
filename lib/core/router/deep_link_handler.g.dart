// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep_link_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Listens for links and acts on them for the life of the app.
///
/// Both halves matter: `getInitialLink` covers a cold start from a link, and
/// the stream covers one arriving while the app is already up. Missing the
/// first would mean tapping a booking link on a fresh install did nothing.

@ProviderFor(DeepLinks)
final deepLinksProvider = DeepLinksProvider._();

/// Listens for links and acts on them for the life of the app.
///
/// Both halves matter: `getInitialLink` covers a cold start from a link, and
/// the stream covers one arriving while the app is already up. Missing the
/// first would mean tapping a booking link on a fresh install did nothing.
final class DeepLinksProvider extends $NotifierProvider<DeepLinks, Uri?> {
  /// Listens for links and acts on them for the life of the app.
  ///
  /// Both halves matter: `getInitialLink` covers a cold start from a link, and
  /// the stream covers one arriving while the app is already up. Missing the
  /// first would mean tapping a booking link on a fresh install did nothing.
  DeepLinksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deepLinksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deepLinksHash();

  @$internal
  @override
  DeepLinks create() => DeepLinks();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Uri? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Uri?>(value),
    );
  }
}

String _$deepLinksHash() => r'c9bcce4bb213aec2faf9153351c7451d3ca6a944';

/// Listens for links and acts on them for the life of the app.
///
/// Both halves matter: `getInitialLink` covers a cold start from a link, and
/// the stream covers one arriving while the app is already up. Missing the
/// first would mean tapping a booking link on a fresh install did nothing.

abstract class _$DeepLinks extends $Notifier<Uri?> {
  Uri? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Uri?, Uri?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Uri?, Uri?>,
              Uri?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Seam for tests, which have no platform channels.

@ProviderFor(appLinks)
final appLinksProvider = AppLinksProvider._();

/// Seam for tests, which have no platform channels.

final class AppLinksProvider
    extends $FunctionalProvider<AppLinks, AppLinks, AppLinks>
    with $Provider<AppLinks> {
  /// Seam for tests, which have no platform channels.
  AppLinksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLinksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLinksHash();

  @$internal
  @override
  $ProviderElement<AppLinks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLinks create(Ref ref) {
    return appLinks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLinks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLinks>(value),
    );
  }
}

String _$appLinksHash() => r'fbe75f037be26cbfc9ae78ce778afe86c6a92bf9';
