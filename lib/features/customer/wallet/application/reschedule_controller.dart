import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/local_store.dart';
import '../../../../core/time/clock.dart';
import '../../customer_providers.dart';
import '../domain/manage_repository.dart';
import 'wallet_controller.dart';

part 'reschedule_controller.g.dart';

/// Open slots on the same space over the next week (API-CONTRACT #7).
@riverpod
Future<List<RescheduleDay>> rescheduleOptions(
  Ref ref, {
  required String venueSlug,
  required String token,
}) =>
    ref.watch(manageRepositoryProvider).rescheduleOptions(
          venueSlug: venueSlug,
          token: token,
        );

/// Moves a booking to another slot and updates the wallet copy.
@Riverpod(keepAlive: true)
class RescheduleController extends _$RescheduleController {
  @override
  FutureOr<RescheduleOutcome?> build() => null;

  Future<RescheduleOutcome> move({
    required String venueSlug,
    required String token,
    required DateTime startsAt,
    required DateTime endsAt,
  }) async {
    state = const AsyncLoading();
    try {
      final outcome = await ref.read(manageRepositoryProvider).reschedule(
            venueSlug: venueSlug,
            token: token,
            startsAt: startsAt,
            endsAt: endsAt,
          );
      if (outcome is Rescheduled) {
        await ref
            .read(localStoreProvider)
            .saveBooking(outcome.booking, now: ref.read(clockProvider)());
        ref.invalidate(bookingDetailProvider(venueSlug, token));
        ref.invalidate(rescheduleOptionsProvider);
      }
      state = AsyncData(outcome);
      return outcome;
    } catch (error, stack) {
      state = AsyncError(error, stack);
      rethrow;
    }
  }
}

/// Joining the waitlist for a slot that is already taken (API-CONTRACT #9).
@Riverpod(keepAlive: true)
class WaitlistController extends _$WaitlistController {
  @override
  FutureOr<bool> build() => false;

  Future<void> join({
    required String venueSlug,
    required String spaceId,
    required DateTime startsAt,
    required DateTime endsAt,
    required String name,
    required String email,
    String? phone,
  }) async {
    state = const AsyncLoading();
    try {
      await ref.read(bookingRepositoryProvider).joinWaitlist(
            venueSlug: venueSlug,
            spaceId: spaceId,
            startsAt: startsAt,
            endsAt: endsAt,
            name: name,
            email: email,
            phone: phone,
          );
      state = const AsyncData(true);
    } catch (error, stack) {
      state = AsyncError(error, stack);
      rethrow;
    }
  }
}
