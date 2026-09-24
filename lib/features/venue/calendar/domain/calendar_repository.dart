import '../../today/domain/run_sheet.dart';
import 'calendar_day.dart';
import 'manual_booking_input.dart';

/// A customer as the booking sheet's typeahead sees them (API-CONTRACT #16–20).
class CustomerHit {
  const CustomerHit({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.visits = 0,
  });

  final String id;
  final String name;
  final String email;
  final String? phone;
  final int visits;
}

/// The calendar's reads and writes (API-CONTRACT #16–#19).
abstract class CalendarRepository {
  /// One venue-local day's lanes. [date] is "YYYY-MM-DD".
  Future<CalendarDay> day(String venueSlug, String date);

  /// Staff booking. Relaxes notice and horizon, keeps every physical rule.
  Future<RunSheetEntry> createBooking(String venueSlug, ManualBookingInput input);

  /// Move a booking to another space and/or start, keeping its duration.
  Future<RunSheetEntry> move(
    String venueSlug,
    String bookingId, {
    required String spaceId,
    required String date,
    required String time,
  });

  Future<CalendarItem> block(String venueSlug, BlockInput input);

  Future<void> removeBlock(String venueSlug, String blockId);

  /// Typeahead for the booking sheet; at most a handful of matches.
  Future<List<CustomerHit>> searchCustomers(String venueSlug, String query);
}
