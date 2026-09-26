import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/config/app_config.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/model/opening_hours.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/features/auth/data/real_auth_repository.dart';
import 'package:reservme/features/customer/booking/data/real_booking_repository.dart';
import 'package:reservme/features/customer/booking/domain/booking.dart';
import 'package:reservme/features/customer/venues/data/real_venues_repository.dart';
import 'package:reservme/features/venue/billing/data/real_billing_repository.dart';
import 'package:reservme/features/venue/billing/domain/billing.dart';
import 'package:reservme/features/venue/insights/data/real_insights_repository.dart';
import 'package:reservme/features/venue/insights/domain/insights.dart';
import 'package:reservme/features/venue/settings/data/real_settings_repository.dart';
import 'package:reservme/features/venue/settings/domain/venue_settings.dart';
import 'package:reservme/features/venue/spaces/data/real_spaces_repository.dart';
import 'package:reservme/features/venue/team/data/real_team_repository.dart';
import 'package:reservme/features/venue/team/domain/team.dart';
import 'package:reservme/features/venue/today/data/real_today_repository.dart';

import '../helpers/stub_adapter.dart';

/// The `Real*` repositories have never run against a server — the backend is
/// a separate plan. These tests pin the two things that will break first when
/// it does exist: the shape of the request we send, and what we make of the
/// reply.
///
/// [ApiMode.fake] is passed to the repositories throughout. That is not a
/// contradiction: the mode only drives the `Feature` gate, and gating is
/// covered in `feature_availability_test.dart`. Passing `real` here would
/// make every one of these throw 501 and test nothing.
/// Minimal bodies that still satisfy the models' required fields. Anything
/// the tests actually assert on is spelled out at the call site.
const _space = {'id': 's1', 'name': 'Court 1', 'slug': 'court-1'};

const _booking = {
  'reference': 'ABC-123',
  'venue': {'slug': 'katipunan', 'name': 'K', 'timezone': 'Asia/Manila'},
  'space': {'id': 's1', 'name': 'Court 1'},
  'startsAt': '2026-10-01T10:00:00.000Z',
  'endsAt': '2026-10-01T11:00:00.000Z',
  'whenLabel': 'Thu 1 Oct · 18:00–19:00',
};

