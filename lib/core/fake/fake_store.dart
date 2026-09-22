import '../model/enums.dart';

/// An in-memory picture of the server's database, shaped like the tables in
/// the web schema (`drizzle/*.sql`). Every `Fake*Repository` reads and
/// mutates this one store, so the customer and venue sides of the app see
/// each other's changes exactly as they would through the real API.
///
/// Entities are plain mutable classes on purpose: this is a test double, not
/// domain code. Domain models live in each feature and are built from these.

class FakeUser {
  FakeUser({
    required this.id,
    required this.email,
    required this.name,
    this.password,
    this.emailVerified = false,
    required this.createdAt,
  });

  final String id;
  String email;
  String? name;
  String? password;
  bool emailVerified;
  final DateTime createdAt;
}

/// `organization` + `venue` (they share a primary key on the web).
class FakeVenue {
  FakeVenue({
    required this.id,
    required this.slug,
    required this.name,
    this.tagline,
    this.address,
    this.timezone = 'Asia/Manila',
    this.currency = 'PHP',
    this.theme = VenueTheme.pine,
    this.logoUrl,
    this.coverUrl,
    this.minNoticeMinutes = 60,
    this.maxHorizonDays = 60,
    this.cancellationMode = CancellationMode.grace,
    this.cancellationGraceHours = 24,
    this.refundTerms,
    this.gcashName,
    this.suspendedAt,
    this.suspendedReason,
    required this.createdAt,
  });

  final String id;
  String slug;
  String name;
  String? tagline;
  String? address;
  String timezone;
  String currency;
  VenueTheme theme;
  String? logoUrl;
  String? coverUrl;
  int minNoticeMinutes;
  int maxHorizonDays;
  CancellationMode cancellationMode;
  int cancellationGraceHours;
  String? refundTerms;
  String? gcashName;
  DateTime? suspendedAt;
  String? suspendedReason;
  final DateTime createdAt;

  bool get suspended => suspendedAt != null;
}

