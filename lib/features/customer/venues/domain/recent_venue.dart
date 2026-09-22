import '../../../../core/model/enums.dart';

/// A venue this phone has opened before, shown on Find. Local only: the
/// server never learns which venue pages a customer looked at.
class RecentVenue {
  const RecentVenue({
    required this.slug,
    required this.name,
    required this.theme,
    required this.openedAt,
    this.tagline,
    this.coverUrl,
    this.lastBookedAt,
  });

  final String slug;
  final String name;
  final VenueTheme theme;
  final DateTime openedAt;
  final String? tagline;
  final String? coverUrl;

  /// Set once the customer has actually booked here.
  final DateTime? lastBookedAt;
}