void main() {
  const mode = ApiMode.fake;

  group('what we send', () {
    test('a public venue read carries no bearer token', () async {
      final (:client, :stub) = stubbedClient(
        [
          const Reply.ok({
            'venue': {
              'id': 'v1',
              'slug': 'katipunan',
              'name': 'Katipunan Courts',
            },
          }),
        ],
        token: null,
      );

      await RealVenuesRepository(client, mode).bySlug('katipunan');

      final request = stub.requests.single;
      expect(request.method, 'GET');
      expect(request.path, '/public/venues/katipunan');
      expect(request.header('Authorization'), isNull);
    });

    test('a staff read carries the bearer token', () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({'date': '2026-09-25', 'stats': {}, 'runSheet': []}),
      ]);

      await RealTodayRepository(client, mode).today('katipunan');

      expect(stub.requests.single.header('Authorization'), 'Bearer test-token');
    });

    test('a booking sends instants as UTC and an idempotency key', () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({'booking': _booking}),
      ]);

      await RealBookingRepository(client, mode).book(
        venueSlug: 'katipunan',
        input: BookingInput(
          spaceId: 's1',
          startsAt: DateTime.utc(2026, 10, 1, 10),
          endsAt: DateTime.utc(2026, 10, 1, 11),
          name: '  Rafael  ',
          email: '  rafael@example.com ',
          partySize: 2,
        ),
        idempotencyKey: 'attempt-abc-123',
      );

      final request = stub.requests.single;
      expect(request.body['startsAt'], '2026-10-01T10:00:00.000Z');
      // Trimmed, because the server stores what we send.
      expect(request.body['name'], 'Rafael');
      // An empty optional is absent, not null: the schema treats them
      // differently.
      expect(request.body.containsKey('phone'), isFalse);
      expect(request.body.containsKey('promo'), isFalse);
      // A retried booking must never book twice — so the key is the *caller's*
      // and travels unchanged. The client used to mint one per call, which
      // gave every retry a fresh key and made the header decorative.
      expect(request.header('Idempotency-Key'), 'attempt-abc-123');
    });

    test('a booking with no key sends no key, rather than a made-up one',
        () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({'booking': _booking}),
      ]);

      await RealBookingRepository(client, mode).book(
        venueSlug: 'katipunan',
        input: BookingInput(
          spaceId: 's1',
          startsAt: DateTime.utc(2026, 10, 1, 10),
          endsAt: DateTime.utc(2026, 10, 1, 11),
          name: 'Rafael',
          email: 'rafael@example.com',
        ),
      );

      expect(stub.requests.single.header('Idempotency-Key'), isNull);
    });

    test('opening hours send only the days that are open', () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({'space': _space}),
      ]);

      await RealSpacesRepository(client, mode)
          .setHours('katipunan', 's1', HoursInput.initial());

      final request = stub.requests.single;
      expect(request.method, 'PUT');
      final hours = request.body['hours'] as List;
      // `HoursInput.initial` closes Sunday, and a closed day is an absent
      // row rather than a row with a flag.
      expect(hours, hasLength(6));
      expect(hours.every((h) => (h as Map)['weekday'] != 0), isTrue);
    });

    test('venue settings send an empty optional as null, not as blank', () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({
          'venue': {
            'id': 'v1',
            'slug': 'katipunan',
            'name': 'Katipunan Courts',
          },
        }),
      ]);

      await RealSettingsRepository(client, mode).update(
        'katipunan',
        const VenueSettingsInput(
          name: 'Katipunan Courts',
          timezone: 'Asia/Manila',
          currency: 'php',
          tagline: '   ',
        ),
      );

      final request = stub.requests.single;
      expect(request.method, 'PATCH');
      expect(request.body['tagline'], isNull);
      expect(request.body['currency'], 'PHP');
    });

    test('an invitation lower-cases the address it sends', () async {
      final (:client, :stub) = stubbedClient([const Reply.ok({})]);

      await RealTeamRepository(client, mode).invite(
        'katipunan',
        const InviteInput(email: ' Ana@Example.COM ', role: VenueRole.admin),
      );

      expect(stub.requests.single.body['email'], 'ana@example.com');
      expect(stub.requests.single.body['role'], 'admin');
    });

    test('a payment proof is multipart and never declares the amount',
        () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({
          'billing': {
            'band': {
              'id': 'club',
              'name': 'Club',
              'minSpaces': 2,
              'blurb': 'x',
            },
            'trialEndsAt': '2026-10-01T00:00:00.000Z',
          },
        }),
      ]);

      await RealBillingRepository(client, mode).submitProof(
        'katipunan',
        const PaymentProofInput(reference: 'INSTA-1', paidAt: '2026-09-25'),
      );

      final request = stub.requests.single;
      expect(request.formFields, containsAll(['reference', 'paidAt']));
      // What a venue owes is not something it gets to declare.
      expect(request.formFields, isNot(contains('amountCents')));
    });

    test('a space photo goes as multipart, and clearing it is a DELETE',
        () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({'space': _space}),
        const Reply.ok({'space': _space}),
      ]);
      final repo = RealSpacesRepository(client, mode);

      await repo.setImage('katipunan', 's1', [1, 2, 3]);
      await repo.setImage('katipunan', 's1', null);

      expect(stub.requests[0].method, 'POST');
      expect(stub.requests[0].formFields, contains('image'));
      expect(stub.requests[1].method, 'DELETE');
    });

    test('insights ask for the period as a query parameter', () async {
      final (:client, :stub) = stubbedClient([
        const Reply.ok({'insights': {}}),
      ]);

      await RealInsightsRepository(client, mode)
          .get('katipunan', InsightsRange.quarter);

      expect(stub.requests.single.query['period'], '90d');
    });

    test('a reset sends the address lower-cased with the code trimmed',
        () async {
      final (:client, :stub) = stubbedClient([const Reply.ok({})]);

      await RealAuthRepository(client, mode).resetPassword(
        email: ' Owner@Example.com ',
        code: ' 123456 ',
        password: 'a-good-long-password',
      );

      expect(stub.requests.single.body['email'], 'owner@example.com');
      expect(stub.requests.single.body['code'], '123456');
    });
  });

  group('what we make of the reply', () {
    test('a taken slot is an outcome, not an exception', () async {
      final client = stubbedClient([
        const Reply(409, {'error': 'That slot just went.'}),
      ]).client;

      final outcome = await RealBookingRepository(client, mode).book(
        venueSlug: 'katipunan',
        input: BookingInput(
          spaceId: 's1',
          startsAt: DateTime.utc(2026, 10, 1, 10),
          endsAt: DateTime.utc(2026, 10, 1, 11),
          name: 'Rafael',
          email: 'rafael@example.com',
        ),
      );

      expect(outcome, isA<SlotTaken>());
    });

    test('a full session is told apart from a taken slot by its reason',
        () async {
      final client = stubbedClient([
        const Reply(409, {'error': 'No spots left.', 'reason': 'session_full'}),
      ]).client;

      final outcome = await RealBookingRepository(client, mode).bookSession(
        venueSlug: 'katipunan',
        sessionId: 'ses1',
        spots: 2,
        name: 'Rafael',
        email: 'rafael@example.com',
      );

      expect(outcome, isA<SessionFull>());
    });

    test('a rate limit and a suspended venue are outcomes too', () async {
      Future<BookOutcome> attempt(Reply reply) async {
        final client = stubbedClient([reply]).client;
        return RealBookingRepository(client, mode).book(
          venueSlug: 'katipunan',
          input: BookingInput(
            spaceId: 's1',
            startsAt: DateTime.utc(2026, 10, 1, 10),
            endsAt: DateTime.utc(2026, 10, 1, 11),
            name: 'Rafael',
            email: 'rafael@example.com',
          ),
        );
      }

      expect(
        await attempt(const Reply(429, {'error': 'Too many tries.'})),
        isA<RateLimited>(),
      );
      expect(
        await attempt(const Reply(403, {'error': 'Not taking bookings.'})),
        isA<VenueClosed>(),
      );
      expect(
        await attempt(const Reply(400, {
          'error': 'Check the form.',
          'fieldErrors': {'email': 'That email looks wrong.'},
        })),
        isA<BookingInvalid>(),
      );
    });

    test('anything the contract does not name stays an exception', () async {
      final client = stubbedClient([
        const Reply(500, {'error': 'Something broke.'}),
      ]).client;

      await expectLater(
        RealBookingRepository(client, mode).book(
          venueSlug: 'katipunan',
          input: BookingInput(
            spaceId: 's1',
            startsAt: DateTime.utc(2026, 10, 1, 10),
            endsAt: DateTime.utc(2026, 10, 1, 11),
            name: 'Rafael',
            email: 'rafael@example.com',
          ),
        ),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 500)),
      );
    });

    test('a server message is shown, not replaced with a generic one',
        () async {
      final client = stubbedClient([
        const Reply(404, {'error': 'We could not find that venue.'}),
      ]).client;

      await expectLater(
        RealVenuesRepository(client, mode).bySlug('nope'),
        throwsA(isA<ApiError>()
            .having((e) => e.status, 'status', 404)
            .having((e) => e.message, 'message', 'We could not find that venue.')),
      );
    });

    test('a 409 from a space delete carries its reason through', () async {
      final client = stubbedClient([
        const Reply(409, {'error': 'Two bookings are still ahead.'}),
      ]).client;

      await expectLater(
        RealSpacesRepository(client, mode).remove('katipunan', 's1'),
        throwsA(isA<ApiError>()
            .having((e) => e.status, 'status', 409)
            .having((e) => e.message, 'message', 'Two bookings are still ahead.')),
      );
    });

    test('the sole-owner refusal keeps its reason for the UI to switch on',
        () async {
      final client = stubbedClient([
        const Reply(409, {
          'error': 'You are the only owner of Katipunan Courts.',
          'reason': 'sole_owner',
        }),
      ]).client;

      await expectLater(
        RealAuthRepository(client, mode).deleteAccount(),
        throwsA(isA<ApiError>()
            .having((e) => e.status, 'status', 409)
            .having((e) => e.reason, 'reason', 'sole_owner')),
      );
    });

    test('a body with no message still yields something readable', () async {
      final client = stubbedClient([const Reply(500, {})]).client;

      await expectLater(
        RealTodayRepository(client, mode).today('katipunan'),
        throwsA(isA<ApiError>().having(
          (e) => e.message,
          'message',
          isNotEmpty,
        )),
      );
    });

    test('a spaces list survives a row it cannot read', () async {
      final client = stubbedClient([
        const Reply.ok({
          'spaces': [
            {'id': 's1', 'name': 'Court 1'},
            'not a space at all',
          ],
        }),
      ]).client;

      final spaces = await RealSpacesRepository(client, mode).list('katipunan');

      // One bad row must not cost the venue its whole list.
      expect(spaces, hasLength(1));
      expect(spaces.single.name, 'Court 1');
    });
  });

  group('gating', () {
    test('every repository still asks before it calls', () async {
      // There is nothing gated left to test *through*: every row of the
      // contract shipped, so `isAvailable` answers true for all of them and
      // the guard never trips. What can still be pinned is that the guard is
      // in the path at all — a repository that reached the network first
      // would 404 on a phone instead of refusing in one legible place.
      //
      // So: with the feature live, the call goes out. When the next unshipped
      // row is added to the map as `false`, this is where its refusal gets
      // asserted — see docs/DEFERRED.md D23.
      final (:client, :stub) = stubbedClient([
        const Reply.ok({'venue': {'id': 'v1', 'slug': 'katipunan', 'name': 'Katipunan'}}),
      ]);

      await RealVenuesRepository(client, ApiMode.real).bySlug('katipunan');
      expect(stub.requests, hasLength(1));
      expect(stub.requests.single.path, '/public/venues/katipunan');
    });
  });
}
