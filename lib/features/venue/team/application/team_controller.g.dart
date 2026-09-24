// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// G3 · Team. Every write returns the whole team, because the rules are about
/// the shape of it — demoting the last owner is only refusable if you can see
/// how many owners there are.

@ProviderFor(TeamController)
final teamControllerProvider = TeamControllerFamily._();

/// G3 · Team. Every write returns the whole team, because the rules are about
/// the shape of it — demoting the last owner is only refusable if you can see
/// how many owners there are.
final class TeamControllerProvider
    extends $AsyncNotifierProvider<TeamController, Team> {
  /// G3 · Team. Every write returns the whole team, because the rules are about
  /// the shape of it — demoting the last owner is only refusable if you can see
  /// how many owners there are.
  TeamControllerProvider._({
    required TeamControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'teamControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$teamControllerHash();

  @override
  String toString() {
    return r'teamControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TeamController create() => TeamController();

  @override
  bool operator ==(Object other) {
    return other is TeamControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$teamControllerHash() => r'00b5cb1174d962f4ea5a05f6e4efeaa23ac807ce';

/// G3 · Team. Every write returns the whole team, because the rules are about
/// the shape of it — demoting the last owner is only refusable if you can see
/// how many owners there are.

final class TeamControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          TeamController,
          AsyncValue<Team>,
          Team,
          FutureOr<Team>,
          String
        > {
  TeamControllerFamily._()
    : super(
        retry: null,
        name: r'teamControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// G3 · Team. Every write returns the whole team, because the rules are about
  /// the shape of it — demoting the last owner is only refusable if you can see
  /// how many owners there are.

  TeamControllerProvider call(String venueSlug) =>
      TeamControllerProvider._(argument: venueSlug, from: this);

  @override
  String toString() => r'teamControllerProvider';
}

/// G3 · Team. Every write returns the whole team, because the rules are about
/// the shape of it — demoting the last owner is only refusable if you can see
/// how many owners there are.

abstract class _$TeamController extends $AsyncNotifier<Team> {
  late final _$args = ref.$arg as String;
  String get venueSlug => _$args;

  FutureOr<Team> build(String venueSlug);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Team>, Team>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Team>, Team>,
              AsyncValue<Team>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
