import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../today/domain/run_sheet.dart';
import '../../venue_providers.dart';
import '../domain/calendar_day.dart';
import '../domain/calendar_repository.dart';
import '../domain/manual_booking_input.dart';
import 'calendar_controller.dart';

part 'calendar_commands.g.dart';

/// The calendar's writes. Each one refreshes the day it touched — a booking
/// changes the grid, and a move can change two days at once.
///
/// `keepAlive` because these are invoked with `ref.read` from a button: an
/// auto-dispose notifier is gone before the future completes.
@Riverpod(keepAlive: true)
class CalendarCommands extends _$CalendarCommands {
  @override
  void build() {}

  CalendarRepository get _repo => ref.read(calendarRepositoryProvider);

  Future<RunSheetEntry> createBooking(
    String venueSlug,
    ManualBookingInput input,
  ) async {
    final booking = await _repo.createBooking(venueSlug, input);
    ref.invalidate(calendarProvider(venueSlug, input.date));
    return booking;
  }

  Future<RunSheetEntry> move(
    String venueSlug,
    String bookingId, {
    required String spaceId,
    required String fromDate,
    required String date,
    required String time,
  }) async {
    final booking = await _repo.move(
      venueSlug,
      bookingId,
      spaceId: spaceId,
      date: date,
      time: time,
    );
    ref.invalidate(calendarProvider(venueSlug, fromDate));
    if (date != fromDate) ref.invalidate(calendarProvider(venueSlug, date));
    return booking;
  }

  Future<CalendarItem> block(String venueSlug, BlockInput input) async {
    final item = await _repo.block(venueSlug, input);
    ref.invalidate(calendarProvider(venueSlug, input.date));
    return item;
  }

  Future<void> removeBlock(String venueSlug, String blockId, String date) async {
    await _repo.removeBlock(venueSlug, blockId);
    ref.invalidate(calendarProvider(venueSlug, date));
  }
}

/// Typeahead for the booking sheet (API-CONTRACT #20). Debounced by the
/// widget; this just asks.
@riverpod
Future<List<CustomerHit>> customerSearch(
  Ref ref,
  String venueSlug,
  String query,
) async {
  if (query.trim().isEmpty) return const [];
  return ref.watch(calendarRepositoryProvider).searchCustomers(venueSlug, query);
}
