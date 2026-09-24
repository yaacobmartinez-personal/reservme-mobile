import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/router/deep_link_handler.dart';

void main() {
  DeepLinkAction actionOf(String url) => actionFor(Uri.parse(url));

  group('what a link makes the app do', () {
    test('a booking page opens inside the app', () {
      expect(
        actionOf('https://reservme.pro/katipunan'),
        const NavigateTo('/c/find/venues/katipunan'),
      );
      // The embed variant is the same page.
      expect(
        actionOf('https://reservme.pro/katipunan/embed'),
        const NavigateTo('/c/find/venues/katipunan'),
      );
    });

    test('a manage link imports the booking rather than just showing it', () {
      expect(
        actionOf('https://reservme.pro/katipunan/manage/tok-123'),
        const NavigateTo('/c/bookings/import?slug=katipunan&token=tok-123'),
      );
    });

    test('a shared space link keeps its date', () {
      expect(
        actionOf('https://reservme.pro/katipunan/spaces/court-1?date=2026-10-01'),
        const NavigateTo('/c/find/venues/katipunan/spaces/court-1?date=2026-10-01'),
      );
    });

    test('our own scheme resolves the same way as https', () {
      expect(
        actionOf('reservme://katipunan/manage/tok-123'),
        actionOf('https://reservme.pro/katipunan/manage/tok-123'),
      );
    });

    test('our own pages go to the browser, not into the app', () {
      // Legal and marketing pages have no in-app equivalent.
      expect(
        actionOf('https://reservme.pro/privacy'),
        OpenExternally(Uri.parse('https://reservme.pro/privacy')),
      );
      expect(
        actionOf('https://reservme.pro/'),
        OpenExternally(Uri.parse('https://reservme.pro/')),
      );
      // The dashboard is parked, but its links still belong to a browser.
      expect(
        actionOf('https://app.reservme.pro/spaces'),
        OpenExternally(Uri.parse('https://app.reservme.pro/spaces')),
      );
    });

    test('someone else\'s link is ignored, not guessed at', () {
      expect(actionOf('https://example.com/katipunan'), const IgnoreLink());
      expect(actionOf('https://reservme.pro.evil.com/katipunan'),
          const IgnoreLink());
    });

    test('a slug-shaped path that is really ours stays in the browser', () {
      // `admin` is a reserved segment, not a venue called admin.
      expect(
        actionOf('https://reservme.pro/admin'),
        OpenExternally(Uri.parse('https://reservme.pro/admin')),
      );
    });

    test('a path we do not recognise falls back to the browser', () {
      // Better a working web page than a dead end inside the app.
      expect(
        actionOf('https://reservme.pro/katipunan/something/else/entirely'),
        OpenExternally(
          Uri.parse('https://reservme.pro/katipunan/something/else/entirely'),
        ),
      );
    });
  });
}
