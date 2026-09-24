import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../venue_providers.dart';
import '../domain/customer.dart';

part 'customers_controller.g.dart';

/// V10 · Customers. The list is a live read — no cache — because a venue
/// searching for someone at the counter wants the truth, and the screen has
/// a perfectly good empty state when the network is gone.
@riverpod
Future<CustomerPage> customers(
  Ref ref,
  String venueSlug, {
  String search = '',
  CustomerSegment segment = CustomerSegment.all,
}) =>
    ref.watch(customersRepositoryProvider).list(
          venueSlug,
          search: search,
          segment: segment,
        );

/// V11 · Customer detail, with the CRM writes the desk actually uses.
@riverpod
class CustomerDetail extends _$CustomerDetail {
  @override
  Future<CustomerProfile> build(String venueSlug, String customerId) =>
      ref.watch(customersRepositoryProvider).detail(venueSlug, customerId);

  Future<void> addNote(String body) async {
    await ref.read(customersRepositoryProvider).addNote(venueSlug, customerId, body);
    ref.invalidateSelf();
    await future;
  }

  Future<void> deleteNote(String noteId) async {
    await ref
        .read(customersRepositoryProvider)
        .deleteNote(venueSlug, customerId, noteId);
    ref.invalidateSelf();
    await future;
  }

  Future<void> setTags(List<String> tags) async {
    await ref.read(customersRepositoryProvider).setTags(venueSlug, customerId, tags);
    ref.invalidateSelf();
    await future;
  }

  Future<void> updateContact({required String name, String? phone}) async {
    await ref.read(customersRepositoryProvider).updateContact(
          venueSlug,
          customerId,
          name: name,
          phone: phone,
        );
    ref.invalidateSelf();
    await future;
  }
}
