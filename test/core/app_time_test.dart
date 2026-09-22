import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/time/app_time.dart';

void main() {
  setUpAll(AppTime.ensureInitialized);

  group('Manila (no DST)', () {
    const zone = 'Asia/Manila';

    test('renders an instant in venue-local time', () {
      final utc = DateTime.utc(2026, 9, 26, 10); // 18:00 in Manila
      expect(AppTime.formatTime(utc, zone), '18:00');
      expect(AppTime.formatDay(utc, zone), 'Sat 26 Sep');
      expect(AppTime.formatWhen(utc, utc.add(const Duration(hours: 1)), zone), 'Sat 26 Sep · 18:00–19:00');
      expect(AppTime.zoneLabel(utc, zone), 'GMT+8');
    });

    test('local date rolls over at venue midnight, not UTC midnight', () {
      // 23:30 Manila on the 26th is 15:30 UTC on the 26th …
      expect(AppTime.localDate(DateTime.utc(2026, 9, 26, 15, 30), zone), '2026-09-26');
      // … and 00:30 Manila on the 27th is 16:30 UTC on the 26th.
      expect(AppTime.localDate(DateTime.utc(2026, 9, 26, 16, 30), zone), '2026-09-27');
    });

    test('fromLocal builds the UTC instant of a wall-clock time', () {
      expect(AppTime.fromLocal('2026-09-26', '18:00', zone), DateTime.utc(2026, 9, 26, 10));
      expect(AppTime.fromLocal('2026-9-26', '18:00', zone), isNull);
      expect(AppTime.fromLocal('2026-09-26', '18:00', 'Mars/Olympus'), isNull);
    });

    test('weekday uses the web convention 0 = Sunday', () {
      expect(AppTime.weekday('2026-09-26', zone), 6); // Saturday
      expect(AppTime.weekday('2026-09-27', zone), 0); // Sunday
      expect(AppTime.weekday('2026-09-28', zone), 1); // Monday
    });

    test('addDays walks the calendar', () {
      expect(AppTime.addDays('2026-09-30', 1, zone), '2026-10-01');
      expect(AppTime.addDays('2026-01-01', -1, zone), '2025-12-31');
    });
  });

  group('Madrid (DST)', () {
    const zone = 'Europe/Madrid';

    test('a time in the spring-forward gap does not exist', () {
      // Clocks go 02:00 → 03:00 on 29 March 2026.
      expect(AppTime.localExists('2026-03-29', '02:30', zone), isFalse);
      expect(AppTime.localExists('2026-03-29', '03:30', zone), isTrue);
      expect(AppTime.localExists('2026-03-28', '02:30', zone), isTrue);
    });

    test('addDays across the DST boundary stays on the calendar', () {
      expect(AppTime.addDays('2026-03-28', 1, zone), '2026-03-29');
      expect(AppTime.addDays('2026-03-29', 1, zone), '2026-03-30');
    });

    test('zone label follows the offset', () {
      expect(AppTime.zoneLabel(DateTime.utc(2026, 1, 15, 12), zone), 'GMT+1');
      expect(AppTime.zoneLabel(DateTime.utc(2026, 7, 15, 12), zone), 'GMT+2');
    });
  });

  test('unknown zone falls back to the device zone, then UTC', () {
    AppTime.deviceZone = 'Asia/Manila';
    expect(AppTime.formatTime(DateTime.utc(2026, 9, 26, 10), 'Nowhere/Land'), '18:00');
    AppTime.deviceZone = 'UTC';
    expect(AppTime.formatTime(DateTime.utc(2026, 9, 26, 10), 'Nowhere/Land'), '10:00');
  });
}
