import 'dart:math';

import '../model/enums.dart';
import '../time/app_time.dart';
import 'fake_store.dart';

/// Demo accounts for fake mode. Passwords are plain text here because this is
/// a test double that never leaves the device.
abstract final class FakeAccounts {
  /// Owner of Katipunan Courts and Studio Norte.
  static const ownerEmail = 'owner@reservme.test';

  /// Front-desk staff at Katipunan only.
  static const staffEmail = 'staff@reservme.test';

  static const password = 'password123';
}

/// Slugs the seed creates, so screens and tests can name them.
abstract final class FakeVenues {
  static const katipunan = 'katipunan';
  static const studioNorte = 'studio-norte';

  /// Suspended for non-payment, so the billing and settings screens have a
  /// venue that is actually switched off to render.
  static const marikinaFutsal = 'marikina-futsal';
}

const _firstNames = [
  'Maria', 'Jun', 'Paolo', 'Ana', 'Kim', 'Rico', 'Ben', 'Liza', 'Marco', 'Jen',
  'Carlo', 'Dianne', 'Erik', 'Faye', 'Gio', 'Hannah', 'Ivan', 'Joy', 'Ken', 'Lea',
  'Miguel', 'Nica', 'Oscar', 'Pia', 'Ramon', 'Sofia', 'Tony', 'Una', 'Vic', 'Wilma',
];

const _lastNames = [
  'Santos', 'Reyes', 'Dizon', 'Cruz', 'Lim', 'Mendoza', 'Tan', 'Bautista',
  'Villanueva', 'Garcia', 'Torres', 'Flores', 'Ramos', 'Aquino', 'Castillo',
  'Navarro', 'Dela Cruz', 'Gonzales', 'Fernandez', 'Ocampo',
];