class FakeMembership {
  FakeMembership({
    required this.id,
    required this.userId,
    required this.venueId,
    required this.role,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final String venueId;
  VenueRole role;
  final DateTime createdAt;
}

class FakeInvitation {
  FakeInvitation({
    required this.id,
    required this.venueId,
    required this.email,
    required this.role,
    required this.expiresAt,
    required this.createdAt,
  });

  final String id;
  final String venueId;
  final String email;
  final VenueRole role;
  final DateTime expiresAt;
  final DateTime createdAt;
}

class FakeSpace {
  FakeSpace({
    required this.id,
    required this.venueId,
    required this.name,
    required this.slug,
    this.kind = SpaceKind.court,
    this.capacity = 4,
    this.slotMinutes = 60,
    this.bufferMinutes = 0,
    required this.priceCents,
    this.isActive = true,
    this.sortOrder = 0,
    this.imageUrl,
    required this.createdAt,
  });

  final String id;
  final String venueId;
  String name;
  String slug;
  SpaceKind kind;
  int capacity;
  int slotMinutes;
  int bufferMinutes;
  int priceCents;
  bool isActive;
  int sortOrder;
  String? imageUrl;
  final DateTime createdAt;
}

/// Weekly hours as local time-of-day, never instants (`opening_hours`).
class FakeOpeningHours {
  FakeOpeningHours({
    required this.spaceId,
    required this.weekday,
    required this.opensAt,
    required this.closesAt,
  });

  final String spaceId;

  /// 0 = Sunday … 6 = Saturday.
  final int weekday;

  /// "HH:MM" local.
  String opensAt;
  String closesAt;
}

class FakeClosure {
  FakeClosure({
    required this.id,
    required this.venueId,
    this.spaceId,
    required this.startsAt,
    required this.endsAt,
    this.reason,
  });

  final String id;
  final String venueId;

  /// Null = the whole venue.
  final String? spaceId;
  DateTime startsAt;
  DateTime endsAt;
  String? reason;
}

/// Peak / off-peak override on a space for some weekdays and a local window.
class FakePricingRule {
  FakePricingRule({
    required this.id,
    required this.spaceId,
    required this.weekdays,
    required this.startsAt,
    required this.endsAt,
    required this.priceCents,
    this.label,
  });

  final String id;
  final String spaceId;
  List<int> weekdays;
  String startsAt;
  String endsAt;
  int priceCents;
  String? label;
}

/// Open play / classes: shared capacity on a space (`play_session`).
class FakeSession {
  FakeSession({
    required this.id,
    required this.venueId,
    required this.spaceId,
    required this.title,
    required this.startsAt,
    required this.endsAt,
    required this.capacity,
    this.bookedSpots = 0,
    required this.pricePerPersonCents,
    this.cancelled = false,
  });

  final String id;
  final String venueId;
  final String spaceId;
  String title;
  DateTime startsAt;
  DateTime endsAt;
  int capacity;
  int bookedSpots;
  int pricePerPersonCents;
  bool cancelled;

  int get spotsLeft => capacity - bookedSpots;
}

/// A customer is a per-venue record, never a login.
class FakeCustomer {
  FakeCustomer({
    required this.id,
    required this.venueId,
    required this.name,
    required this.email,
    this.phone,
    this.noShowCount = 0,
    List<String>? tags,
    this.marketingOptIn = false,
    this.loyaltyPoints = 0,
    required this.createdAt,
  }) : tags = tags ?? [];

  final String id;
  final String venueId;
  String name;
  String email;
  String? phone;
  int noShowCount;
  List<String> tags;
  bool marketingOptIn;
  int loyaltyPoints;
  final DateTime createdAt;
}

class FakeCustomerNote {
  FakeCustomerNote({
    required this.id,
    required this.customerId,
    required this.authorUserId,
    required this.body,
    required this.createdAt,
  });

  final String id;
  final String customerId;
  final String authorUserId;
  String body;
  final DateTime createdAt;
}

class FakeReservation {
  FakeReservation({
    required this.id,
    required this.venueId,
    required this.spaceId,
    this.sessionId,
    this.customerId,
    this.kind = ReservationKind.rental,
    this.status = ReservationStatus.confirmed,
    required this.startsAt,
    required this.endsAt,
    this.partySize = 1,
    this.amountCents = 0,
    this.holdExpiresAt,
    this.checkedInAt,
    this.cancelledAt,
    required this.reference,
    required this.manageToken,
    this.notes,
    this.blockReason,
    required this.createdAt,
  });

  final String id;
  final String venueId;
  String spaceId;
  final String? sessionId;
  final String? customerId;
  ReservationKind kind;
  ReservationStatus status;
  DateTime startsAt;
  DateTime endsAt;
  int partySize;
  int amountCents;
  DateTime? holdExpiresAt;
  DateTime? checkedInAt;
  DateTime? cancelledAt;
  final String reference;
  final String manageToken;
  String? notes;

  /// Set on staff block-offs (a `session_block` with no session).
  String? blockReason;
  final DateTime createdAt;

  bool get isBlock => kind == ReservationKind.sessionBlock && sessionId == null;
}

class FakeWaitlistEntry {
  FakeWaitlistEntry({
    required this.id,
    required this.venueId,
    required this.spaceId,
    required this.customerId,
    required this.startsAt,
    required this.endsAt,
    this.status = WaitlistStatus.waiting,
    this.notifiedAt,
    this.claimExpiresAt,
    required this.createdAt,
  });

  final String id;
  final String venueId;
  final String spaceId;
  final String customerId;
  final DateTime startsAt;
  final DateTime endsAt;
  WaitlistStatus status;
  DateTime? notifiedAt;
  DateTime? claimExpiresAt;
  final DateTime createdAt;
}

class FakeSubscription {
  FakeSubscription({
    required this.venueId,
    this.status = BillingStatus.trialing,
    required this.trialEndsAt,
    this.paidUntil,
  });

  final String venueId;
  BillingStatus status;
  DateTime trialEndsAt;
  DateTime? paidUntil;
}

class FakeBillingPayment {
  FakeBillingPayment({
    required this.id,
    required this.venueId,
    required this.amountCents,
    required this.reference,
    this.status = 'submitted',
    required this.createdAt,
  });

  final String id;
  final String venueId;
  final int amountCents;
  final String reference;
  String status;
  final DateTime createdAt;
}

class FakeStore {
  FakeStore();

  final users = <FakeUser>[];
  final venues = <FakeVenue>[];
  final memberships = <FakeMembership>[];
  final invitations = <FakeInvitation>[];
  final spaces = <FakeSpace>[];
  final openingHours = <FakeOpeningHours>[];
  final closures = <FakeClosure>[];
  final pricingRules = <FakePricingRule>[];
  final sessions = <FakeSession>[];
  final customers = <FakeCustomer>[];
  final customerNotes = <FakeCustomerNote>[];
  final reservations = <FakeReservation>[];
  final waitlist = <FakeWaitlistEntry>[];
  final subscriptions = <FakeSubscription>[];
  final billingPayments = <FakeBillingPayment>[];

  /// Email → 6-digit code the fake server "sent" (verification / reset).
  final emailCodes = <String, String>{};

  /// Emails the fake server would have sent, newest last.
  final outbox = <FakeEmail>[];

  int _sequence = 0;

  /// Deterministic ids (u_1, sp_12, …) so tests and fixtures can name them.
  String nextId(String prefix) => '${prefix}_${++_sequence}';

  // ---- lookups ------------------------------------------------------------

  FakeUser? userById(String id) => users.where((u) => u.id == id).firstOrNull;

  FakeUser? userByEmail(String email) {
    final needle = email.trim().toLowerCase();
    return users.where((u) => u.email.toLowerCase() == needle).firstOrNull;
  }

  FakeVenue? venueById(String id) => venues.where((v) => v.id == id).firstOrNull;

  FakeVenue? venueBySlug(String slug) =>
      venues.where((v) => v.slug == slug.trim().toLowerCase()).firstOrNull;

  FakeMembership? membership(String userId, String venueId) => memberships
      .where((m) => m.userId == userId && m.venueId == venueId)
      .firstOrNull;

  Iterable<FakeMembership> membershipsOf(String userId) =>
      memberships.where((m) => m.userId == userId);

  Iterable<FakeMembership> membersOf(String venueId) =>
      memberships.where((m) => m.venueId == venueId);

  FakeSpace? spaceById(String id) => spaces.where((s) => s.id == id).firstOrNull;

  Iterable<FakeSpace> spacesOf(String venueId, {bool activeOnly = false}) {
    final all = spaces.where((s) => s.venueId == venueId && (!activeOnly || s.isActive)).toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return all;
  }

  Iterable<FakeOpeningHours> hoursOf(String spaceId) =>
      openingHours.where((h) => h.spaceId == spaceId);

  Iterable<FakePricingRule> rulesOf(String spaceId) =>
      pricingRules.where((r) => r.spaceId == spaceId);

  Iterable<FakeClosure> closuresOf(String venueId) =>
      closures.where((c) => c.venueId == venueId);

  Iterable<FakeSession> sessionsOf(String venueId) =>
      sessions.where((s) => s.venueId == venueId && !s.cancelled);

  FakeSession? sessionById(String id) => sessions.where((s) => s.id == id).firstOrNull;

  FakeCustomer? customerById(String id) => customers.where((c) => c.id == id).firstOrNull;

  FakeCustomer? customerByEmail(String venueId, String email) {
    final needle = email.trim().toLowerCase();
    return customers
        .where((c) => c.venueId == venueId && c.email.toLowerCase() == needle)
        .firstOrNull;
  }

  Iterable<FakeCustomer> customersOf(String venueId) =>
      customers.where((c) => c.venueId == venueId);

  FakeReservation? reservationById(String id) =>
      reservations.where((r) => r.id == id).firstOrNull;

  FakeReservation? reservationByToken(String venueId, String token) => reservations
      .where((r) => r.venueId == venueId && r.manageToken == token)
      .firstOrNull;

  Iterable<FakeReservation> reservationsOf(String venueId) =>
      reservations.where((r) => r.venueId == venueId);

  /// Live rows on a space that overlap [start, end) — what the exclusion
  /// constraint would reject.
  Iterable<FakeReservation> liveOverlapping(String spaceId, DateTime start, DateTime end) =>
      reservations.where((r) =>
          r.spaceId == spaceId &&
          r.status.isLive &&
          r.kind != ReservationKind.sessionSeat &&
          r.startsAt.isBefore(end) &&
          r.endsAt.isAfter(start));

  Iterable<FakeWaitlistEntry> waitlistOf(String venueId) =>
      waitlist.where((w) => w.venueId == venueId);

  FakeSubscription? subscriptionOf(String venueId) =>
      subscriptions.where((s) => s.venueId == venueId).firstOrNull;
}

/// A message the fake server "sent". Codes surface here so fake mode can
/// complete flows that need an inbox.
class FakeEmail {
  FakeEmail({
    required this.to,
    required this.kind,
    required this.body,
    required this.sentAt,
  });

  final String to;
  final FakeEmailKind kind;
  final String body;
  final DateTime sentAt;
}

enum FakeEmailKind { verify, reset, invite, confirmation, reminder, waitlistClaim }
