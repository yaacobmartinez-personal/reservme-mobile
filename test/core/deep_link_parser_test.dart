import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/router/deep_link_parser.dart';

void main() {
  DeepLinkTarget parse(String url) => DeepLinkParser.parse(Uri.parse(url));

  test('venue page', () {
    final t = parse('https://reservme.pro/katipunan');
    expect(t, isA<VenueLink>().having((v) => v.slug, 'slug', 'katipunan'));
    expect((t as VenueLink).location, '/c/find/venues/katipunan');
  });

  test('www, trailing slash and embed all mean the venue page', () {
    expect(parse('https://www.reservme.pro/katipunan/'), isA<VenueLink>());
    expect(parse('https://reservme.pro/katipunan/embed'), isA<VenueLink>());
  });

  test('manage link imports a booking', () {
    final t = parse('https://reservme.pro/katipunan/manage/abc123');
    expect(t, isA<ManageLink>());
    final m = t as ManageLink;
    expect(m.slug, 'katipunan');
    expect(m.token, 'abc123');
    expect(m.location, '/c/bookings/import?slug=katipunan&token=abc123');
  });

  test('space link carries the date', () {
    final t = parse('https://reservme.pro/katipunan/spaces/sp_9?date=2026-09-27');
    expect(t, isA<SpaceLink>());
    expect((t as SpaceLink).location, '/c/find/venues/katipunan/spaces/sp_9?date=2026-09-27');
  });

  test('custom scheme resolves the same way', () {
    expect(parse('reservme://katipunan'), isA<VenueLink>());
    expect(parse('reservme://katipunan/manage/tok'), isA<ManageLink>());
    expect(parse('reservme://reservme.pro/katipunan'), isA<VenueLink>());
  });

  test('reserved and malformed first segments open in the browser', () {
    expect(parse('https://reservme.pro/privacy'), isA<WebLink>());
    expect(parse('https://reservme.pro/'), isA<WebLink>());
    expect(parse('https://reservme.pro/Not_A_Slug'), isA<WebLink>());
    expect(parse('https://reservme.pro/katipunan/unknown/thing'), isA<WebLink>());
  });

  test('the app host is always a web link; other hosts are unknown', () {
    expect(parse('https://app.reservme.pro/login'), isA<WebLink>());
    expect(parse('https://example.com/katipunan'), isA<UnknownLink>());
  });
}
