// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// V10 · Customers. The list is a live read — no cache — because a venue
/// searching for someone at the counter wants the truth, and the screen has
/// a perfectly good empty state when the network is gone.

@ProviderFor(customers)
final customersProvider = CustomersFamily._();

/// V10 · Customers. The list is a live read — no cache — because a venue
/// searching for someone at the counter wants the truth, and the screen has
/// a perfectly good empty state when the network is gone.

final class CustomersProvider
    extends
        $FunctionalProvider<
          AsyncValue<CustomerPage>,
          CustomerPage,
          FutureOr<CustomerPage>
        >
    with $FutureModifier<CustomerPage>, $FutureProvider<CustomerPage> {
  /// V10 · Customers. The list is a live read — no cache — because a venue
  /// searching for someone at the counter wants the truth, and the screen has
  /// a perfectly good empty state when the network is gone.
  CustomersProvider._({
    required CustomersFamily super.from,
    required (String, {String search, CustomerSegment segment}) super.argument,
  }) : super(
         retry: null,
         name: r'customersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customersHash();

  @override
  String toString() {
    return r'customersProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<CustomerPage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CustomerPage> create(Ref ref) {
    final argument =
        this.argument as (String, {String search, CustomerSegment segment});
    return customers(
      ref,
      argument.$1,
      search: argument.search,
      segment: argument.segment,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CustomersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customersHash() => r'0d0ffa339b19327e26b76959a05ff1dd4bae7eda';

/// V10 · Customers. The list is a live read — no cache — because a venue
/// searching for someone at the counter wants the truth, and the screen has
/// a perfectly good empty state when the network is gone.

final class CustomersFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<CustomerPage>,
          (String, {String search, CustomerSegment segment})
        > {
  CustomersFamily._()
    : super(
        retry: null,
        name: r'customersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// V10 · Customers. The list is a live read — no cache — because a venue
  /// searching for someone at the counter wants the truth, and the screen has
  /// a perfectly good empty state when the network is gone.

  CustomersProvider call(
    String venueSlug, {
    String search = '',
    CustomerSegment segment = CustomerSegment.all,
  }) => CustomersProvider._(
    argument: (venueSlug, search: search, segment: segment),
    from: this,
  );

  @override
  String toString() => r'customersProvider';
}

/// V11 · Customer detail, with the CRM writes the desk actually uses.

@ProviderFor(CustomerDetail)
final customerDetailProvider = CustomerDetailFamily._();

/// V11 · Customer detail, with the CRM writes the desk actually uses.
final class CustomerDetailProvider
    extends $AsyncNotifierProvider<CustomerDetail, CustomerProfile> {
  /// V11 · Customer detail, with the CRM writes the desk actually uses.
  CustomerDetailProvider._({
    required CustomerDetailFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'customerDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerDetailHash();

  @override
  String toString() {
    return r'customerDetailProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CustomerDetail create() => CustomerDetail();

  @override
  bool operator ==(Object other) {
    return other is CustomerDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerDetailHash() => r'ac4bb72bec43a872262bdffa867686eff9c4f4ef';

/// V11 · Customer detail, with the CRM writes the desk actually uses.

final class CustomerDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          CustomerDetail,
          AsyncValue<CustomerProfile>,
          CustomerProfile,
          FutureOr<CustomerProfile>,
          (String, String)
        > {
  CustomerDetailFamily._()
    : super(
        retry: null,
        name: r'customerDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// V11 · Customer detail, with the CRM writes the desk actually uses.

  CustomerDetailProvider call(String venueSlug, String customerId) =>
      CustomerDetailProvider._(argument: (venueSlug, customerId), from: this);

  @override
  String toString() => r'customerDetailProvider';
}

/// V11 · Customer detail, with the CRM writes the desk actually uses.

abstract class _$CustomerDetail extends $AsyncNotifier<CustomerProfile> {
  late final _$args = ref.$arg as (String, String);
  String get venueSlug => _$args.$1;
  String get customerId => _$args.$2;

  FutureOr<CustomerProfile> build(String venueSlug, String customerId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CustomerProfile>, CustomerProfile>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CustomerProfile>, CustomerProfile>,
              AsyncValue<CustomerProfile>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
