import 'public_venue.dart';

/// The public venue page (API-CONTRACT #1). Unauthenticated: this is what a
/// customer sees from a link, a QR or a venue code.
abstract class VenuesRepository {
  /// Throws `ApiError(404)` when the slug is unknown.
  Future<PublicVenue> bySlug(String slug);
}
