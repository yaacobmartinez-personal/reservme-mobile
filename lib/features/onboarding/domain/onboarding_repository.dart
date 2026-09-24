import '../../auth/domain/auth_repository.dart';
import '../../venue/venues/domain/venue_membership.dart';
import 'onboarding_input.dart';

/// Whether a booking-page address can be taken, and why not when it can't.
class SlugCheck {
  const SlugCheck({required this.slug, required this.available, this.reason});

  final String slug;
  final bool available;
  final String? reason;
}

/// What the venue ends up with once the flow finishes.
class LiveVenue {
  const LiveVenue({
    required this.membership,
    required this.bookingUrl,
    required this.spaceName,
  });

  final VenueMembership membership;

  /// `https://reservme.pro/<slug>` — the page to share and put on the poster.
  final String bookingUrl;
  final String spaceName;
}

/// Venue onboarding (API-CONTRACT #25–#29).
///
/// Each step is its own call rather than one big create, because the owner
/// can stop after any of them and come back: the account exists after step 1,
/// the venue after step 3, and the space is bookable after step 5.
abstract class OnboardingRepository {
  /// Creates the owner's account and signs them in.
  Future<AuthResult> signUp(SignupInput input);

  /// Verifies the emailed 6-digit code. Skippable — the flow continues
  /// unverified, and booking emails start once it is done.
  Future<void> verifyEmail(String code);

  Future<void> resendVerification();

  Future<SlugCheck> checkSlug(String slug);

  /// Creates the venue and its trialing subscription, and makes the owner its
  /// owner. Returns the membership so the app can select it.
  Future<VenueMembership> createVenue(VenueInput input);

  /// The first space, with its opening hours seeded.
  Future<String> createFirstSpace(String venueSlug, FirstSpaceInput input);

  Future<void> setHours(String venueSlug, String spaceId, HoursInput hours);

  /// Applies the booking rules and returns everything the "you're live"
  /// screen needs.
  Future<LiveVenue> goLive(String venueSlug, PolicyInput policy);
}
