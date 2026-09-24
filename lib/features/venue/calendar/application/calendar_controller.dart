import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/storage/local_store.dart';
import '../../../../core/time/clock.dart';
import '../../venue_providers.dart';
import '../domain/calendar_day.dart';

part 'calendar_controller.g.dart';

/// V7 · Calendar. Same cached-read shape as Today: a day that was fetched
/// successfully is kept, and shown with a stale marker when the connection
/// drops. Each date gets its own cache key, so yesterday's grid does not get
/// served for today.
@riverpod
class Calendar extends _$Calendar {
  static String cacheKeyFor(String date) => 'calendar:$date';

  @override
  Future<CalendarState> build(String venueSlug, String date) async {
    final store = ref.watch(localStoreProvider);
    final key = cacheKeyFor(date);
    try {
      final day = await ref.watch(calendarRepositoryProvider).day(venueSlug, date);
      await store.saveVenueCache(
        venueSlug,
        key,
        day.toJson(),
        now: ref.read(clockProvider)(),
      );
      return CalendarState(day: day, stale: false);
    } on ApiError catch (e) {
      if (!e.isNetwork && e.status < 500) rethrow;
      final cached = await store.readVenueCache(venueSlug, key);
      if (cached == null) rethrow;
      return CalendarState(
        day: CalendarDay.fromJson(cached.payload),
        stale: true,
        fetchedAt: cached.fetchedAt,
      );
    }
  }
}

/// The day's grid plus how fresh it is.
class CalendarState {
  const CalendarState({required this.day, required this.stale, this.fetchedAt});

  final CalendarDay day;
  final bool stale;
  final DateTime? fetchedAt;
}
