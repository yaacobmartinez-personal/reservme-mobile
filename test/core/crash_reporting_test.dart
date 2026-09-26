import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/observability/crash_reporting.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

const _token = '3f2b8c1e-9a47-4d2e-b6f1-0c9d8e7a6b5c';

void main() {
  group('scrub', () {
    test('an app route loses its manage token, keeps its venue', () {
      expect(
        scrub('/c/bookings/katipunan/$_token/reschedule'),
        '/c/bookings/katipunan/[redacted]/reschedule',
      );
    });

    test('an API path loses its manage token', () {
      expect(
        scrub('https://reservme-web.onrender.com/api/public/venues/katipunan/bookings/$_token/cancel'),
        'https://reservme-web.onrender.com/api/public/venues/katipunan/bookings/[redacted]/cancel',
      );
    });

    test('a manage link loses its token', () {
      expect(
        scrub('https://reservme.pro/katipunan/manage/$_token'),
        'https://reservme.pro/katipunan/manage/[redacted]',
      );
    });

    test('an import route loses the token in its query', () {
      expect(
        scrub('/c/bookings/import?slug=katipunan&token=$_token'),
        '/c/bookings/import?slug=katipunan&token=[redacted]',
      );
    });

    test('email addresses go', () {
      expect(
        scrub('No account for maria.santos@example.com'),
        'No account for [redacted]',
      );
    });

    test('leaves ordinary paths alone', () {
      const paths = [
        '/c/bookings',
        '/v/today',
        '/c/find/venues/katipunan',
        '/api/mobile/venues/katipunan/bookings/abc123/checkin',
      ];
      for (final path in paths) {
        expect(scrub(path), path);
      }
    });

    test('no token survives anywhere in a mixed string', () {
      final out = scrub(
        'GET /api/public/venues/x/bookings/$_token then /c/bookings/x/$_token '
        'and ?token=$_token for a@b.co',
      );
      expect(out, isNot(contains(_token)));
      expect(out, isNot(contains('a@b.co')));
    });
  });

  test('an event is scrubbed in every field that carries text', () {
    final event = SentryEvent(
      transaction: '/c/bookings/katipunan/$_token',
      message: SentryMessage('opened /katipunan/manage/$_token'),
      exceptions: [
        SentryException(type: 'ApiError', value: '404 for owner@example.com'),
      ],
      breadcrumbs: [
        Breadcrumb(
          message: 'route /c/bookings/katipunan/$_token',
          data: {'to': '/c/bookings/katipunan/$_token', 'count': 2},
        ),
      ],
      request: SentryRequest(url: 'https://x.test/bookings/$_token'),
    );

    final out = scrubEvent(event);
    final text = [
      out.transaction,
      out.message?.formatted,
      out.exceptions?.single.value,
      out.breadcrumbs?.single.message,
      out.breadcrumbs?.single.data?['to'],
      out.request?.url,
    ].join(' ');

    expect(text, isNot(contains(_token)));
    expect(text, isNot(contains('owner@example.com')));
    expect(out.breadcrumbs?.single.data?['count'], 2);
  });

  test('crash reporting is off without a DSN', () {
    expect(CrashReporting.enabled, isFalse);
  });
}
