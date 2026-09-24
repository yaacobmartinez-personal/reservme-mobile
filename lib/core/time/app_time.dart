import 'package:intl/intl.dart';
import 'package:timezone/data/latest_10y.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Timezone handling, ported from the web `src/lib/booking/availability.ts`
/// and `src/lib/venue.ts`.
///
/// Every instant is UTC. A venue lives in one IANA zone (`venue.timezone`,
/// default Asia/Manila); opening hours are wall-clock, and every label a
/// customer or staff member reads is rendered in the venue's zone, never the
/// device's — a booking at Katipunan is at 18:00 Manila time wherever the
/// phone is.
abstract final class AppTime {
  static bool _initialized = false;

  /// The device's IANA zone, set at boot from flutter_timezone. Only used as
  /// the default when creating a venue and as the fallback for an unknown zone.
  static String deviceZone = 'UTC';

  static void ensureInitialized() {
    if (_initialized) return;
    tzdata.initializeTimeZones();
    _initialized = true;
  }

  /// Spellings of UTC that the embedded database does not list by name.
  static const _utcAliases = {'UTC', 'Etc/UTC', 'Etc/GMT', 'GMT', 'Z'};

  static tz.Location? tryLocation(String zone) {
    if (zone.isEmpty) return null;
    if (_utcAliases.contains(zone)) return tz.UTC;
    ensureInitialized();
    try {
      return tz.getLocation(zone);
    } on tz.LocationNotFoundException {
      return null;
    }
  }

  static bool isValidTimeZone(String zone) => tryLocation(zone) != null;

  static tz.Location _locationOrFallback(String? zone) =>
      (zone == null ? null : tryLocation(zone)) ??
      tryLocation(deviceZone) ??
      tz.UTC;

  /// The instant [utc] as wall-clock time in [zone] (device zone if unknown).
  static tz.TZDateTime inZone(DateTime utc, String? zone) =>
      tz.TZDateTime.from(utc.toUtc(), _locationOrFallback(zone));

  /// "18:00" — slot labels, run sheet times.
  static String formatTime(DateTime utc, String zone) =>
      DateFormat('HH:mm').format(inZone(utc, zone));

  /// "18:00–19:00" — the run sheet's `label` column.
  static String formatRange(DateTime start, DateTime end, String zone) =>
      '${formatTime(start, zone)}–${formatTime(end, zone)}';

  /// "Sat 26 Sep" — cards.
  static String formatDay(DateTime utc, String zone) =>
      DateFormat('EEE d MMM').format(inZone(utc, zone));

  /// "Saturday, 26 September" — screen headers.
  static String formatLongDay(DateTime utc, String zone) =>
      DateFormat('EEEE, d MMMM').format(inZone(utc, zone));

  /// "Sat 26 Sep · 18:00–19:00" — booking summaries (the web `whenLabel`).
  static String formatWhen(DateTime start, DateTime end, String zone) =>
      '${formatDay(start, zone)} · ${formatRange(start, end, zone)}';

  /// Short zone label, e.g. "GMT+8", "GMT+5:30", "UTC".
  static String zoneLabel(DateTime utc, String zone) {
    final local = inZone(utc, zone);
    final offset = local.timeZoneOffset;
    if (offset == Duration.zero) {
      return _utcAliases.contains(local.location.name) ? 'UTC' : 'GMT';
    }
    final sign = offset.isNegative ? '-' : '+';
    final abs = offset.abs();
    final hours = abs.inHours;
    final minutes = abs.inMinutes.remainder(60);
    return minutes == 0
        ? 'GMT$sign$hours'
        : 'GMT$sign$hours:${minutes.toString().padLeft(2, '0')}';
  }

  /// "2026-09-26" — the venue-local calendar date of an instant. This is the
  /// key availability, the run sheet and the calendar are grouped by.
  static String localDate(DateTime utc, String zone) {
    final local = inZone(utc, zone);
    return '${local.year}-${_two(local.month)}-${_two(local.day)}';
  }

  /// Today's venue-local date.
  static String today(DateTime nowUtc, String zone) => localDate(nowUtc, zone);

  static final RegExp _date = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$');
  static final RegExp _time = RegExp(r'^(\d{2}):(\d{2})$');

  /// The UTC instant of a venue-local `date` + `time` ("2026-09-26", "18:00"),
  /// the shape the manual-booking and block-off endpoints take. Null for
  /// malformed input or an unknown zone.
  static DateTime? fromLocal(String date, String time, String zone) {
    final d = _date.firstMatch(date.trim());
    final t = _time.firstMatch(time.trim());
    final location = tryLocation(zone);
    if (d == null || t == null || location == null) return null;
    return tz.TZDateTime(
      location,
      int.parse(d[1]!),
      int.parse(d[2]!),
      int.parse(d[3]!),
      int.parse(t[1]!),
      int.parse(t[2]!),
    ).toUtc();
  }

  /// Midnight (start of day) of a venue-local date as a UTC instant.
  static DateTime? startOfLocalDay(String date, String zone) =>
      fromLocal(date, '00:00', zone);

  /// Whether a wall-clock time actually occurs in a zone (DST gaps). Manila
  /// has no DST; a venue in Madrid does, and the round trip is the reliable test.
  static bool localExists(String date, String time, String zone) {
    final instant = fromLocal(date, time, zone);
    if (instant == null) return false;
    return localDate(instant, zone) == date.trim() &&
        formatTime(instant, zone) == time.trim();
  }

  /// [date] plus [days] as a venue-local date string, DST-safe.
  static String addDays(String date, int days, String zone) {
    final start = startOfLocalDay(date, zone);
    if (start == null) return date;
    final local = inZone(start, zone);
    final shifted = tz.TZDateTime(local.location, local.year, local.month, local.day + days);
    return localDate(shifted.toUtc(), zone);
  }

  /// 0 = Sunday … 6 = Saturday, matching the web `opening_hours.weekday`.
  static int weekday(String date, String zone) {
    final start = startOfLocalDay(date, zone);
    if (start == null) return 0;
    return inZone(start, zone).weekday % 7;
  }

  /// Wall-clock arithmetic on "HH:MM", staying inside the day. Used to step
  /// the calendar grid and to move a block's end with its start — neither
  /// wants an instant, because neither has a date until the venue supplies
  /// one.
  static String addMinutesToTime(String time, int minutes) {
    final parts = time.trim().split(':');
    if (parts.length != 2) return time;
    final h = int.tryParse(parts[0]), m = int.tryParse(parts[1]);
    if (h == null || m == null) return time;
    final total = (h * 60 + m + minutes).clamp(0, 24 * 60);
    return '${_two(total ~/ 60)}:${_two(total % 60)}';
  }

  /// Minutes from midnight for an "HH:MM", or null when it is not a time.
  static int? minutesOfDay(String time) {
    final parts = time.trim().split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]), m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return h * 60 + m;
  }

  /// Every zone this build knows, for the venue timezone picker.
  static List<String> supportedTimeZones() {
    ensureInitialized();
    final names = tz.timeZoneDatabase.locations.keys.toList()..sort();
    return names;
  }

  static String _two(int n) => n.toString().padLeft(2, '0');
}
