import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/core/network/token_codec.dart';
import 'package:reservme/core/network/unauthorized_events.dart';
import 'package:reservme/core/storage/boot_data.dart';
import 'package:reservme/core/storage/prefs.dart';
import 'package:reservme/core/storage/secure_store.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/auth/application/auth_state.dart';
import 'package:reservme/features/auth/domain/user.dart';
import 'package:reservme/features/shell/application/app_mode_controller.dart';

import '../helpers/fakes.dart';

void main() {
  test('signing in stores the session and pulls the venue list', () async {
    final world = TestWorld();
    final container = world.container();
    final auth = container.read(authControllerProvider.notifier);

    await auth.signIn(email: FakeAccounts.ownerEmail, password: FakeAccounts.password);

    final state = container.read(authControllerProvider);
    expect(state, isA<SignedIn>());
    expect(state.userOrNull?.email, FakeAccounts.ownerEmail);
    expect(state.hasVenueAccess, isTrue);
    // The owner runs more than one venue, and a suspended one still lists.
    expect(state.venuesOrEmpty.length, greaterThan(1));
    expect((state as SignedIn).venuesFresh, isTrue);

    // Persisted, so the next boot does not need the network.
    expect(world.secure.values[SecureStore.keyToken], isNotNull);
    expect(world.secure.values[SecureStore.keyUser], contains(FakeAccounts.ownerEmail));
    expect(world.secure.values[SecureStore.keyVenues], isNotNull);
  });

  test('a wrong password leaves the app signed out with the server wording', () async {
    final world = TestWorld();
    final container = world.container();

    await expectLater(
      container
          .read(authControllerProvider.notifier)
          .signIn(email: FakeAccounts.ownerEmail, password: 'nope'),
      throwsA(isA<ApiError>()
          .having((e) => e.status, 'status', 401)
          .having((e) => e.message, 'message', contains("don't match"))),
    );
    expect(container.read(authControllerProvider), isA<SignedOut>());
    expect(world.secure.values[SecureStore.keyToken], isNull);
  });

  test('a saved session is restored on boot without waiting for the network', () {
    final token = TokenCodec.mintFake('usr_owner', testNow.add(const Duration(days: 30)));
    final world = TestWorld(
      boot: BootData(
        token: token,
        user: const User(id: 'usr_owner', email: FakeAccounts.ownerEmail),
        welcomeSeen: true,
      ),
    );

    final state = world.container().read(authControllerProvider);

    expect(state.isSignedIn, isTrue);
    expect(state.userOrNull?.id, 'usr_owner');
  });

  test('an expired token is not a session', () {
    final world = TestWorld(
      boot: BootData(
        token: TokenCodec.mintFake('usr_owner', testNow.subtract(const Duration(minutes: 1))),
        user: const User(id: 'usr_owner', email: FakeAccounts.ownerEmail),
        welcomeSeen: true,
      ),
    );

    final state = world.container().read(authControllerProvider);

    expect(state, isA<SignedOut>());
    expect((state as SignedOut).reason, SignOutReason.sessionExpired);
  });

  test('a corrupted token is not a session either', () {
    final world = TestWorld(
      boot: const BootData(
        token: 'not-a-token',
        user: User(id: 'usr_owner', email: FakeAccounts.ownerEmail),
        welcomeSeen: true,
      ),
    );

    expect(world.container().read(authControllerProvider), isA<SignedOut>());
  });

  test('a 401 from anywhere ends the session', () async {
    final world = TestWorld();
    final container = world.container();
    await container
        .read(authControllerProvider.notifier)
        .signIn(email: FakeAccounts.ownerEmail, password: FakeAccounts.password);

    container.read(unauthorizedEventsProvider).emit();
    await Future<void>.delayed(Duration.zero);

    final state = container.read(authControllerProvider);
    expect(state, isA<SignedOut>());
    expect((state as SignedOut).reason, SignOutReason.sessionExpired);
  });

  test('signing out wipes the session, the venue choice and the read cache', () async {
    final world = TestWorld();
    final container = world.container();
    final auth = container.read(authControllerProvider.notifier);
    await auth.signIn(email: FakeAccounts.ownerEmail, password: FakeAccounts.password);
    await world.prefs.setString(Prefs.keySelectedVenue, 'katipunan');
    await world.local.saveVenueCache('katipunan', 'today', {'date': '2026-09-26'}, now: testNow);

    await auth.signOut();

    expect(container.read(authControllerProvider), isA<SignedOut>());
    expect(world.secure.values, isEmpty);
    expect(await world.prefs.getString(Prefs.keySelectedVenue), isNull);
    expect(await world.local.readVenueCache('katipunan', 'today'), isNull);
    // And the app drops back to the side of it customers see.
    expect(container.read(appModeControllerProvider), AppMode.customer);
  });

  test('a reset request is silent whether or not the email is known', () async {
    final world = TestWorld();
    final auth = world.container().read(authControllerProvider.notifier);

    await auth.requestPasswordReset('stranger@example.com');
    expect(world.store.outbox, isEmpty);

    await auth.requestPasswordReset(FakeAccounts.ownerEmail);
    expect(world.store.outbox, isNotEmpty);
  });
}
