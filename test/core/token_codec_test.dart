import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/network/token_codec.dart';

void main() {
  final expires = DateTime.utc(2026, 10, 26, 2);

  test('a minted fake token round-trips its subject and expiry', () {
    final token = TokenCodec.mintFake('usr_owner', expires);

    expect(TokenCodec.isFake(token), isTrue);
    expect(TokenCodec.subject(token), 'usr_owner');
    expect(TokenCodec.expiry(token), expires);
  });

  test('a real-shaped token reads the same way', () {
    final real = TokenCodec.mintFake('usr_1', expires)
        .substring(TokenCodec.fakePrefix.length);

    expect(TokenCodec.isFake(real), isFalse);
    expect(TokenCodec.subject(real), 'usr_1');
    expect(TokenCodec.expiry(real), expires);
  });

  test('rubbish reads as unknown rather than throwing', () {
    for (final token in ['', 'nonsense', '.', 'fake.', 'fake.!!!!.sig', 'a.b']) {
      expect(TokenCodec.payload(token), isNull, reason: token);
      expect(TokenCodec.expiry(token), isNull, reason: token);
      expect(TokenCodec.subject(token), isNull, reason: token);
    }
  });

  test('a token without an exp claim has no expiry', () {
    // {"sub":"usr_1"} with no exp — the caller falls back to the default TTL.
    const token = 'fake.eyJzdWIiOiJ1c3JfMSJ9.fake';

    expect(TokenCodec.subject(token), 'usr_1');
    expect(TokenCodec.expiry(token), isNull);
  });
}
