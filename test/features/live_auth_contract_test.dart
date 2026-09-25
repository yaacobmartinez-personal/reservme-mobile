import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/config/app_config.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/core/network/token_codec.dart';
import 'package:reservme/features/auth/data/real_auth_repository.dart';

import '../helpers/stub_adapter.dart';

/// Auth is the first slice of the backend that actually exists (contract
/// #10–#13, #25, #26, #34 — Better Auth's bearer and email-OTP plugins, on the
/// app host).
///
/// Every body below was **copied from a real response**, captured by walking
/// `npm run test:mobile-auth` against the deployed schema. That is the point of
/// this file: `real_repositories_test.dart` pins what we *hope* a server sends,
/// and these pin what one *does*.
void main() {
  group('the token the server actually mints', () {
    // Better Auth hands back `<sessionToken>.<signature>`. It looks like a JWT
    // and is not one: the first segment is random bytes, not base64url JSON.
    const realToken =
        'kUAXCUa4nRchihmS3sllH7V2h9Nmyw72.JncRjao7NuOhXpfnIKORtJuXh5opLzmhfBEqxZsdI1A=';

    test('is opaque — no readable expiry, and reading it does not throw', () {
      // The dot invites TokenCodec to treat the first half as a payload. It
      // decodes as base64 and then fails as UTF-8, which must come back as
      // "unknown" rather than as an exception on the boot path.
      expect(TokenCodec.payload(realToken), isNull);
      expect(TokenCodec.expiry(realToken), isNull);
      expect(TokenCodec.subject(realToken), isNull);
    });

    test('is not mistaken for a fake-mode token', () {
      expect(TokenCodec.isFake(realToken), isFalse);
    });
  });

  group('login (#10)', () {
    test('reads the token and user out of a real 200', () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({
          'token': 'kUAXCUa4nRchihmS3sllH7V2h9Nmyw72.JncRjao7NuOhXpfnIKORtJuXh5o=',
          'user': {
            'id': 'maDXSRURXj5uRKAUCxakG8phVxM6iilI',
            'email': 'owner@reservme.test',
            'name': 'Shape Check',
            'emailVerified': false,
          },
        }),
      ], token: null);

      final result = await RealAuthRepository(client, ApiMode.fake)
          .signIn(email: '  Owner@Reservme.test ', password: 'a-good-long-password');

      expect(result.token, startsWith('kUAXCUa4'));
      expect(result.user.id, 'maDXSRURXj5uRKAUCxakG8phVxM6iilI');
      expect(result.user.emailVerified, isFalse);

      final sent = stub.requests.single;
      expect(sent.path, '/mobile/auth/login');
      // The server lower-cases too, but sending a trimmed address keeps a
      // stray space from ever reaching a rate-limit key.
      expect(sent.body['email'], 'Owner@Reservme.test');
    });

    test('a wrong password and an unknown address are the same 401', () async {
      // Verified live: both refusals come back byte-identical, so the app
      // cannot leak which addresses have accounts either.
      const refusal = {
        'error': 'unauthorized',
        'message': 'That email and password do not match.',
      };

      for (final _ in [1, 2]) {
        final (:client, :stub) = stubbedClient([const Reply(401, refusal)], token: null);
        await expectLater(
          RealAuthRepository(client, ApiMode.fake).signIn(email: 'a@b.co', password: 'x'),
          throwsA(
            isA<ApiError>()
                .having((e) => e.status, 'status', 401)
                .having((e) => e.message, 'message', 'That email and password do not match.'),
          ),
        );
        expect(stub.requests.single.path, '/mobile/auth/login');
      }
    });
  });

  group('me (#13)', () {
    test('a signed-in owner with no venue yet is a valid answer', () async {
      // Exactly what the server returns between sign-up and venue creation.
      // An empty list must not read as an error, or a new owner is stuck.
      final (:client, :stub) = stubbedClient([
        const Reply.ok({
          'user': {
            'id': 'u1',
            'email': 'owner@reservme.test',
            'name': 'Shape Check',
            'emailVerified': true,
          },
          'venues': <Map<String, dynamic>>[],
        }),
      ]);

      final me = await RealAuthRepository(client, ApiMode.fake).me();
      expect(me.venues, isEmpty);
      expect(me.user.emailVerified, isTrue);
      expect(stub.requests.single.header('authorization'), 'Bearer test-token');
    });

    test('a membership carries the fields the venue picker needs', () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({
          'user': {'id': 'u1', 'email': 'owner@reservme.test', 'emailVerified': true},
          'venues': [
            {
              'orgId': 'org-1',
              'slug': 'katipunan-courts',
              'name': 'Katipunan Courts',
              'role': 'owner',
              'timezone': 'Asia/Manila',
              'currency': 'PHP',
              'theme': 'pine',
              'suspended': false,
              'activeSpaces': 4,
            },
          ],
        }),
      ]);

      final venue = (await RealAuthRepository(client, ApiMode.fake).me()).venues.single;
      expect(venue.slug, 'katipunan-courts');
      expect(venue.role, VenueRole.owner);
      expect(venue.timezone, 'Asia/Manila');
      expect(venue.activeSpaces, 4);
      expect(venue.suspended, isFalse);
      expect(stub.requests.single.path, '/mobile/me');
    });

    test('name may be absent — the column is nullable', () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({
          'user': {'id': 'u1', 'email': 'owner@reservme.test', 'name': null},
          'venues': <Map<String, dynamic>>[],
        }),
      ]);
      expect((await RealAuthRepository(client, ApiMode.fake).me()).user.name, isNull);
      expect(stub.requests, hasLength(1));
    });
  });

  group('delete account (#34)', () {
    test('the sole-owner refusal names the venues it would strand', () async {
      // Captured live. `reason` is what the sheet switches on; `venues` is what
      // it lists so the owner knows where to go and make someone else an owner.
      final (:client, :stub) = stubbedClient([
        const Reply(409, {
          'error': 'conflict',
          'reason': 'sole_owner',
          'message': 'You are the only owner of Test Courts.',
          'venues': ['test-courts'],
        }),
      ]);

      await expectLater(
        RealAuthRepository(client, ApiMode.fake).deleteAccount(),
        throwsA(
          isA<ApiError>()
              .having((e) => e.status, 'status', 409)
              .having((e) => e.reason, 'reason', 'sole_owner'),
        ),
      );
      expect(stub.requests.single.method, 'DELETE');
    });

    test('a clean delete is a plain ok', () async {
      final (:client, :stub) = stubbedClient([const Reply.ok({'ok': true})]);
      await RealAuthRepository(client, ApiMode.fake).deleteAccount();
      expect(stub.requests.single.method, 'DELETE');
      expect(stub.requests.single.path, '/mobile/me');
    });
  });

  group('the reset pair (#11, #26)', () {
    test('a wrong code and an unknown address refuse identically', () async {
      // The two halves have to agree, or asking for a reset and typing any six
      // digits tells you whether an address is registered.
      const message = 'That code does not match. Check the email again.';
      const refusal = {
        'error': 'invalid',
        'message': message,
        'fieldErrors': {'code': message},
      };

      final (:client, :stub) = stubbedClient([const Reply(400, refusal)], token: null);
      await expectLater(
        RealAuthRepository(client, ApiMode.fake)
            .resetPassword(email: 'nobody@reservme.test', code: '000000', password: 'x' * 12),
        throwsA(isA<ApiError>().having((e) => e.message, 'message', message)),
      );
      expect(stub.requests.single.path, '/mobile/auth/reset-password');
    });

    test('asking for a code says nothing about the address', () async {
      final (:client, :stub) = stubbedClient([const Reply.ok({'ok': true})], token: null);
      await RealAuthRepository(client, ApiMode.fake).requestPasswordReset('NOBODY@reservme.test ');
      expect(stub.requests.single.path, '/mobile/auth/forgot-password');
      expect(stub.requests.single.body['email'], 'NOBODY@reservme.test');
    });
  });
}
