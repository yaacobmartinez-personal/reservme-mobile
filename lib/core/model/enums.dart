import 'package:json_annotation/json_annotation.dart';

// Wire-level enums shared by every feature. Values match the Postgres text
// columns in the web schema (drizzle/*.sql) and the JSON the API emits.

/// Better Auth organization roles: one organization = one venue.
enum VenueRole {
  @JsonValue('owner')
  owner('owner'),
  @JsonValue('admin')
  admin('admin'),
  @JsonValue('member')
  member('member');

  const VenueRole(this.wire);
  final String wire;

  static VenueRole fromWire(String v) =>
      values.firstWhere((r) => r.wire == v, orElse: () => VenueRole.member);

  int get _rank => switch (this) {
        VenueRole.owner => 3,
        VenueRole.admin => 2,
        VenueRole.member => 1,
      };

  /// owner > admin > member.
  bool atLeast(VenueRole min) => _rank >= min._rank;

  String get label => switch (this) {
        VenueRole.owner => 'Owner',
        VenueRole.admin => 'Admin',
        VenueRole.member => 'Staff',
      };
}

enum ReservationStatus {
  @JsonValue('held')
  held('held'),
  @JsonValue('confirmed')
  confirmed('confirmed'),
  @JsonValue('cancelled')
  cancelled('cancelled'),
  @JsonValue('no_show')
  noShow('no_show');

  const ReservationStatus(this.wire);
  final String wire;

  static ReservationStatus fromWire(String v) => values.firstWhere(
        (s) => s.wire == v,
        orElse: () => ReservationStatus.confirmed,
      );

  /// Live rows occupy the slot (they take part in the exclusion constraint).
  bool get isLive => this == held || this == confirmed;
}

enum ReservationKind {
  @JsonValue('rental')
  rental('rental'),
  @JsonValue('session_block')
  sessionBlock('session_block'),
  @JsonValue('session_seat')
  sessionSeat('session_seat');

  const ReservationKind(this.wire);
  final String wire;

  static ReservationKind fromWire(String v) => values.firstWhere(
        (k) => k.wire == v,
        orElse: () => ReservationKind.rental,
      );
}

/// Why a slot is or isn't bookable (`Slot.reason` in the web availability).
enum SlotReason {
  @JsonValue('open')
  open('open'),
  @JsonValue('taken')
  taken('taken'),
  @JsonValue('closed')
  closed('closed'),
  @JsonValue('too_soon')
  tooSoon('too_soon'),
  @JsonValue('too_far_ahead')
  tooFarAhead('too_far_ahead');

  const SlotReason(this.wire);
  final String wire;

  static SlotReason fromWire(String v) =>
      values.firstWhere((r) => r.wire == v, orElse: () => SlotReason.closed);
}

/// Venue cancellation policy (`venue.cancellation_mode`).
enum CancellationMode {
  @JsonValue('anytime')
  anytime('anytime'),
  @JsonValue('grace')
  grace('grace'),
  @JsonValue('never')
  never('never');

  const CancellationMode(this.wire);
  final String wire;

  static CancellationMode fromWire(String v) => values.firstWhere(
        (m) => m.wire == v,
        orElse: () => CancellationMode.anytime,
      );
}

/// White-label accent presets (`venue.theme`).
enum VenueTheme {
  @JsonValue('pine')
  pine('pine'),
  @JsonValue('ocean')
  ocean('ocean'),
  @JsonValue('violet')
  violet('violet'),
  @JsonValue('sunset')
  sunset('sunset'),
  @JsonValue('rose')
  rose('rose'),
  @JsonValue('slate')
  slate('slate');

  const VenueTheme(this.wire);
  final String wire;

  static VenueTheme fromWire(String? v) =>
      values.firstWhere((t) => t.wire == v, orElse: () => VenueTheme.pine);
}

/// What a space is; picks the photo placeholder glyph.
enum SpaceKind {
  @JsonValue('court')
  court('court'),
  @JsonValue('room')
  room('room'),
  @JsonValue('studio')
  studio('studio'),
  @JsonValue('table')
  table('table'),
  @JsonValue('tour')
  tour('tour'),
  @JsonValue('other')
  other('other');

  const SpaceKind(this.wire);
  final String wire;

  static SpaceKind fromWire(String? v) =>
      values.firstWhere((k) => k.wire == v, orElse: () => SpaceKind.other);

  String get label => switch (this) {
        SpaceKind.court => 'Court',
        SpaceKind.room => 'Room',
        SpaceKind.studio => 'Studio',
        SpaceKind.table => 'Table',
        SpaceKind.tour => 'Tour',
        SpaceKind.other => 'Other',
      };
}

enum WaitlistStatus {
  @JsonValue('waiting')
  waiting('waiting'),
  @JsonValue('notified')
  notified('notified'),
  @JsonValue('converted')
  converted('converted'),
  @JsonValue('expired')
  expired('expired');

  const WaitlistStatus(this.wire);
  final String wire;

  static WaitlistStatus fromWire(String v) =>
      values.firstWhere((s) => s.wire == v, orElse: () => WaitlistStatus.waiting);
}

/// Platform subscription state (`subscription.status`).
enum BillingStatus {
  @JsonValue('trialing')
  trialing('trialing'),
  @JsonValue('active')
  active('active'),
  @JsonValue('past_due')
  pastDue('past_due'),
  @JsonValue('cancelled')
  cancelled('cancelled'),
  @JsonValue('comped')
  comped('comped');

  const BillingStatus(this.wire);
  final String wire;

  static BillingStatus fromWire(String v) => values.firstWhere(
        (s) => s.wire == v,
        orElse: () => BillingStatus.trialing,
      );
}

/// Platform billing policy constants, shared by the billing feature and the
/// fake world that has to seed a suspended venue.
abstract final class BillingPolicy {
  /// Days a venue stays live after its free month or paid period ends
  /// (`GRACE_DAYS` in `src/lib/billing.ts`).
  static const graceDays = 10;

  /// Marks a suspension the billing system created for non-payment. The exact
  /// string is the contract: an approved payment clears a suspension with this
  /// reason and only this reason, so an admin's manual suspension survives.
  static const suspendReason = 'Overdue — unpaid past the grace period';
}
