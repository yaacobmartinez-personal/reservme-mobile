import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

/// Whether this booking can still be cancelled online, and why not.
/// The server re-derives this; the app never decides on its own.
@freezed
abstract class Cancellation with _$Cancellation {
  const factory Cancellation({
    @Default(false) bool canCancel,
    String? reason,
  }) = _Cancellation;

  factory Cancellation.fromJson(Map<String, dynamic> json) =>
      _$CancellationFromJson(json);
}

/// The venue as it appears on a booking (enough to render the card without
/// re-fetching the venue).
@freezed
abstract class BookingVenue with _$BookingVenue {
  const factory BookingVenue({
    required String slug,
    required String name,
    @Default(VenueTheme.pine) VenueTheme theme,
    @Default('Asia/Manila') String timezone,
    @Default('PHP') String currency,
    String? address,
  }) = _BookingVenue;

  factory BookingVenue.fromJson(Map<String, dynamic> json) =>
      _$BookingVenueFromJson(json);
}

@freezed
abstract class BookingSpace with _$BookingSpace {
  const factory BookingSpace({
    required String id,
    required String name,
    @Default(SpaceKind.other) SpaceKind kind,
    @Default(60) int slotMinutes,
  }) = _BookingSpace;

  factory BookingSpace.fromJson(Map<String, dynamic> json) =>
      _$BookingSpaceFromJson(json);
}

/// A customer's booking (API-CONTRACT #3–#8). `manageToken` only comes back
/// on the public endpoints — it is the capability that stands in for an
/// account, and it is what the device wallet stores.
@freezed
abstract class Booking with _$Booking {
  const Booking._();

  const factory Booking({
    String? id,
    required String reference,
    required BookingVenue venue,
    required BookingSpace space,
    required DateTime startsAt,
    required DateTime endsAt,

    /// "Sat 26 Sep · 18:00–19:00", rendered by the server in the venue's zone.
    required String whenLabel,
    @Default(ReservationKind.rental) ReservationKind kind,
    @Default(1) int partySize,
    @Default(0) int amountCents,
    @Default(ReservationStatus.confirmed) ReservationStatus status,
    DateTime? checkedInAt,
    String? notes,
    @Default(Cancellation()) Cancellation cancellation,
    String? manageToken,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

  bool get isPast => status == ReservationStatus.cancelled
      ? true
      : endsAt.isBefore(DateTime.now().toUtc());

  bool get isCancelled => status == ReservationStatus.cancelled;
}

/// What the customer types to book (API-CONTRACT #3).
@freezed
abstract class BookingInput with _$BookingInput {
  const BookingInput._();

  const factory BookingInput({
    required String spaceId,
    required DateTime startsAt,
    required DateTime endsAt,
    required String name,
    required String email,
    String? phone,
    String? promo,
    @Default(1) int partySize,
  }) = _BookingInput;

  factory BookingInput.fromJson(Map<String, dynamic> json) =>
      _$BookingInputFromJson(json);

  /// Client-side validation that mirrors the server's zod schema, so a typo
  /// is caught before the round trip. Keys match `fieldErrors`.
  Map<String, String> validate() {
    final errors = <String, String>{};
    if (name.trim().isEmpty) {
      errors['name'] = 'Please give a name for the booking.';
    } else if (name.trim().length > 120) {
      errors['name'] = 'That name is too long.';
    }
    final mail = email.trim();
    if (mail.isEmpty) {
      errors['email'] = 'We need an email to send your confirmation.';
    } else if (!_email.hasMatch(mail)) {
      errors['email'] = "That email doesn't look right.";
    }
    if (phone != null && phone!.trim().length > 40) {
      errors['phone'] = 'That number is too long.';
    }
    if (promo != null && promo!.trim().length > 40) {
      errors['promo'] = 'That code is too long.';
    }
    return errors;
  }

  static final _email = RegExp(r'^[^@\s]+@[^@\s.]+\.[^@\s]+$');
}

/// The outcome of a booking attempt. Everything the server can answer with,
/// so the UI never has to interpret a raw status code.
sealed class BookOutcome {
  const BookOutcome();
}

class Booked extends BookOutcome {
  const Booked(this.booking);
  final Booking booking;
}

/// The exclusion constraint refused: someone took it first.
class SlotTaken extends BookOutcome {
  const SlotTaken();
}

class SessionFull extends BookOutcome {
  const SessionFull();
}

/// The venue stopped taking bookings (suspended, or the space was paused).
class VenueClosed extends BookOutcome {
  const VenueClosed(this.message);
  final String message;
}

/// Too many attempts from this device or for this venue.
class RateLimited extends BookOutcome {
  const RateLimited(this.message);
  final String message;
}

/// 400 with per-field messages.
class BookingInvalid extends BookOutcome {
  const BookingInvalid(this.fieldErrors, this.message);
  final Map<String, String> fieldErrors;
  final String message;
}
