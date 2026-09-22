import '../../booking/domain/availability.dart';
import '../../booking/domain/booking.dart';

/// Managing a booking by its manage token (API-CONTRACT #5–#8). The token is
/// the capability: there is no customer account.
abstract class ManageRepository {
  /// The booking behind a token. Works while the venue is suspended, so a
  /// customer can always cancel. Throws `ApiError(404)` for an unknown or
  /// rotated token.
  Future<Booking> byToken({required String venueSlug, required String token});

  /// Cancel, if the venue's policy allows it. Returns the updated booking, or
  /// [CancelRefused] with the venue's own wording.
  Future<CancelOutcome> cancel({required String venueSlug, required String token});

  /// Open slots on the same space over the next [days] days.
  Future<List<RescheduleDay>> rescheduleOptions({
    required String venueSlug,
    required String token,
    int days = 7,
  });

  /// Move the booking. `slot_taken` comes back as [SlotTaken]-shaped failure.
  Future<RescheduleOutcome> reschedule({
    required String venueSlug,
    required String token,
    required DateTime startsAt,
    required DateTime endsAt,
  });
}

/// One day of reschedule options.
class RescheduleDay {
  const RescheduleDay({required this.date, required this.slots});

  /// "2026-09-27", venue-local.
  final String date;
  final List<Slot> slots;
}

sealed class CancelOutcome {
  const CancelOutcome();
}

class Cancelled extends CancelOutcome {
  const Cancelled(this.booking);
  final Booking booking;
}

/// The policy said no; [reason] is the venue-facing sentence to show.
class CancelRefused extends CancelOutcome {
  const CancelRefused(this.reason);
  final String reason;
}

sealed class RescheduleOutcome {
  const RescheduleOutcome();
}

class Rescheduled extends RescheduleOutcome {
  const Rescheduled(this.booking);
  final Booking booking;
}

class RescheduleSlotTaken extends RescheduleOutcome {
  const RescheduleSlotTaken();
}

class RescheduleRefused extends RescheduleOutcome {
  const RescheduleRefused(this.reason);
  final String reason;
}
