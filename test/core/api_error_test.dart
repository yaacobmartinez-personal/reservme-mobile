import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/core/network/token_codec.dart';

void main() {
  group('ApiError', () {
    test('maps a JSON error body with field errors and a reason', () {
      final e = ApiError.fromResponse(400, {
        'error': 'That email doesn\'t look right.',
        'fieldErrors': {'email': 'Invalid', 'name': 42},
        'reason': 'slot_taken',
      });
      expect(e.status, 400);
      expect(e.message, "That email doesn't look right.");
      expect(e.fieldErrors, {'email': 'Invalid'});
      expect(e.reason, 'slot_taken');
    });

    test('falls back to a status-specific message', () {
      expect(ApiError.fromResponse(401, null).message, contains('session'));
      expect(ApiError.fromResponse(403, {}).message, contains('access'));
      expect(ApiError.fromResponse(500, {'error': ''}).message, contains('Try again'));
    });

    test('a transport failure is status 0', () {
      final e = ApiError.fromDio(DioException(
        requestOptions: RequestOptions(path: '/x'),
        type: DioExceptionType.connectionError,
      ));
      expect(e.isNetwork, isTrue);
      expect(e.message, ApiError.networkMessage);
    });
  });

  group('TokenCodec', () {
    test('mints and reads a fake token', () {
      final exp = DateTime.utc(2026, 10, 26, 2);
      final token = TokenCodec.mintFake('u_1', exp);
      expect(TokenCodec.isFake(token), isTrue);
      expect(TokenCodec.subject(token), 'u_1');
      expect(TokenCodec.expiry(token), exp);
    });

    test('garbage reads as unreadable, never throws', () {
      expect(TokenCodec.expiry('not-a-token'), isNull);
      expect(TokenCodec.subject(''), isNull);
    });
  });
}
