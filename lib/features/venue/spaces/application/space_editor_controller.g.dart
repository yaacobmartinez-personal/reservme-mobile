// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_editor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// G1 · the space editor. Every write returns the whole space, so the screen
/// never has to guess what a save did to the rest of it — adding a peak rule
/// changes the headline price, and closing a day can make the space
/// unbookable.

@ProviderFor(SpaceEditor)
final spaceEditorProvider = SpaceEditorFamily._();

/// G1 · the space editor. Every write returns the whole space, so the screen
/// never has to guess what a save did to the rest of it — adding a peak rule
/// changes the headline price, and closing a day can make the space
/// unbookable.
final class SpaceEditorProvider
    extends $AsyncNotifierProvider<SpaceEditor, SpaceDetail> {
  /// G1 · the space editor. Every write returns the whole space, so the screen
  /// never has to guess what a save did to the rest of it — adding a peak rule
  /// changes the headline price, and closing a day can make the space
  /// unbookable.
  SpaceEditorProvider._({
    required SpaceEditorFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'spaceEditorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spaceEditorHash();

  @override
  String toString() {
    return r'spaceEditorProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SpaceEditor create() => SpaceEditor();

  @override
  bool operator ==(Object other) {
    return other is SpaceEditorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spaceEditorHash() => r'598a8e32bd50f64665f5c21a73014c618d1dfede';

/// G1 · the space editor. Every write returns the whole space, so the screen
/// never has to guess what a save did to the rest of it — adding a peak rule
/// changes the headline price, and closing a day can make the space
/// unbookable.

final class SpaceEditorFamily extends $Family
    with
        $ClassFamilyOverride<
          SpaceEditor,
          AsyncValue<SpaceDetail>,
          SpaceDetail,
          FutureOr<SpaceDetail>,
          (String, String)
        > {
  SpaceEditorFamily._()
    : super(
        retry: null,
        name: r'spaceEditorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// G1 · the space editor. Every write returns the whole space, so the screen
  /// never has to guess what a save did to the rest of it — adding a peak rule
  /// changes the headline price, and closing a day can make the space
  /// unbookable.

  SpaceEditorProvider call(String venueSlug, String spaceId) =>
      SpaceEditorProvider._(argument: (venueSlug, spaceId), from: this);

  @override
  String toString() => r'spaceEditorProvider';
}

/// G1 · the space editor. Every write returns the whole space, so the screen
/// never has to guess what a save did to the rest of it — adding a peak rule
/// changes the headline price, and closing a day can make the space
/// unbookable.

abstract class _$SpaceEditor extends $AsyncNotifier<SpaceDetail> {
  late final _$args = ref.$arg as (String, String);
  String get venueSlug => _$args.$1;
  String get spaceId => _$args.$2;

  FutureOr<SpaceDetail> build(String venueSlug, String spaceId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SpaceDetail>, SpaceDetail>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SpaceDetail>, SpaceDetail>,
              AsyncValue<SpaceDetail>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
