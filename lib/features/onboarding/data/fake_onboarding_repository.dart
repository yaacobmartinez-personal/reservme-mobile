import '../../../core/config/app_config.dart';
import '../../../core/fake/fake_latency.dart';
import '../../../core/fake/fake_store.dart';
import '../../../core/model/enums.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/token_codec.dart';
import '../../../core/time/clock.dart';
import '../../auth/domain/auth_repository.dart';
import '../../auth/domain/user.dart';
import '../../venue/venues/domain/venue_membership.dart';
import '../domain/onboarding_input.dart';
import '../domain/onboarding_repository.dart';

/// In-memory [OnboardingRepository], built from the web's signup path
/// (`login-form.tsx` → Better Auth `signUp.email` + `organization.create` →
/// `/api/venue/init`) and the `createSpace` / `setOpeningHours` /
/// `updateVenueSettings` actions.
///
/// Each step commits, so someone who stops after "create venue" comes back to
/// a real venue rather than a half-filled form.
class FakeOnboardingRepository implements OnboardingRepository {
  FakeOnboardingRepository(this._store, this._latency, this._clock, this._offline, this._token);

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;

  /// The token the app is holding, so the steps after signup know who is
  /// asking — the same way the server reads the session.
  final String? Function() _token;

  static const _ttl = Duration(days: 30);

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  FakeUser _me() {
    final token = _token();
    final id = token == null ? null : TokenCodec.subject(token);
    final user = id == null ? null : _store.userById(id);
    if (user == null) {
      throw ApiError(401, 'Your session has expired. Sign in again.');
    }
    return user;
  }

  FakeVenue _venue(String slug) {
    final v = _store.venueBySlug(slug);
    if (v == null) throw ApiError(404, 'We could not find that venue.');
    return v;
  }

  @override
  Future<AuthResult> signUp(SignupInput input) async {
    await _tick();
    final message = input.validate();
    if (message != null) throw ApiError(400, message);

    final email = input.email.trim().toLowerCase();
    if (_store.userByEmail(email) != null) {
      // Better Auth's own wording for a taken address.
      throw ApiError(409, 'An account with that email already exists.');
    }

    final user = FakeUser(
      id: _store.nextId('u'),
      email: email,
      name: input.name.trim(),
      password: input.password,
      createdAt: _clock(),
    );
    _store.users.add(user);
    _sendCode(user, FakeEmailKind.verify);

    return AuthResult(
      token: TokenCodec.mintFake(user.id, _clock().add(_ttl)),
      user: User(id: user.id, email: user.email, name: user.name),
    );
  }

  @override
  Future<void> verifyEmail(String code) async {
    await _tick();
    final user = _me();
    final expected = _store.emailCodes[user.email.toLowerCase()];
    if (expected == null || code.trim() != expected) {
      throw ApiError(400, "That code doesn't match. Check the email again.");
    }
    user.emailVerified = true;
    _store.emailCodes.remove(user.email.toLowerCase());
  }

  @override
  Future<void> resendVerification() async {
    await _tick();
    _sendCode(_me(), FakeEmailKind.verify);
  }

  @override
  Future<SlugCheck> checkSlug(String slug) async {
    await _tick();
    final wanted = slug.trim().toLowerCase();
    final message = VenueInput(
      name: 'x',
      slug: wanted,
      timezone: 'Asia/Manila',
      currency: 'PHP',
    ).validate();
    if (message != null) {
      return SlugCheck(slug: wanted, available: false, reason: message);
    }
    if (_store.venueBySlug(wanted) != null) {
      return SlugCheck(
        slug: wanted,
        available: false,
        reason: 'Another venue has that address.',
      );
    }
    return SlugCheck(slug: wanted, available: true);
  }

  @override
  Future<VenueMembership> createVenue(VenueInput input) async {
    await _tick();
    final user = _me();
    final message = input.validate();
    if (message != null) throw ApiError(400, message);

    final slug = input.slug.trim().toLowerCase();
    if (_store.venueBySlug(slug) != null) {
      throw ApiError(409, 'Another venue has that address.');
    }

    final venue = FakeVenue(
      id: _store.nextId('v'),
      slug: slug,
      name: input.name.trim(),
      address: (input.address ?? '').trim().isEmpty ? null : input.address!.trim(),
      timezone: input.timezone,
      currency: input.currency.toUpperCase(),
      createdAt: _clock(),
    );
    _store.venues.add(venue);
    _store.memberships.add(FakeMembership(
      id: _store.nextId('m'),
      userId: user.id,
      venueId: venue.id,
      role: VenueRole.owner,
      createdAt: _clock(),
    ));
    // The free month starts at signup, like `/api/venue/init`.
    _store.subscriptions.add(FakeSubscription(
      venueId: venue.id,
      trialEndsAt: _clock().add(const Duration(days: 30)),
    ));

    return _membership(venue, VenueRole.owner);
  }

