import '../config/app_config.dart';
import 'routes.dart';

/// Where a link should take the app. Pure data so the parser is unit-testable
/// and the handler (Phase 4) only has to switch on it.
sealed class DeepLinkTarget {
  const DeepLinkTarget();
}

/// `reservme.pro/<slug>` (or `/<slug>/embed`) → the venue page.
class VenueLink extends DeepLinkTarget {
  const VenueLink(this.slug);
  final String slug;
  String get location => Routes.venue(slug);
}

/// `reservme.pro/<slug>/spaces/<space>?date=` → a space's day (app-minted
/// share links).
class SpaceLink extends DeepLinkTarget {
  const SpaceLink(this.slug, this.spaceId, {this.date});
  final String slug;
  final String spaceId;
  final String? date;
  String get location => Routes.space(slug, spaceId, date: date);
}

/// `reservme.pro/<slug>/manage/<token>` → import into the wallet.
class ManageLink extends DeepLinkTarget {
  const ManageLink(this.slug, this.token);
  final String slug;
  final String token;
  String get location => Routes.importBooking(slug, token);
}

/// Anything else on our hosts (privacy, terms, the parked dashboard):
/// open in a browser tab.
class WebLink extends DeepLinkTarget {
  const WebLink(this.uri);
  final Uri uri;
}

/// Not ours.
class UnknownLink extends DeepLinkTarget {
  const UnknownLink();
}

/// Translates a URL into a [DeepLinkTarget]. Scheme-agnostic: `https://`,
/// the custom `reservme://` scheme and bare `reservme.pro/...` all resolve
/// the same way.
abstract final class DeepLinkParser {
  /// First path segments the web reserves; never a venue slug.
  static const reservedSegments = {
    '', 'api', 'app', 'admin', 'login', 'signup', 'contact', 'privacy', 'terms',
    'pricing', 'about', 'help', 'www', '_next', 'favicon.ico',
  };

  static final _slug = RegExp(r'^[a-z0-9](?:[a-z0-9-]{0,62}[a-z0-9])?$');

  static DeepLinkTarget parse(Uri uri) {
    final public = Uri.parse(AppConfig.publicOrigin);
    final app = Uri.parse(AppConfig.appOrigin);
    final host = uri.host.toLowerCase();

    final isPublicHost = host == public.host || host == 'www.${public.host}';
    final isAppHost = host == app.host;
    final isCustom = uri.scheme == AppConfig.customScheme;

    if (!isPublicHost && !isAppHost && !isCustom) return const UnknownLink();
    if (isAppHost) return WebLink(uri);

    // `reservme://katipunan/manage/x` puts the slug in the host; treat it as
    // the first segment.
    final segments = [
      if (isCustom && !isPublicHost && host.isNotEmpty) host,
      ...uri.pathSegments.where((s) => s.isNotEmpty),
    ];
    if (segments.isEmpty) return WebLink(uri);

    final first = segments.first.toLowerCase();
    if (reservedSegments.contains(first) || !_slug.hasMatch(first)) return WebLink(uri);

    switch (segments.length) {
      case 1:
        return VenueLink(first);
      case 2 when segments[1] == 'embed':
        return VenueLink(first);
      case 3 when segments[1] == 'manage' && segments[2].isNotEmpty:
        return ManageLink(first, segments[2]);
      case 3 when segments[1] == 'spaces' && segments[2].isNotEmpty:
        return SpaceLink(first, segments[2], date: uri.queryParameters['date']);
      default:
        return WebLink(uri);
    }
  }
}
