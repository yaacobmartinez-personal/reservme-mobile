import 'dart:async';

import 'package:sentry_flutter/sentry_flutter.dart';

import '../config/app_config.dart';

/// Crash reporting. Off unless the build carries a DSN
/// (`--dart-define=SENTRY_DSN=…`, or `SENTRY_DSN` in release.json), so a
/// debug run, a test and a fake-mode demo report nothing.
///
/// What leaves the phone is scrubbed first. A manage token *is* the booking —
/// anyone holding one can cancel it — and it sits in route paths
/// (`/c/bookings/<slug>/<token>`), API paths (`…/bookings/<token>/cancel`) and
/// manage links (`…/<slug>/manage/<token>`). Those go, as do email addresses.
/// Default PII (IP, device user) is off.
abstract final class CrashReporting {
  static const String dsn = String.fromEnvironment('SENTRY_DSN');

  static bool get enabled => dsn.isNotEmpty;

  static Future<void> run(FutureOr<void> Function() appRunner) async {
    if (!enabled) {
      await appRunner();
      return;
    }
    await SentryFlutter.init(
      (options) {
        options
          ..dsn = dsn
          ..environment = AppConfig.apiMode.name
          ..release = 'reservme@${AppConfig.appVersion}'
          ..sendDefaultPii = false
          ..tracesSampleRate = 0
          ..attachScreenshot = false
          // Parenthesised: an arrow body would swallow the next cascade.
          ..beforeSend = ((event, hint) => scrubEvent(event))
          ..beforeBreadcrumb =
              ((crumb, hint) => crumb == null ? null : scrubBreadcrumb(crumb));
      },
      appRunner: appRunner,
    );
  }
}

const _redacted = '[redacted]';

final _tokenInPath = RegExp(
  // /bookings/<slug>/<token> (app routes) and /bookings/<token> (API paths).
  r'(/bookings/(?:[a-z0-9-]+/)?)(?!import\b)([A-Za-z0-9_-]{16,})'
  // /<slug>/manage/<token> (manage links).
  r'|(/manage/)([A-Za-z0-9_-]+)',
);
final _tokenInQuery = RegExp(r'([?&]token=)[^&#\s]+');
final _email = RegExp(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}');

/// Strips manage tokens and email addresses from any string headed off the
/// device. Pure, so the rules are tested without Sentry.
String scrub(String input) => input
    .replaceAllMapped(
      _tokenInPath,
      (m) => m.group(1) != null ? '${m.group(1)}$_redacted' : '${m.group(3)}$_redacted',
    )
    .replaceAllMapped(_tokenInQuery, (m) => '${m.group(1)}$_redacted')
    .replaceAll(_email, _redacted);

String? _scrubOrNull(String? input) => input == null ? null : scrub(input);

Map<String, dynamic>? _scrubMap(Map<String, dynamic>? data) => data?.map(
      (key, value) => MapEntry(key, value is String ? scrub(value) : value),
    );

/// Sentry's protocol objects are mutable (their copyWith is deprecated), so the
/// scrub works in place and hands the same object back.
Breadcrumb scrubBreadcrumb(Breadcrumb crumb) {
  crumb
    ..message = _scrubOrNull(crumb.message)
    ..data = _scrubMap(crumb.data);
  return crumb;
}

SentryEvent scrubEvent(SentryEvent event) {
  event.transaction = _scrubOrNull(event.transaction);
  final message = event.message;
  if (message != null) message.formatted = scrub(message.formatted);
  for (final exception in event.exceptions ?? const <SentryException>[]) {
    exception.value = _scrubOrNull(exception.value);
  }
  event.breadcrumbs?.forEach(scrubBreadcrumb);
  final request = event.request;
  if (request != null) request.url = _scrubOrNull(request.url);
  return event;
}
