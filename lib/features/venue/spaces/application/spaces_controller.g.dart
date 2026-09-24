// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spaces_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// V14 · Spaces. The toggle takes a space off sale immediately, which also
/// changes the venue's billing band — so it is owner/admin only, and the
/// repository refuses rather than the button hiding the truth.

@ProviderFor(Spaces)
final spacesProvider = SpacesFamily._();

/// V14 · Spaces. The toggle takes a space off sale immediately, which also
/// changes the venue's billing band — so it is owner/admin only, and the
/// repository refuses rather than the button hiding the truth.
final class SpacesProvider
    extends $AsyncNotifierProvider<Spaces, List<SpaceSummary>> {
  /// V14 · Spaces. The toggle takes a space off sale immediately, which also
  /// changes the venue's billing band — so it is owner/admin only, and the
  /// repository refuses rather than the button hiding the truth.
  SpacesProvider._({
    required SpacesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'spacesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spacesHash();

  @override
  String toString() {
    return r'spacesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Spaces create() => Spaces();

  @override
  bool operator ==(Object other) {
    return other is SpacesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spacesHash() => r'2425d0a5038820b6a8e87e4ff8add2b27fe178b3';

/// V14 · Spaces. The toggle takes a space off sale immediately, which also
/// changes the venue's billing band — so it is owner/admin only, and the
/// repository refuses rather than the button hiding the truth.

final class SpacesFamily extends $Family
    with
        $ClassFamilyOverride<
          Spaces,
          AsyncValue<List<SpaceSummary>>,
          List<SpaceSummary>,
          FutureOr<List<SpaceSummary>>,
          String
        > {
  SpacesFamily._()
    : super(
        retry: null,
        name: r'spacesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// V14 · Spaces. The toggle takes a space off sale immediately, which also
  /// changes the venue's billing band — so it is owner/admin only, and the
  /// repository refuses rather than the button hiding the truth.

  SpacesProvider call(String venueSlug) =>
      SpacesProvider._(argument: venueSlug, from: this);

  @override
  String toString() => r'spacesProvider';
}

/// V14 · Spaces. The toggle takes a space off sale immediately, which also
/// changes the venue's billing band — so it is owner/admin only, and the
/// repository refuses rather than the button hiding the truth.

abstract class _$Spaces extends $AsyncNotifier<List<SpaceSummary>> {
  late final _$args = ref.$arg as String;
  String get venueSlug => _$args;

  FutureOr<List<SpaceSummary>> build(String venueSlug);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SpaceSummary>>, List<SpaceSummary>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SpaceSummary>>, List<SpaceSummary>>,
              AsyncValue<List<SpaceSummary>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
