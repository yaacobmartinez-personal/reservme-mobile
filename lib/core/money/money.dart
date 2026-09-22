import 'package:intl/intl.dart';

/// Money helpers, ported from the web `src/lib/money.ts`: amounts travel as
/// integer minor units (centavos) and render with the venue's currency.
abstract final class Money {
  static const _symbols = {'PHP': '₱', 'USD': r'$', 'EUR': '€', 'GBP': '£'};

  static String symbol(String currency) =>
      _symbols[currency.toUpperCase()] ?? '${currency.toUpperCase()} ';

  /// "₱1,250" for whole amounts, "₱1,250.50" otherwise.
  static String format(int cents, {String currency = 'PHP'}) {
    final negative = cents < 0;
    final abs = cents.abs();
    final body = abs % 100 == 0
        ? NumberFormat('#,##0', 'en_PH').format(abs ~/ 100)
        : NumberFormat('#,##0.00', 'en_PH').format(abs / 100);
    return '${negative ? '-' : ''}${symbol(currency)}$body';
  }

  /// "₱5.6k" / "₱38.4k" / "₱1.2M" for KPI tiles.
  static String compact(int cents, {String currency = 'PHP'}) {
    final value = cents / 100;
    if (value.abs() >= 1000000) {
      return '${symbol(currency)}${_trim(value / 1000000)}M';
    }
    if (value.abs() >= 1000) return '${symbol(currency)}${_trim(value / 1000)}k';
    return format(cents, currency: currency);
  }

  static String _trim(double v) {
    final s = v.toStringAsFixed(1);
    return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
  }

  /// Price of a booking: `price_cents * minutes / slot_minutes` (web
  /// `reserveSpace`).
  static int forDuration(int priceCentsPerSlot, int slotMinutes, int minutes) {
    if (slotMinutes <= 0) return priceCentsPerSlot;
    return (priceCentsPerSlot * minutes / slotMinutes).round();
  }
}
