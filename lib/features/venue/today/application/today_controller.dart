import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/storage/local_store.dart';
import '../../../../core/time/clock.dart';
import '../../venue_providers.dart';
import '../domain/run_sheet.dart';
import '../domain/today_repository.dart';

part 'today_controller.g.dart';

/// V4 · Today. Fetches the run sheet, caches it, and falls back to that cache
/// when the desk's connection drops — a venue must still be able to read the
/// day's bookings when the wifi goes.
///
/// A 403 or 404 is a real error (wrong venue, membership revoked) and is not
/// papered over with stale data.
@riverpod
class Today extends _$Today {
  static const cacheKey = 'today';

  @override
  Future<TodayState> build(String venueSlug) async {
    final store = ref.watch(localStoreProvider);
    try {
      final view = await ref.watch(todayRepositoryProvider).today(venueSlug);
      await store.saveVenueCache(
        venueSlug,
        cacheKey,
        view.toJson(),
        now: ref.read(clockProvider)(),
      );
      return TodayState(view: view, stale: false);
    } on ApiError catch (e) {
      if (!e.isNetwork && e.status < 500) rethrow;
      final cached = await store.readVenueCache(venueSlug, cacheKey);
      if (cached == null) rethrow;
      return TodayState(
        view: TodayView.fromJson(cached.payload),
        stale: true,
        fetchedAt: cached.fetchedAt,
      );
    }
  }

  /// The four desk actions. Each one replaces its row in place so the list
  /// does not jump, then the whole sheet refreshes in the background because
  /// a cancellation changes the stats too.
  Future<void> checkIn(String bookingId) =>
      _act((r) => r.checkIn(venueSlug, bookingId));

  Future<void> undoCheckIn(String bookingId) =>
      _act((r) => r.undoCheckIn(venueSlug, bookingId));

  Future<void> noShow(String bookingId) =>
      _act((r) => r.noShow(venueSlug, bookingId));

  Future<void> cancel(String bookingId) =>
      _act((r) => r.cancel(venueSlug, bookingId));

  Future<void> _act(Future<RunSheetEntry> Function(TodayRepository repo) run) async {
    final updated = await run(ref.read(todayRepositoryProvider));
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.replacing(updated));
    }
    ref.invalidateSelf();
  }
}

/// The run sheet plus how fresh it is.
class TodayState {
  const TodayState({required this.view, required this.stale, this.fetchedAt});

  final TodayView view;

  /// True when this came from the phone rather than the server just now.
  final bool stale;
  final DateTime? fetchedAt;

  /// The same state with one row swapped for its updated version. A row that
  /// is no longer live (cancelled, no-show) stays on the sheet: the desk
  /// needs to see what it just did.
  TodayState replacing(RunSheetEntry entry) => TodayState(
        view: view.copyWith(
          runSheet: [
            for (final row in view.runSheet) if (row.id == entry.id) entry else row,
          ],
        ),
        stale: stale,
        fetchedAt: fetchedAt,
      );
}
