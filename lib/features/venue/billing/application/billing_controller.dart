import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../venue_providers.dart';
import '../domain/billing.dart';

part 'billing_controller.g.dart';

/// G4 · Billing. The read is cheap and the band moves whenever a space is
/// paused, so the screen always refetches rather than trusting what it had.
@riverpod
class BillingController extends _$BillingController {
  @override
  Future<Billing> build(String venueSlug) =>
      ref.watch(billingRepositoryProvider).get(venueSlug);

  Future<void> submitProof(
    PaymentProofInput input, {
    List<int>? receipt,
  }) async {
    state = AsyncData(
      await ref
          .read(billingRepositoryProvider)
          .submitProof(venueSlug, input, receipt: receipt),
    );
  }
}
