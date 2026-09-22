import 'dart:math';

import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/time/app_time.dart';
import '../domain/booking.dart';

/// Builds the domain [Booking] from a fake reservation, including the
/// cancellation decision. Shared by the booking and manage fakes so both
/// answer identically.
Booking bookingFrom(
  FakeStore store,
  FakeReservation r, {
  required DateTime now,
  bool includeToken = false,
}) {
  final venue = store.venueById(r.venueId)!;
  final space = store.spaceById(r.spaceId)!;
  return Booking(
    id: r.id,
    reference: r.reference,
    venue: BookingVenue(
      slug: venue.slug,
      name: venue.name,
      theme: venue.theme,
      timezone: venue.timezone,
      currency: venue.currency,
      address: venue.address,
    ),
    space: BookingSpace(
      id: space.id,
      name: space.name,
      kind: space.kind,
      slotMinutes: space.slotMinutes,
    ),
    startsAt: r.startsAt,
    endsAt: r.endsAt,
    whenLabel: AppTime.formatWhen(r.startsAt, r.endsAt, venue.timezone),
    kind: r.kind,
    partySize: r.partySize,
    amountCents: r.amountCents,
    status: r.status,
    checkedInAt: r.checkedInAt,
    notes: r.notes,
    cancellation: cancelEligibility(
      status: r.status,
      startsAt: r.startsAt,
      mode: venue.cancellationMode,
      graceHours: venue.cancellationGraceHours,
      now: now,
    ),
    manageToken: includeToken ? r.manageToken : null,
  );
}

/// Pure port of the web `cancelEligibility` (`src/lib/booking/manage.ts`),
/// including its exact wording — the app must never invent a different
/// reason from the server's.
Cancellation cancelEligibility({
  required ReservationStatus status,
  required DateTime startsAt,
  required CancellationMode mode,
  required int graceHours,
  required DateTime now,
}) {
  if (status != ReservationStatus.confirmed && status != ReservationStatus.held) {
    final reason = switch (status) {
      ReservationStatus.cancelled => 'This booking has already been cancelled.',
      ReservationStatus.noShow => 'This booking was marked as a no-show.',
      _ => 'This booking can no longer be changed.',
    };
    return Cancellation(canCancel: false, reason: reason);
  }
  if (!startsAt.isAfter(now)) {
    return const Cancellation(canCancel: false, reason: 'This booking has already passed.');
  }
  switch (mode) {
    case CancellationMode.never:
      return const Cancellation(
        canCancel: false,
        reason: "This venue doesn't allow online cancellation — please contact them.",
      );
    case CancellationMode.grace:
      final cutoff = startsAt.subtract(Duration(hours: graceHours));
      if (now.isAfter(cutoff)) {
        return Cancellation(
          canCancel: false,
          reason: 'This is within $graceHours hours of the start, so it cannot be '
              'cancelled online — please contact the venue.',
        );
      }
    case CancellationMode.anytime:
      break;
  }
  return const Cancellation(canCancel: true);
}

const _refAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // no 0/O/1/I

/// "KTP-7H4M" — the short code a customer reads at the desk.
String newReference(Random rnd) {
  String part(int n) =>
      List.generate(n, (_) => _refAlphabet[rnd.nextInt(_refAlphabet.length)]).join();
  return '${part(3)}-${part(4)}';
}

/// The unguessable capability in a manage link.
String newToken(Random rnd) =>
    List.generate(32, (_) => '0123456789abcdef'[rnd.nextInt(16)]).join();
