import 'run_sheet.dart';

/// Today's run sheet and the four actions the desk takes on a booking
/// (API-CONTRACT #14, #15).
abstract class TodayRepository {
  Future<TodayView> today(String venueSlug);

  /// Mark the customer as arrived. [at] lets the desk correct the time; the
  /// server clamps it into the booking's own window.
  Future<RunSheetEntry> checkIn(String venueSlug, String bookingId, {DateTime? at});

  Future<RunSheetEntry> undoCheckIn(String venueSlug, String bookingId);

  /// Marks a no-show and counts it against the customer, like the web.
  Future<RunSheetEntry> noShow(String venueSlug, String bookingId);

  /// Staff cancel: frees the slot immediately and bypasses the customer
  /// cancellation policy.
  Future<RunSheetEntry> cancel(String venueSlug, String bookingId);
}