/// Populate [store] with a coherent world relative to [now] (UTC).
///
/// Venues:
///  - `katipunan` (Katipunan Courts, Asia/Manila): 4 badminton courts + a
///    paused annex, peak pricing, open play on Court 4 Tue/Thu, a closure,
///    ~60 bookings across the last two weeks and the next week including a
///    full run sheet for today, customers with tags/notes/no-shows, waitlist.
///  - `studio-norte` (Studio Norte, Europe/Madrid): two studios, so a DST
///    zone is always exercised.
///  - `marikina-futsal`: suspended for unpaid billing.
void seedFakeStore(FakeStore store, DateTime now) {
  final rnd = Random(26);
  final t0 = now.toUtc().subtract(const Duration(days: 90));

  // --- users ---------------------------------------------------------------
  final owner = FakeUser(
    id: store.nextId('u'),
    email: FakeAccounts.ownerEmail,
    name: 'Rafael Katipunan',
    password: FakeAccounts.password,
    emailVerified: true,
    createdAt: t0,
  );
  final staff = FakeUser(
    id: store.nextId('u'),
    email: FakeAccounts.staffEmail,
    name: 'Marco Bautista',
    password: FakeAccounts.password,
    emailVerified: true,
    createdAt: t0.add(const Duration(days: 20)),
  );
  final admin = FakeUser(
    id: store.nextId('u'),
    email: 'andrea@katipunancourts.ph',
    name: 'Andrea Dela Cruz',
    password: FakeAccounts.password,
    emailVerified: true,
    createdAt: t0.add(const Duration(days: 5)),
  );
  store.users.addAll([owner, staff, admin]);

  // --- venues --------------------------------------------------------------
  final katipunan = FakeVenue(
    id: store.nextId('v'),
    slug: FakeVenues.katipunan,
    name: 'Katipunan Courts',
    tagline: 'Four wooden courts, shuttles on sale, showers. Walk-ins welcome after 9 PM.',
    address: '12 Esteban Abada St, Loyola Heights, Quezon City',
    gcashName: 'R. Katipunan',
    refundTerms: 'Prepaid sessions are non-refundable within 24 hours of the start.',
    createdAt: t0.subtract(const Duration(days: 12)),
  );
  final norte = FakeVenue(
    id: store.nextId('v'),
    slug: FakeVenues.studioNorte,
    name: 'Studio Norte',
    tagline: 'Dance and rehearsal studios with sprung floors and mirrors.',
    address: 'Calle de Bravo Murillo 88, Madrid',
    timezone: 'Europe/Madrid',
    currency: 'EUR',
    theme: VenueTheme.violet,
    cancellationMode: CancellationMode.anytime,
    createdAt: t0.add(const Duration(days: 30)),
  );
  final marikina = FakeVenue(
    id: store.nextId('v'),
    slug: FakeVenues.marikinaFutsal,
    name: 'Marikina Futsal',
    timezone: 'Asia/Manila',
    theme: VenueTheme.ocean,
    suspendedAt: now.subtract(const Duration(days: 3)),
    // The exact string billing keys off: paying lifts a suspension with
    // this reason and no other.
    suspendedReason: BillingPolicy.suspendReason,
    createdAt: t0.subtract(const Duration(days: 60)),
  );
  store.venues.addAll([katipunan, norte, marikina]);

  for (final v in [katipunan, norte, marikina]) {
    store.subscriptions.add(FakeSubscription(
      venueId: v.id,
      status: v == marikina ? BillingStatus.pastDue : BillingStatus.trialing,
      trialEndsAt: v == marikina
          ? now.subtract(const Duration(days: 40))
          : v.createdAt.add(const Duration(days: 30)).isAfter(now)
              ? v.createdAt.add(const Duration(days: 30))
              : now.add(const Duration(days: 20)),
      // A past-due venue must have a lapsed paid period, or billing's own
      // rule (`status IN ('active','past_due') AND paid_until < now`) never
      // fires and a suspended venue reads as owing nothing.
      paidUntil: v == marikina ? now.subtract(const Duration(days: 13)) : null,
    ));
  }

  store.memberships.addAll([
    FakeMembership(id: store.nextId('m'), userId: owner.id, venueId: katipunan.id, role: VenueRole.owner, createdAt: t0),
    FakeMembership(id: store.nextId('m'), userId: owner.id, venueId: norte.id, role: VenueRole.owner, createdAt: t0),
    FakeMembership(id: store.nextId('m'), userId: owner.id, venueId: marikina.id, role: VenueRole.owner, createdAt: t0),
    FakeMembership(id: store.nextId('m'), userId: admin.id, venueId: katipunan.id, role: VenueRole.admin, createdAt: t0),
    FakeMembership(id: store.nextId('m'), userId: staff.id, venueId: katipunan.id, role: VenueRole.member, createdAt: t0),
  ]);
  store.invitations.add(FakeInvitation(
    id: store.nextId('inv'),
    venueId: katipunan.id,
    email: 'jen@katipunancourts.ph',
    role: VenueRole.member,
    expiresAt: now.add(const Duration(hours: 30)),
    createdAt: now.subtract(const Duration(hours: 18)),
  ));

  // --- spaces & hours --------------------------------------------------------
  FakeSpace addSpace(FakeVenue v, String name, {SpaceKind kind = SpaceKind.court, int price = 35000, int slot = 60, int capacity = 4, bool active = true, int order = 0, String? image}) {
    final s = FakeSpace(
      id: store.nextId('sp'),
      venueId: v.id,
      name: name,
      slug: name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-'),
      kind: kind,
      capacity: capacity,
      slotMinutes: slot,
      priceCents: price,
      isActive: active,
      sortOrder: order,
      imageUrl: image,
      createdAt: v.createdAt,
    );
    store.spaces.add(s);
    return s;
  }

  void hours(FakeSpace s, {String weekdayOpen = '09:00', String weekdayClose = '23:00', String satOpen = '08:00', String satClose = '23:00', bool sunday = false}) {
    for (var d = 1; d <= 5; d++) {
      store.openingHours.add(FakeOpeningHours(spaceId: s.id, weekday: d, opensAt: weekdayOpen, closesAt: weekdayClose));
    }
    store.openingHours.add(FakeOpeningHours(spaceId: s.id, weekday: 6, opensAt: satOpen, closesAt: satClose));
    if (sunday) {
      store.openingHours.add(FakeOpeningHours(spaceId: s.id, weekday: 0, opensAt: satOpen, closesAt: satClose));
    }
  }

  final court1 = addSpace(katipunan, 'Court 1', order: 1);
  final court2 = addSpace(katipunan, 'Court 2', order: 2);
  final court3 = addSpace(katipunan, 'Court 3', order: 3);
  final court4 = addSpace(katipunan, 'Court 4', order: 4, price: 30000);
  addSpace(katipunan, 'Court 5 (annex)', order: 5, active: false);
  for (final c in [court1, court2, court3, court4]) {
    hours(c, sunday: true);
  }
  // Peak: weekday evenings and all weekend on Court 1 & 3.
  for (final c in [court1, court3]) {
    store.pricingRules.add(FakePricingRule(id: store.nextId('pr'), spaceId: c.id, weekdays: [1, 2, 3, 4, 5], startsAt: '17:00', endsAt: '22:00', priceCents: 45000, label: 'Weekday peak'));
    store.pricingRules.add(FakePricingRule(id: store.nextId('pr'), spaceId: c.id, weekdays: [0, 6], startsAt: '08:00', endsAt: '23:00', priceCents: 45000, label: 'Weekend'));
  }

  final studioA = addSpace(norte, 'Studio A', kind: SpaceKind.studio, price: 2400, capacity: 12, order: 1);
  final studioB = addSpace(norte, 'Studio B', kind: SpaceKind.studio, price: 1800, capacity: 8, order: 2);
  hours(studioA, weekdayOpen: '10:00', weekdayClose: '22:00', satOpen: '10:00', satClose: '20:00');
  hours(studioB, weekdayOpen: '10:00', weekdayClose: '22:00', satOpen: '10:00', satClose: '20:00');

  final pitch = addSpace(marikina, 'Pitch 1', price: 120000, capacity: 10, order: 1);
  hours(pitch);

  // A whole-venue closure next month.
  final closureStart = AppTime.fromLocal(AppTime.addDays(AppTime.today(now, katipunan.timezone), 34, katipunan.timezone), '00:00', katipunan.timezone)!;
  store.closures.add(FakeClosure(
    id: store.nextId('cl'),
    venueId: katipunan.id,
    startsAt: closureStart,
    endsAt: closureStart.add(const Duration(days: 1)),
    reason: 'Floor resurfacing',
  ));

  // --- customers -----------------------------------------------------------
  final customers = <FakeCustomer>[];
  for (var i = 0; i < 40; i++) {
    final first = _firstNames[i % _firstNames.length];
    final last = _lastNames[(i * 7) % _lastNames.length];
    final c = FakeCustomer(
      id: store.nextId('c'),
      venueId: katipunan.id,
      name: '$first $last',
      email: '${first.toLowerCase()}.${last.toLowerCase().replaceAll(' ', '')}@example.com',
      phone: '09${(17 + i % 3)}${(5550000 + i * 137).toString().padLeft(7, '0')}',
      noShowCount: i == 2 ? 2 : (i % 11 == 0 ? 1 : 0),
      tags: [if (i % 4 == 0) 'Regular', if (i % 9 == 0) 'Weekday league', if (i == 3) 'Membership'],
      loyaltyPoints: (i * 13) % 80,
      createdAt: t0.add(Duration(days: i * 2)),
    );
    customers.add(c);
  }
  store.customers.addAll(customers);
  store.customerNotes.add(FakeCustomerNote(
    id: store.nextId('n'),
    customerId: customers[1].id,
    authorUserId: owner.id,
    body: 'Prefers Court 3 — says the lighting is better. Brings his own shuttles.',
    createdAt: now.subtract(const Duration(days: 8)),
  ));

  // --- open play sessions (Court 4, Tue & Thu 20:00–22:00) --------------------
  final zone = katipunan.timezone;
  final today = AppTime.today(now, zone);
  for (var d = -14; d <= 21; d++) {
    final date = AppTime.addDays(today, d, zone);
    final wd = AppTime.weekday(date, zone);
    if (wd != 2 && wd != 4) continue;
    final start = AppTime.fromLocal(date, '20:00', zone)!;
    final s = FakeSession(
      id: store.nextId('ses'),
      venueId: katipunan.id,
      spaceId: court4.id,
      title: 'Open play',
      startsAt: start,
      endsAt: start.add(const Duration(hours: 2)),
      capacity: 12,
      bookedSpots: d < 0 ? 12 : 7,
      pricePerPersonCents: 15000,
    );
    store.sessions.add(s);
    store.reservations.add(FakeReservation(
      id: store.nextId('r'),
      venueId: katipunan.id,
      spaceId: court4.id,
      sessionId: s.id,
      kind: ReservationKind.sessionBlock,
      startsAt: s.startsAt,
      endsAt: s.endsAt,
      reference: _reference(rnd),
      manageToken: _token(rnd),
      createdAt: t0,
    ));
  }

  // --- bookings ------------------------------------------------------------
  int priceFor(FakeSpace s, String date, String time) {
    final wd = AppTime.weekday(date, zone);
    for (final r in store.rulesOf(s.id)) {
      if (r.weekdays.contains(wd) && time.compareTo(r.startsAt) >= 0 && time.compareTo(r.endsAt) < 0) {
        return r.priceCents;
      }
    }
    return s.priceCents;
  }

  FakeReservation book(FakeSpace s, String date, String time, FakeCustomer c, {ReservationStatus status = ReservationStatus.confirmed, bool checkedIn = false, int party = 2, int hours = 1}) {
    final start = AppTime.fromLocal(date, time, zone)!;
    final r = FakeReservation(
      id: store.nextId('r'),
      venueId: katipunan.id,
      spaceId: s.id,
      customerId: c.id,
      status: status,
      startsAt: start,
      endsAt: start.add(Duration(hours: hours)),
      partySize: party,
      amountCents: priceFor(s, date, time) * hours,
      checkedInAt: checkedIn ? start.add(const Duration(minutes: -2)) : null,
      cancelledAt: status == ReservationStatus.cancelled ? start.subtract(const Duration(days: 1)) : null,
      reference: _reference(rnd),
      manageToken: _token(rnd),
      createdAt: start.subtract(Duration(days: 1 + rnd.nextInt(6))),
    );
    store.reservations.add(r);
    return r;
  }

  final courts = [court1, court2, court3];
  // Past two weeks: a realistic spread, some no-shows and cancellations.
  for (var d = -14; d < 0; d++) {
    final date = AppTime.addDays(today, d, zone);
    for (final c in courts) {
      for (final time in ['10:00', '17:00', '18:00', '19:00', '20:00']) {
        if (rnd.nextDouble() < 0.4) continue;
        final cust = customers[rnd.nextInt(customers.length)];
        final roll = rnd.nextDouble();
        book(c, date, time, cust,
            status: roll < 0.06 ? ReservationStatus.noShow : roll < 0.12 ? ReservationStatus.cancelled : ReservationStatus.confirmed,
            checkedIn: roll >= 0.12);
      }
    }
  }

  // Today's run sheet (the design canvas, V4). Times relative to the venue day.
  book(court3, today, '16:00', customers[3], checkedIn: true, party: 4);
  book(court3, today, '17:00', customers[1], checkedIn: true, party: 4);
  book(court1, today, '16:00', customers[3], checkedIn: true);
  book(court2, today, '17:00', customers[7]);
  final maria = book(court1, today, '18:00', customers[0], party: 1); // "Due now"
  book(court2, today, '18:00', customers[2]);
  book(court2, today, '19:00', customers[9]);
  book(court2, today, '21:00', customers[4]);
  // A hold on today's sheet, because real ones are always there: a booking
  // taken but not yet confirmed, with an expiry running on it. Without one the
  // demo world never shows the "Held" chip and no test can exercise it.
  book(court3, today, '20:00', customers[6], status: ReservationStatus.held);
  book(court1, today, '21:00', customers[11], party: 4);
  // Court 3 blocked 18:00–20:00 for net repair. A staff block is a closure,
  // not a reservation — same as the web's blockOff (calendar-actions.ts).
  final blockStart = AppTime.fromLocal(today, '18:00', zone)!;
  store.closures.add(FakeClosure(
    id: store.nextId('cl'),
    venueId: katipunan.id,
    spaceId: court3.id,
    startsAt: blockStart,
    endsAt: blockStart.add(const Duration(hours: 2)),
    reason: 'Net repair',
  ));

  // Next week: enough taken slots that the slot grid shows both states.
  for (var d = 1; d <= 7; d++) {
    final date = AppTime.addDays(today, d, zone);
    for (final c in courts) {
      for (final time in ['09:00', '12:00', '13:00', '19:00']) {
        if (rnd.nextDouble() < 0.5) continue;
        book(c, date, time, customers[rnd.nextInt(customers.length)]);
      }
    }
  }

  // Waitlist for a taken slot on Court 1 tomorrow.
  final tomorrow = AppTime.addDays(today, 1, zone);
  final wlStart = AppTime.fromLocal(tomorrow, '12:00', zone)!;
  if (store.liveOverlapping(court1.id, wlStart, wlStart.add(const Duration(hours: 1))).isEmpty) {
    book(court1, tomorrow, '12:00', customers[12]);
  }
  for (final (i, c) in [customers[3], customers[4]].indexed) {
    store.waitlist.add(FakeWaitlistEntry(
      id: store.nextId('wl'),
      venueId: katipunan.id,
      spaceId: court1.id,
      customerId: c.id,
      startsAt: wlStart,
      endsAt: wlStart.add(const Duration(hours: 1)),
      createdAt: now.subtract(Duration(hours: 2 - i)),
    ));
  }
  store.waitlist.add(FakeWaitlistEntry(
    id: store.nextId('wl'),
    venueId: katipunan.id,
    spaceId: court3.id,
    customerId: customers[5].id,
    startsAt: AppTime.fromLocal(tomorrow, '09:00', zone)!,
    endsAt: AppTime.fromLocal(tomorrow, '10:00', zone)!,
    status: WaitlistStatus.notified,
    notifiedAt: now.subtract(const Duration(minutes: 12)),
    claimExpiresAt: now.add(const Duration(minutes: 18)),
    createdAt: now.subtract(const Duration(days: 1)),
  ));

  // Studio Norte: a few bookings so the Madrid zone renders.
  final nzone = norte.timezone;
  final ntoday = AppTime.today(now, nzone);
  final nc = FakeCustomer(
    id: store.nextId('c'),
    venueId: norte.id,
    name: 'Lucía Ortega',
    email: 'lucia.ortega@example.com',
    phone: '+34 600 123 456',
    createdAt: t0,
  );
  store.customers.add(nc);
  for (final (d, time) in [(0, '18:00'), (1, '11:00'), (3, '19:00')]) {
    final start = AppTime.fromLocal(AppTime.addDays(ntoday, d, nzone), time, nzone)!;
    store.reservations.add(FakeReservation(
      id: store.nextId('r'),
      venueId: norte.id,
      spaceId: studioA.id,
      customerId: nc.id,
      startsAt: start,
      endsAt: start.add(const Duration(hours: 2)),
      partySize: 6,
      amountCents: studioA.priceCents * 2,
      reference: _reference(rnd),
      manageToken: _token(rnd),
      createdAt: now.subtract(const Duration(days: 2)),
    ));
  }

  // --- growth: plans, a holding, a promo, a review link (Katipunan) ---------
  // Seeded last, so every id minted above stays what it always was.
  katipunan.reviewUrl = 'https://g.page/katipunan-courts/review';
  final tenPack = FakePlan(
    id: store.nextId('plan'),
    venueId: katipunan.id,
    name: '10-game pass',
    kind: 'pass',
    priceCents: 450000,
    credits: 10,
    validDays: 90,
    createdAt: t0,
  );
  final club = FakePlan(
    id: store.nextId('plan'),
    venueId: katipunan.id,
    name: 'Club membership',
    kind: 'membership',
    priceCents: 99900,
    discountPct: 15,
    createdAt: t0,
  );
  store.plans.addAll([tenPack, club]);
  store.holdings.add(FakeHolding(
    id: store.nextId('hold'),
    venueId: katipunan.id,
    customerId: customers[3].id, // the one tagged 'Membership'
    planId: tenPack.id,
    creditsRemaining: 7,
    expiresAt: now.add(const Duration(days: 40)),
    createdAt: now.subtract(const Duration(days: 50)),
  ));
  store.promos.add(FakePromo(
    id: store.nextId('promo'),
    venueId: katipunan.id,
    code: 'WELCOME10',
    kind: 'percent',
    value: 10,
    maxUses: 100,
    uses: 12,
    createdAt: t0,
  ));

  // Keep the "Due now" booking's token stable for the canvas reference.
  assert(maria.customerId == customers[0].id);
}

const _refAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // no 0/O/1/I
String _reference(Random rnd) {
  String part(int n) => List.generate(n, (_) => _refAlphabet[rnd.nextInt(_refAlphabet.length)]).join();
  return '${part(3)}-${part(4)}';
}

String _token(Random rnd) =>
    List.generate(32, (_) => '0123456789abcdef'[rnd.nextInt(16)]).join();
