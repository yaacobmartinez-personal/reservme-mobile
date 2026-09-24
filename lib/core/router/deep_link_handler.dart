import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/shell/application/app_mode_controller.dart';
import 'app_router.dart';
import 'deep_link_parser.dart';

part 'deep_link_handler.g.dart';

/// What the app should *do* about a link, separated from doing it so the
/// decision is testable without a plugin or a navigator.
sealed class DeepLinkAction {
  const DeepLinkAction();
}

/// Go to a location inside the app, switching to the mode that owns it.
/// Every deep link we handle is a customer link — an owner's dashboard is
/// never linked to from outside.
class NavigateTo extends DeepLinkAction {
  const NavigateTo(this.location);

  final String location;

  @override
  bool operator ==(Object other) =>
      other is NavigateTo && other.location == location;

  @override
  int get hashCode => location.hashCode;

  @override
  String toString() => 'NavigateTo($location)';
}

/// Hand it to the browser: our own marketing and legal pages, and the parked
/// web dashboard.
class OpenExternally extends DeepLinkAction {
  const OpenExternally(this.uri);

  final Uri uri;

  @override
  bool operator ==(Object other) => other is OpenExternally && other.uri == uri;

  @override
  int get hashCode => uri.hashCode;

  @override
  String toString() => 'OpenExternally($uri)';
}

/// Not ours, or nothing sensible to do. Silence is the right answer: the OS
/// gave us a link we did not ask for.
class IgnoreLink extends DeepLinkAction {
  const IgnoreLink();

  @override
  bool operator ==(Object other) => other is IgnoreLink;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'IgnoreLink()';
}

/// The whole decision, as a pure function of the URL.
DeepLinkAction actionFor(Uri uri) => switch (DeepLinkParser.parse(uri)) {
      VenueLink(:final location) => NavigateTo(location),
      SpaceLink(:final location) => NavigateTo(location),
      ManageLink(:final location) => NavigateTo(location),
      WebLink(:final uri) => OpenExternally(uri),
      UnknownLink() => const IgnoreLink(),
    };

/// Listens for links and acts on them for the life of the app.
///
/// Both halves matter: `getInitialLink` covers a cold start from a link, and
/// the stream covers one arriving while the app is already up. Missing the
/// first would mean tapping a booking link on a fresh install did nothing.
@Riverpod(keepAlive: true)
class DeepLinks extends _$DeepLinks {
  StreamSubscription<Uri>? _subscription;

  @override
  Uri? build() {
    final links = ref.watch(appLinksProvider);
    ref.onDispose(() => _subscription?.cancel());

    // A link that arrives before the first frame still has to wait for the
    // router to exist, so both paths go through the same handler.
    unawaited(_openInitial(links));
    _subscription = links.uriLinkStream.listen(
      open,
      // A malformed link from the OS is not worth crashing over.
      onError: (_) {},
    );
    return null;
  }

  Future<void> _openInitial(AppLinks links) async {
    try {
      final uri = await links.getInitialLink();
      if (uri != null) await open(uri);
    } catch (_) {
      // No initial link, or the platform channel is unavailable.
    }
  }

  /// Acts on one link. Public so a test — or a future in-app scanner — can
  /// drive it without the plugin.
  Future<void> open(Uri uri) async {
    if (!ref.mounted) return;
    state = uri;

    switch (actionFor(uri)) {
      case NavigateTo(:final location):
        // Customer links land in customer mode even for signed-in staff:
        // they opened a booking page, not their desk.
        ref.read(appModeControllerProvider.notifier).set(AppMode.customer);
        ref.read(appRouterProvider).go(location);
      case OpenExternally(:final uri):
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      case IgnoreLink():
        break;
    }
  }
}

/// Seam for tests, which have no platform channels.
@Riverpod(keepAlive: true)
AppLinks appLinks(Ref ref) => AppLinks();
