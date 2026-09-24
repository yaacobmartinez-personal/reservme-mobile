import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/venue/team/application/team_controller.dart';
import 'package:reservme/features/venue/team/domain/team.dart';

import '../helpers/fakes.dart';

void main() {
  const slug = FakeVenues.katipunan;

  Future<void> signIn(ProviderContainer container, String email) => container
      .read(authControllerProvider.notifier)
      .signIn(email: email, password: FakeAccounts.password);

  group('invite input', () {
    test('needs someone to invite, and a real address', () {
      expect(const InviteInput(email: '  ').validate(), 'Who are you inviting?');
      expect(
        const InviteInput(email: 'nope').validate(),
        "That email doesn't look right.",
      );
      expect(const InviteInput(email: 'a@b.co').validate(), isNull);
    });

    test('the address is lower-cased on the way out', () {
      expect(
        const InviteInput(email: '  Ana@Example.COM ').toJson()['email'],
        'ana@example.com',
      );
    });
  });

  group('the team', () {
    test('lists members owners-first with your own role', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final team = await container.read(teamControllerProvider(slug).future);

      expect(team.members, isNotEmpty);
      expect(team.members.first.role, VenueRole.owner);
      expect(team.yourRole, VenueRole.owner);
      expect(team.members.where((m) => m.isSelf), hasLength(1));
      expect(team.canManage, isTrue);
    });

    test('an invitation is created once and only once', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final notifier = container.read(teamControllerProvider(slug).notifier);
      await container.read(teamControllerProvider(slug).future);

      await notifier.invite(const InviteInput(email: 'ana@example.com'));
      var team = container.read(teamControllerProvider(slug)).value!;
      expect(team.invitations.where((i) => i.email == 'ana@example.com'),
          hasLength(1));
      // And the fake "emailed" them.
      expect(world.store.outbox.where((e) => e.to == 'ana@example.com'),
          isNotEmpty);

      await expectLater(
        notifier.invite(const InviteInput(email: 'ana@example.com')),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 409)),
      );

      await notifier.cancelInvite(team.invitations
          .firstWhere((i) => i.email == 'ana@example.com')
          .id);
      team = container.read(teamControllerProvider(slug)).value!;
      expect(team.invitations.where((i) => i.email == 'ana@example.com'),
          isEmpty);
    });

    test('someone already on the team cannot be invited again', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      await container.read(teamControllerProvider(slug).future);

      await expectLater(
        container
            .read(teamControllerProvider(slug).notifier)
            .invite(const InviteInput(email: FakeAccounts.staffEmail)),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 409)),
      );
    });

    test('the last owner cannot step down until there is another', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final notifier = container.read(teamControllerProvider(slug).notifier);
      var team = await container.read(teamControllerProvider(slug).future);
      expect(team.ownerCount, 1);
      final me = team.members.firstWhere((m) => m.isSelf);

      // Stepping down while you are the only owner would leave the venue with
      // nobody who can pay for it or hand it on.
      await expectLater(
        notifier.setRole(me.id, VenueRole.admin),
        throwsA(isA<ApiError>()
            .having((e) => e.status, 'status', 409)
            .having((e) => e.message, 'message',
                'Every venue needs an owner. Make someone else an owner first.')),
      );
      await expectLater(
        notifier.remove(me.id),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 409)),
      );

      // Hand it over first, and stepping down is fine.
      final staff =
          team.members.firstWhere((m) => m.email == FakeAccounts.staffEmail);
      await notifier.setRole(staff.id, VenueRole.owner);
      expect(container.read(teamControllerProvider(slug)).value!.ownerCount, 2);

      await notifier.setRole(me.id, VenueRole.admin);
      team = container.read(teamControllerProvider(slug)).value!;
      expect(team.ownerCount, 1);
      expect(team.members.firstWhere((m) => m.isSelf).role, VenueRole.admin);
    });

    test('an admin cannot touch an owner at all', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      var team = await container.read(teamControllerProvider(slug).future);

      // Make the staff member an admin, then work as them.
      final staff =
          team.members.firstWhere((m) => m.email == FakeAccounts.staffEmail);
      await container
          .read(teamControllerProvider(slug).notifier)
          .setRole(staff.id, VenueRole.admin);
      await container.read(authControllerProvider.notifier).signOut();
      await signIn(container, FakeAccounts.staffEmail);
      // The team we already read belongs to the previous session; a new one
      // has to be fetched or `yourRole` is whoever was signed in before.
      container.invalidate(teamControllerProvider(slug));

      team = await container.read(teamControllerProvider(slug).future);
      expect(team.canManage, isTrue);
      expect(team.canAssignOwner, isFalse);
      final owner = team.members.firstWhere((m) => m.role == VenueRole.owner);

      await expectLater(
        container
            .read(teamControllerProvider(slug).notifier)
            .setRole(owner.id, VenueRole.member),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 403)),
      );
    });

    test('front desk can see the team but not change it', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.staffEmail);

      final team = await container.read(teamControllerProvider(slug).future);
      expect(team.members, isNotEmpty);
      expect(team.canManage, isFalse);

      await expectLater(
        container
            .read(teamControllerProvider(slug).notifier)
            .invite(const InviteInput(email: 'ana@example.com')),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 403)),
      );
    });

    test('a member is removed and loses the venue', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final notifier = container.read(teamControllerProvider(slug).notifier);
      final team = await container.read(teamControllerProvider(slug).future);
      final staff =
          team.members.firstWhere((m) => m.email == FakeAccounts.staffEmail);

      await notifier.remove(staff.id);

      final after = container.read(teamControllerProvider(slug)).value!;
      expect(after.members.where((m) => m.id == staff.id), isEmpty);
    });
  });
}
