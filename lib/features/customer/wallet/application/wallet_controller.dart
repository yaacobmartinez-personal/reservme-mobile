import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/storage/local_store.dart';
import '../../../../core/time/clock.dart';
import '../../booking/domain/booking.dart';
import '../../customer_providers.dart';
import '../domain/manage_repository.dart';

part 'wallet_controller.g.dart';

/// Everything saved on this phone, split into upcoming and past.
@riverpod
Stream<List<Booking>> wallet(Ref ref) => ref.watch(localStoreProvider).watchWallet();

/// One booking. The saved snapshot renders immediately; a refresh from the
/// server follows and updates the row. Offline, the snapshot is all there is
/// and the screen says when it was last checked.
@riverpod
class BookingDetail extends _$BookingDetail {
  @override
  Future<BookingView> build(String venueSlug, String token) async {
    final store = ref.watch(localStoreProvider);
    final saved = await store.readBooking(venueSlug, token);
    try {
      final fresh = await ref.watch(manageRepositoryProvider).byToken(
            venueSlug: venueSlug,
            token: token,
          );
      await store.saveBooking(fresh, now: ref.read(clockProvider)());
      return BookingView(booking: fresh, stale: false);
    } on ApiError catch (e) {
      // Without a saved copy there is nothing to show but the error.
      if (saved == null) rethrow;
      // With one, show it rather than hiding a booking the customer may be
      // about to present at the desk — flagged so the screen can say why it
      // could not be confirmed: a 404 means the venue no longer recognises
      // the link, anything else means we simply could not reach them.
      return BookingView(
        booking: saved,
        stale: true,
        missing: e.isNotFound,
        lastSyncedAt: await store.lastSyncedAt(venueSlug, token),
      );
    }
  }

  /// Cancel, honouring the venue's policy. Returns the refusal reason when
  /// the venue says no, so the screen can show the venue's own wording.
  Future<CancelOutcome> cancel() async {
    final outcome = await ref
        .read(manageRepositoryProvider)
        .cancel(venueSlug: venueSlug, token: token);
    if (outcome is Cancelled) {
      await ref.read(localStoreProvider).saveBooking(
            outcome.booking,
            now: ref.read(clockProvider)(),
          );
      state = AsyncData(BookingView(booking: outcome.booking, stale: false));
    }
    return outcome;
  }

  /// Forget this booking on this phone. The booking itself is untouched —
  /// the venue still has it and the email still opens it.
  Future<void> removeFromPhone() async {
    await ref.read(localStoreProvider).removeBooking(venueSlug, token);
  }
}

/// A booking plus how fresh it is.
class BookingView {
  const BookingView({
    required this.booking,
    required this.stale,
    this.missing = false,
    this.lastSyncedAt,
  });

  final Booking booking;

  /// True when this came from the phone rather than the server just now.
  final bool stale;

  /// The venue returned 404 for this token: cancelled, erased, or the link
  /// was rotated. The saved copy is shown, but it cannot be trusted or acted
  /// on any more.
  final bool missing;
  final DateTime? lastSyncedAt;
}

/// Saves a booking opened from a manage link into the wallet (the deep-link
/// import, C11).
@Riverpod(keepAlive: true)
class ImportBooking extends _$ImportBooking {
  @override
  FutureOr<Booking?> build() => null;

  Future<Booking> import({required String venueSlug, required String token}) async {
    state = const AsyncLoading();
    try {
      final booking = await ref
          .read(manageRepositoryProvider)
          .byToken(venueSlug: venueSlug, token: token);
      await ref.read(localStoreProvider).saveBooking(booking, now: ref.read(clockProvider)());
      state = AsyncData(booking);
      return booking;
    } catch (error, stack) {
      state = AsyncError(error, stack);
      rethrow;
    }
  }
}
