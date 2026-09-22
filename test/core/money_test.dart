import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/money/money.dart';

void main() {
  test('formats whole pesos without decimals', () {
    expect(Money.format(45000), '₱450');
    expect(Money.format(125000), '₱1,250');
    expect(Money.format(0), '₱0');
  });

  test('keeps decimals when there are centavos', () {
    expect(Money.format(125050), '₱1,250.50');
    expect(Money.format(5), '₱0.05');
  });

  test('handles other currencies and negatives', () {
    expect(Money.format(2400, currency: 'EUR'), '€24');
    expect(Money.format(-45000), '-₱450');
    expect(Money.format(100, currency: 'JPY'), 'JPY 1');
  });

  test('compact for KPI tiles', () {
    expect(Money.compact(560000), '₱5.6k');
    expect(Money.compact(3840000), '₱38.4k');
    expect(Money.compact(120000000), '₱1.2M');
    expect(Money.compact(45000), '₱450');
    expect(Money.compact(1000000), '₱10k');
  });

  test('prices a booking by duration against the slot price', () {
    expect(Money.forDuration(35000, 60, 60), 35000);
    expect(Money.forDuration(35000, 60, 120), 70000);
    expect(Money.forDuration(35000, 60, 90), 52500);
    expect(Money.forDuration(35000, 0, 90), 35000);
  });
}
