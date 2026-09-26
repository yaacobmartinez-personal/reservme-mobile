import 'package:freezed_annotation/freezed_annotation.dart';

import '../../venue/venues/domain/venue_membership.dart';
import '../domain/user.dart';

part 'auth_state.freezed.dart';

/// Why a session ended; decides where the router sends the person.
enum SignOutReason { user, sessionExpired, accountDeleted, serverChanged }

/// Venue-staff session state. Customers are never signed in: the customer
/// shell is fully public, so [SignedOut] is the normal state of the app.
@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.signedOut({SignOutReason? reason}) = SignedOut;

  const factory AuthState.signedIn({
    required User user,
    required String token,
    required DateTime expiresAt,
    @Default([]) List<VenueMembership> venues,

    /// False until `/mobile/me` has confirmed the cached venue list this
    /// session.
    @Default(false) bool venuesFresh,

    /// From `/mobile/me`, never cached: a revoked grant must not outlive the
    /// next refresh, and until one lands the console's entry is simply hidden.
    @Default(false) bool platformAdmin,
  }) = SignedIn;

  bool get isSignedIn => this is SignedIn;

  /// Whether the venue shell may be opened: at least one membership.
  bool get hasVenueAccess => switch (this) {
        SignedIn(:final venues) => venues.isNotEmpty,
        SignedOut() => false,
      };

  /// Whether the platform-admin console may be opened.
  bool get isPlatformAdmin => switch (this) {
        SignedIn(:final platformAdmin) => platformAdmin,
        SignedOut() => false,
      };

  User? get userOrNull => switch (this) {
        SignedIn(:final user) => user,
        SignedOut() => null,
      };

  List<VenueMembership> get venuesOrEmpty => switch (this) {
        SignedIn(:final venues) => venues,
        SignedOut() => const [],
      };
}
