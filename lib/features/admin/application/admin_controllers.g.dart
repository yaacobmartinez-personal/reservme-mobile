// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The console's reads. None are cached for offline: every one of them is
/// somebody else's money or access, and yesterday's copy of it is worse than
/// an error that says so.

@ProviderFor(adminOverview)
final adminOverviewProvider = AdminOverviewProvider._();

/// The console's reads. None are cached for offline: every one of them is
/// somebody else's money or access, and yesterday's copy of it is worse than
/// an error that says so.

final class AdminOverviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<AdminOverview>,
          AdminOverview,
          FutureOr<AdminOverview>
        >
    with $FutureModifier<AdminOverview>, $FutureProvider<AdminOverview> {
  /// The console's reads. None are cached for offline: every one of them is
  /// somebody else's money or access, and yesterday's copy of it is worse than
  /// an error that says so.
  AdminOverviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminOverviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminOverviewHash();

  @$internal
  @override
  $FutureProviderElement<AdminOverview> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AdminOverview> create(Ref ref) {
    return adminOverview(ref);
  }
}

String _$adminOverviewHash() => r'98da73cba989d6d31e54d372e8518e60939a6378';

@ProviderFor(adminTenants)
final adminTenantsProvider = AdminTenantsFamily._();

final class AdminTenantsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TenantSummary>>,
          List<TenantSummary>,
          FutureOr<List<TenantSummary>>
        >
    with
        $FutureModifier<List<TenantSummary>>,
        $FutureProvider<List<TenantSummary>> {
  AdminTenantsProvider._({
    required AdminTenantsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminTenantsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminTenantsHash();

  @override
  String toString() {
    return r'adminTenantsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TenantSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TenantSummary>> create(Ref ref) {
    final argument = this.argument as String;
    return adminTenants(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminTenantsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminTenantsHash() => r'b95d7ae0d93884d94df95d7c550fc93410b14cfd';

final class AdminTenantsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TenantSummary>>, String> {
  AdminTenantsFamily._()
    : super(
        retry: null,
        name: r'adminTenantsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminTenantsProvider call(String query) =>
      AdminTenantsProvider._(argument: query, from: this);

  @override
  String toString() => r'adminTenantsProvider';
}

@ProviderFor(adminTenant)
final adminTenantProvider = AdminTenantFamily._();

final class AdminTenantProvider
    extends
        $FunctionalProvider<
          AsyncValue<TenantDetail>,
          TenantDetail,
          FutureOr<TenantDetail>
        >
    with $FutureModifier<TenantDetail>, $FutureProvider<TenantDetail> {
  AdminTenantProvider._({
    required AdminTenantFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminTenantProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminTenantHash();

  @override
  String toString() {
    return r'adminTenantProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TenantDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TenantDetail> create(Ref ref) {
    final argument = this.argument as String;
    return adminTenant(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminTenantProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminTenantHash() => r'0f6e214b7441b3c88f14e0d19fce1cffa506f225';

final class AdminTenantFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TenantDetail>, String> {
  AdminTenantFamily._()
    : super(
        retry: null,
        name: r'adminTenantProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminTenantProvider call(String orgId) =>
      AdminTenantProvider._(argument: orgId, from: this);

  @override
  String toString() => r'adminTenantProvider';
}

@ProviderFor(adminPaymentQueue)
final adminPaymentQueueProvider = AdminPaymentQueueProvider._();

final class AdminPaymentQueueProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AdminPayment>>,
          List<AdminPayment>,
          FutureOr<List<AdminPayment>>
        >
    with
        $FutureModifier<List<AdminPayment>>,
        $FutureProvider<List<AdminPayment>> {
  AdminPaymentQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminPaymentQueueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminPaymentQueueHash();

  @$internal
  @override
  $FutureProviderElement<List<AdminPayment>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AdminPayment>> create(Ref ref) {
    return adminPaymentQueue(ref);
  }
}

String _$adminPaymentQueueHash() => r'7f849f78fae506e6e837580bd08bfa57fee74417';

@ProviderFor(adminInstapay)
final adminInstapayProvider = AdminInstapayProvider._();

final class AdminInstapayProvider
    extends
        $FunctionalProvider<
          AsyncValue<InstapaySettings>,
          InstapaySettings,
          FutureOr<InstapaySettings>
        >
    with $FutureModifier<InstapaySettings>, $FutureProvider<InstapaySettings> {
  AdminInstapayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminInstapayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminInstapayHash();

  @$internal
  @override
  $FutureProviderElement<InstapaySettings> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<InstapaySettings> create(Ref ref) {
    return adminInstapay(ref);
  }
}

String _$adminInstapayHash() => r'a46ef0c6738643058f6e594d9635233ac9a873ed';

@ProviderFor(adminAudit)
final adminAuditProvider = AdminAuditProvider._();

final class AdminAuditProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AuditEntry>>,
          List<AuditEntry>,
          FutureOr<List<AuditEntry>>
        >
    with $FutureModifier<List<AuditEntry>>, $FutureProvider<List<AuditEntry>> {
  AdminAuditProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAuditProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAuditHash();

  @$internal
  @override
  $FutureProviderElement<List<AuditEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AuditEntry>> create(Ref ref) {
    return adminAudit(ref);
  }
}

String _$adminAuditHash() => r'337707afd0f9d6be88db6ee983d0a23789e54b51';

@ProviderFor(adminAdmins)
final adminAdminsProvider = AdminAdminsProvider._();

final class AdminAdminsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PlatformAdminEntry>>,
          List<PlatformAdminEntry>,
          FutureOr<List<PlatformAdminEntry>>
        >
    with
        $FutureModifier<List<PlatformAdminEntry>>,
        $FutureProvider<List<PlatformAdminEntry>> {
  AdminAdminsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAdminsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAdminsHash();

  @$internal
  @override
  $FutureProviderElement<List<PlatformAdminEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PlatformAdminEntry>> create(Ref ref) {
    return adminAdmins(ref);
  }
}

String _$adminAdminsHash() => r'5a418ae638624083c4b5915d532b9d436b08dc25';

/// The console's writes. Each refreshes what it changed — and the overview
/// and audit trail, which every write changes.
///
/// `keepAlive` because these are invoked with `ref.read` from a button: an
/// auto-dispose notifier is gone before the future completes.

@ProviderFor(AdminCommands)
final adminCommandsProvider = AdminCommandsProvider._();

/// The console's writes. Each refreshes what it changed — and the overview
/// and audit trail, which every write changes.
///
/// `keepAlive` because these are invoked with `ref.read` from a button: an
/// auto-dispose notifier is gone before the future completes.
final class AdminCommandsProvider
    extends $NotifierProvider<AdminCommands, void> {
  /// The console's writes. Each refreshes what it changed — and the overview
  /// and audit trail, which every write changes.
  ///
  /// `keepAlive` because these are invoked with `ref.read` from a button: an
  /// auto-dispose notifier is gone before the future completes.
  AdminCommandsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminCommandsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminCommandsHash();

  @$internal
  @override
  AdminCommands create() => AdminCommands();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$adminCommandsHash() => r'20d608883a77cc68ecc2f3dafc8c311aba0a472f';

/// The console's writes. Each refreshes what it changed — and the overview
/// and audit trail, which every write changes.
///
/// `keepAlive` because these are invoked with `ref.read` from a button: an
/// auto-dispose notifier is gone before the future completes.

abstract class _$AdminCommands extends $Notifier<void> {
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
