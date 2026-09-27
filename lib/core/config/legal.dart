import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_config.dart';

/// The public pages both stores ask the app to link to. They live on the host
/// the app already talks to, so they work before the apex domain exists.
enum LegalPage {
  privacy('privacy', 'Privacy policy'),
  terms('terms', 'Terms of service'),
  deleteAccount('delete-account', 'Deleting your account');

  const LegalPage(this.path, this.label);

  final String path;
  final String label;

  Uri get url => Uri.parse('${AppConfig.appOrigin}/$path');
}

/// Swapped in tests, where nothing answers the url_launcher channel.
@visibleForTesting
Future<bool> Function(Uri url) legalLauncher =
    (url) => launchUrl(url, mode: LaunchMode.inAppBrowserView);

Future<bool> openLegal(LegalPage page) => legalLauncher(page.url);

/// Apple (guideline 3.1.1) wants a subscription paid inside an iOS app to go
/// through in-app purchase. A venue's subscription is paid by bank transfer,
/// so on iOS the app shows where billing stands and never asks for payment or
/// says how to make one. Android keeps the whole flow.
bool get paymentsInApp => defaultTargetPlatform != TargetPlatform.iOS;
