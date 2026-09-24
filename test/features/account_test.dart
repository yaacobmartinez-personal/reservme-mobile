import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/fake_store.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/venue/team/application/team_controller.dart';

import '../helpers/fakes.dart';

void main() {
  const slug = FakeVenues.katipunan;

  Future<void> signIn(
    ProviderContainer container,
    String email, [
    String? password,
  ]) =>
      container.read(authControllerProvider.notifier).signIn(
            email: email,
            password: password ?? FakeAccounts.password,
          );

  group('resetting a password in the app (D14)', () {
    test('the code from the email changes the password', () async {
      final world = TestWorld();
      final container = world.container();
      final auth = container.read(authControllerProvider.notifier);

      await auth.requestPasswordReset(FakeAccounts.ownerEmail);
      final code = world.store.emailCodes[FakeAccounts.ownerEmail]!;

      await auth.resetPassword(
        email: FakeAccounts.ownerEmail,
        code: code,
        password: 'a-brand-new-password',
      );

      // The old password is gone and the new one works.
      await expectLater(
        signIn(container, FakeAccounts.ownerEmail),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 401)),
      );
      await signIn(container, FakeAccounts.ownerEmail, 'a-brand-new-password');
      expect(container.read(authControllerProvider).isSignedIn, isTrue);

      await auth.signOut();
    });

    test('a used code cannot be used twice', () async {
      final world = TestWorld();
      final container = world.container();
      final auth = container.read(authControllerProvider.notifier);
      await auth.requestPasswordReset(FakeAccounts.ownerEmail);
      final code = world.store.emailCodes[FakeAccounts.ownerEmail]!;

      await auth.resetPassword(
        email: FakeAccounts.ownerEmail,
        code: code,
        password: 'a-brand-new-password',
      );
      await expectLater(
        auth.resetPassword(
          email: FakeAccounts.ownerEmail,
          code: code,
          password: 'another-long-password',
        ),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 400)),
      );
    });

    test('the short-password rule is the same one sign-up applies', () async {
      final world = TestWorld();
      final container = world.container();
      final auth = container.read(authControllerProvider.notifier);
      await auth.requestPasswordReset(FakeAccounts.ownerEmail);
      final code = world.store.emailCodes[FakeAccounts.ownerEmail]!;

      await expectLater(
        auth.resetPassword(
          email: FakeAccounts.ownerEmail,
          code: code,
          password: 'short',
        ),
        throwsA(isA<ApiError>().having(
          (e) => e.message,
          'message',
          'Use at least 10 characters.',
        )),
      );
    });

    test('an address with no account refuses exactly like a wrong code',
        () async {
      final world = TestWorld();
      final container = world.container();

      // The request step is deliberately silent about which emails exist;
      // this step must not undo that by refusing differently.
      await expectLater(
        container.read(authControllerProvider.notifier).resetPassword(
              email: 'nobody@example.com',
              code: '123456',
              password: 'a-good-long-password',
            ),
        throwsA(isA<ApiError>().having(
          (e) => e.message,
          'message',
          "That code doesn't match. Check the email again.",
        )),
      );
    });
  });

  group('deleting an account (D11)', () {
    test('the sole owner of a venue is refused, and nothing is lost', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final usersBefore = world.store.users.length;

      await expectLater(
        container.read(authControllerProvider.notifier).deleteAccount(),
        throwsA(isA<ApiError>()
            .having((e) => e.status, 'status', 409)
            .having((e) => e.reason, 'reason', 'sole_owner')),
      );

      expect(world.store.users, hasLength(usersBefore));
      expect(container.read(authControllerProvider).isSignedIn, isTrue);

      await container.read(authControllerProvider.notifier).signOut();
    });

    test('the refusal names the venues that would be stranded', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      try {
        await container.read(authControllerProvider.notifier).deleteAccount();
        fail('expected a refusal');
      } on ApiError catch (e) {
        // The owner owns all three seeded venues alone.
        expect(e.message, contains('Katipunan'));
        expect(e.message, contains('only owner'));
      }

      await container.read(authControllerProvider.notifier).signOut();
    });

    test('a staff member can delete, and the venue keeps its bookings',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.staffEmail);
      final venueId = world.store.venueBySlug(slug)!.id;
      final bookingsBefore = world.store.reservationsOf(venueId).length;

      await container.read(authControllerProvider.notifier).deleteAccount();

      expect(container.read(authControllerProvider).isSignedIn, isFalse);
      expect(world.store.userByEmail(FakeAccounts.staffEmail), isNull);
      // Bookings belong to the venue, not to whoever took them.
      expect(world.store.reservationsOf(venueId), hasLength(bookingsBefore));
    });

    test('handing the venue over first lets the owner leave', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      // Make someone else an owner of every venue this user owns alone.
      for (final membership in container.read(authControllerProvider).venuesOrEmpty) {
        if (membership.role != VenueRole.owner) continue;
        final team =
            await container.read(teamControllerProvider(membership.slug).future);
        final other = team.members.where((m) => !m.isSelf).firstOrNull;
        if (other == null) {
          // Nobody else works there, so the venue cannot be handed over at
          // all — drop the membership the way deleting the venue would.
          world.store.memberships.removeWhere((m) => m.venueId == membership.orgId);
          continue;
        }
        await container
            .read(teamControllerProvider(membership.slug).notifier)
            .setRole(other.id, VenueRole.owner);
      }

      await container.read(authControllerProvider.notifier).deleteAccount();

      expect(container.read(authControllerProvider).isSignedIn, isFalse);
      expect(world.store.userByEmail(FakeAccounts.ownerEmail), isNull);
    });

    test('the notes the deleted user wrote go with them', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.staffEmail);
      final staffId = container.read(authControllerProvider).userOrNull!.id;
      world.store.customerNotes.add(FakeCustomerNote(
        id: world.store.nextId('n'),
        customerId: world.store.customers.first.id,
        authorUserId: staffId,
        body: 'Regular, always early.',
        createdAt: DateTime.now().toUtc(),
      ));

      await container.read(authControllerProvider.notifier).deleteAccount();

      expect(
        world.store.customerNotes.where((n) => n.authorUserId == staffId),
        isEmpty,
      );
    });
  });
}