  @override
  Future<String> createFirstSpace(String venueSlug, FirstSpaceInput input) async {
    await _tick();
    final venue = _venue(venueSlug);
    final message = input.validate();
    if (message != null) throw ApiError(400, message);

    final space = FakeSpace(
      id: _store.nextId('sp'),
      venueId: venue.id,
      name: input.name.trim(),
      slug: _uniqueSpaceSlug(venue.id, input.name),
      kind: input.kind,
      capacity: input.capacity,
      slotMinutes: input.slotMinutes,
      priceCents: input.priceCents,
      sortOrder: _store.spacesOf(venue.id).length,
      imageUrl: input.photoPath,
      createdAt: _clock(),
    );
    _store.spaces.add(space);

    // A space with no hours is unbookable, which would defeat the point of
    // adding one — the web seeds a daily window on create and so do we. O5
    // then replaces them wholesale.
    for (var weekday = 0; weekday < 7; weekday++) {
      _store.openingHours.add(FakeOpeningHours(
        spaceId: space.id,
        weekday: weekday,
        opensAt: '08:00',
        closesAt: '22:00',
      ));
    }
    return space.id;
  }

  @override
  Future<void> setHours(
    String venueSlug,
    String spaceId,
    HoursInput hours,
  ) async {
    await _tick();
    final venue = _venue(venueSlug);
    final space = _store.spaceById(spaceId);
    if (space == null || space.venueId != venue.id) {
      throw ApiError(404, 'That space no longer exists.');
    }
    final message = hours.validate();
    if (message != null) throw ApiError(400, message);

    // Replace, don't merge — `setOpeningHours` deletes the space's rows and
    // writes the usable ones back, so a day switched off simply has no row.
    _store.openingHours.removeWhere((h) => h.spaceId == spaceId);
    for (final day in hours.days.where((d) => d.isUsable)) {
      _store.openingHours.add(FakeOpeningHours(
        spaceId: spaceId,
        weekday: day.weekday,
        opensAt: day.opensAt,
        closesAt: day.closesAt,
      ));
    }
  }

  @override
  Future<LiveVenue> goLive(String venueSlug, PolicyInput policy) async {
    await _tick();
    final user = _me();
    final venue = _venue(venueSlug);
    final message = policy.validate();
    if (message != null) throw ApiError(400, message);

    venue.cancellationMode = policy.cancellationMode;
    venue.cancellationGraceHours = policy.graceHours;
    venue.minNoticeMinutes = policy.minNoticeMinutes;
    venue.maxHorizonDays = policy.maxHorizonDays;

    final role = _store.membership(user.id, venue.id)?.role ?? VenueRole.owner;
    return LiveVenue(
      membership: _membership(venue, role),
      bookingUrl: '${AppConfig.publicOrigin}/${venue.slug}',
      spaceName: _store.spacesOf(venue.id).firstOrNull?.name ?? 'your space',
    );
  }

  // ---- helpers ------------------------------------------------------------

  VenueMembership _membership(FakeVenue venue, VenueRole role) => VenueMembership(
        orgId: venue.id,
        slug: venue.slug,
        name: venue.name,
        role: role,
        timezone: venue.timezone,
        currency: venue.currency,
        theme: venue.theme,
        suspended: venue.suspended,
        activeSpaces: _store.spacesOf(venue.id, activeOnly: true).length,
      );

  String _uniqueSpaceSlug(String venueId, String name) {
    final base = VenueInput.slugify(name, fallbackPrefix: 'space');
    final taken = _store.spacesOf(venueId).map((s) => s.slug).toSet();
    if (!taken.contains(base)) return base;
    for (var n = 2; n < 999; n++) {
      if (!taken.contains('$base-$n')) return '$base-$n';
    }
    return '$base-${_clock().millisecondsSinceEpoch.toRadixString(36)}';
  }

  void _sendCode(FakeUser user, FakeEmailKind kind) {
    final code = (100000 + (user.id.hashCode.abs() % 900000)).toString();
    _store.emailCodes[user.email.toLowerCase()] = code;
    _store.outbox.add(FakeEmail(
      to: user.email,
      kind: kind,
      body: 'Your ReservMe code is $code.',
      sentAt: _clock(),
    ));
  }
}
