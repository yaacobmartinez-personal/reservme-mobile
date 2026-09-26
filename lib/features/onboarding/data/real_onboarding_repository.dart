import '../../../core/config/app_config.dart';
import '../../../core/config/feature_availability.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../auth/domain/auth_repository.dart';
import '../../auth/domain/user.dart';
import '../../venue/venues/domain/venue_membership.dart';
import '../domain/onboarding_input.dart';
import '../domain/onboarding_repository.dart';

/// [OnboardingRepository] over the HTTP API (API-CONTRACT #25–#29).
class RealOnboardingRepository implements OnboardingRepository {
  RealOnboardingRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard(Feature feature) {
    if (!isAvailable(feature, _mode)) throw ApiError.notAvailable();
  }

  @override
  Future<AuthResult> signUp(SignupInput input) async {
    _guard(Feature.signup);
    final json = await _api.post('/mobile/auth/signup', body: {
      'name': input.name.trim(),
      'email': input.email.trim().toLowerCase(),
      'password': input.password,
    });
    return AuthResult(
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  @override
  Future<void> verifyEmail(String code) async {
    _guard(Feature.signup);
    await _api.post('/mobile/auth/verify', body: {'code': code.trim()});
  }

  @override
  Future<void> resendVerification() async {
    _guard(Feature.signup);
    await _api.post('/mobile/auth/resend-verification');
  }

  @override
  Future<SlugCheck> checkSlug(String slug) async {
    _guard(Feature.onboarding);
    final json = await _api.get('/mobile/venues/slug-available', query: {
      'slug': slug.trim().toLowerCase(),
    });
    return SlugCheck(
      slug: slug.trim().toLowerCase(),
      available: json['available'] as bool? ?? false,
      reason: json['reason'] as String?,
    );
  }

  @override
  Future<VenueMembership> createVenue(VenueInput input) async {
    _guard(Feature.onboarding);
    final json = await _api.post('/mobile/venues', body: {
      'name': input.name.trim(),
      'slug': input.slug.trim().toLowerCase(),
      'timezone': input.timezone,
      'currency': input.currency.toUpperCase(),
      if ((input.address ?? '').trim().isNotEmpty) 'address': input.address!.trim(),
    });
    return VenueMembership.fromJson(json['venue'] as Map<String, dynamic>);
  }

  @override
  Future<String> createFirstSpace(String venueSlug, FirstSpaceInput input) async {
    _guard(Feature.onboarding);
    final json = await _api.post('/mobile/venues/$venueSlug/spaces', body: {
      'name': input.name.trim(),
      'kind': input.kind.wire,
      'slotMinutes': input.slotMinutes,
      'priceCents': input.priceCents,
      'capacity': input.capacity,
    });
    final space = json['space'] as Map<String, dynamic>;
    return space['id'] as String;
  }

  @override
  Future<void> setHours(
    String venueSlug,
    String spaceId,
    HoursInput hours,
  ) async {
    _guard(Feature.onboarding);
    await _api.put('/mobile/venues/$venueSlug/spaces/$spaceId/hours', body: {
      'hours': [
        for (final day in hours.days.where((d) => d.isUsable))
          {
            'weekday': day.weekday,
            'opensAt': day.opensAt,
            'closesAt': day.closesAt,
          },
      ],
    });
  }

  @override
  Future<LiveVenue> goLive(String venueSlug, PolicyInput policy) async {
    _guard(Feature.onboarding);
    final json = await _api.patch('/mobile/venues/$venueSlug', body: {
      'cancellationMode': policy.cancellationMode.wire,
      'cancellationGraceHours': policy.graceHours,
      'minNoticeMinutes': policy.minNoticeMinutes,
      'maxHorizonDays': policy.maxHorizonDays,
    });
    final venue = VenueMembership.fromJson(json['venue'] as Map<String, dynamic>);
    return LiveVenue(
      membership: venue,
      bookingUrl: json['bookingUrl'] as String? ??
          '${AppConfig.publicOrigin}/${venue.slug}',
      spaceName: json['spaceName'] as String? ?? 'your space',
    );
  }
}
