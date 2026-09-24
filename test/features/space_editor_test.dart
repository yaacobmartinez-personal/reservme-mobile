import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/model/opening_hours.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/venue/spaces/application/space_editor_controller.dart';
import 'package:reservme/features/venue/spaces/application/spaces_controller.dart';
import 'package:reservme/features/venue/spaces/domain/space_input.dart';
import 'package:reservme/features/venue/venue_providers.dart';

import '../helpers/fakes.dart';

void main() {
  const slug = FakeVenues.katipunan;

  Future<void> signIn(ProviderContainer container, String email) => container
      .read(authControllerProvider.notifier)
      .signIn(email: email, password: FakeAccounts.password);

  /// The first active space at Katipunan, which is what the editor opens on.
  Future<String> firstSpaceId(ProviderContainer container) async {
    final spaces = await container.read(spacesProvider(slug).future);
    return spaces.firstWhere((s) => s.isActive).id;
  }

  group('space input', () {
    test('toCents forgives what an owner actually types', () {
      expect(SpaceInput.toCents('900'), 90000);
      expect(SpaceInput.toCents('900.50'), 90050);
      expect(SpaceInput.toCents('₱1,200'), 120000);
      // Nonsense is zero, not a crash — the same as the web's parse.
      expect(SpaceInput.toCents(''), 0);
      expect(SpaceInput.toCents('abc'), 0);
    });

    test('the schema refuses with the server\'s own wording', () {
      const ok = SpaceInput(name: 'Court 5');
      expect(ok.validate(), isNull);
      expect(const SpaceInput(name: '  ').validate(), 'Give the space a name.');
      expect(
        const SpaceInput(name: 'Court 5', capacity: 0).validate(),
        'Capacity is between 1 and 500.',
      );
      expect(
        const SpaceInput(name: 'Court 5', slotMinutes: 10).validate(),
        'A slot is between 15 minutes and 24 hours.',
      );
      expect(
        const SpaceInput(name: 'Court 5', bufferMinutes: 300).validate(),
        'A buffer is between none and 4 hours.',
      );
    });
  });

  group('pricing rule input', () {
    test('needs a day and an end after the start', () {
      expect(
        const PricingRuleInput(weekdays: []).validate(),
        'Pick at least one day.',
      );
      expect(
        const PricingRuleInput(weekdays: [1], startsAt: '20:00', endsAt: '18:00')
            .validate(),
        'The end time must be after the start.',
      );
      expect(const PricingRuleInput(weekdays: [1]).validate(), isNull);
    });

    test('toggling a day keeps the list sorted and reversible', () {
      var input = const PricingRuleInput(weekdays: [1]);
      input = input.toggleDay(6).toggleDay(0);
      expect(input.weekdays, [0, 1, 6]);
      expect(input.toggleDay(1).weekdays, [0, 6]);
    });
  });

  group('closure input', () {
    ClosureInput at(String from, String to) => ClosureInput(
          fromDate: '2026-10-01',
          fromTime: from,
          toDate: '2026-10-01',
          toTime: to,
        );

    test('an end that is not after the start is refused', () {
      expect(at('18:00', '20:00').validate(), isNull);
      expect(at('20:00', '18:00').validate(), 'Please give a valid start and end.');
      expect(at('18:00', '18:00').validate(), 'Please give a valid start and end.');
    });
  });

  group('the editor', () {
    test('loads the space with its week, rules and bookings', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final id = await firstSpaceId(container);

      final detail = await container.read(spaceEditorProvider(slug, id).future);

      expect(detail.id, id);
      expect(detail.week.days, hasLength(7));
      expect(detail.hours, isNotEmpty);
      expect(detail.isActive, isTrue);
    });

    test('saving the basics reprices the space', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final id = await firstSpaceId(container);
      final editor = container.read(spaceEditorProvider(slug, id).notifier);
      final before = await container.read(spaceEditorProvider(slug, id).future);

      await editor.saveBasics(SpaceInput(
        name: 'Court One',
        kind: SpaceKind.court,
        capacity: before.capacity,
        slotMinutes: 90,
        priceCents: 45000,
      ));

      final after = container.read(spaceEditorProvider(slug, id)).value!;
      expect(after.name, 'Court One');
      expect(after.slotMinutes, 90);
      expect(after.priceCents, 45000);
    });

    test('a closed day loses its row, and closing every day is refused',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final id = await firstSpaceId(container);
      final editor = container.read(spaceEditorProvider(slug, id).notifier);

      await editor.saveHours(HoursInput.initial());
      final after = container.read(spaceEditorProvider(slug, id)).value!;
      // `HoursInput.initial` closes Sunday, so six rows survive.
      expect(after.hours, hasLength(6));
      expect(after.hours.where((h) => h.weekday == 0), isEmpty);

      await expectLater(
        editor.saveHours(HoursInput([
          for (var d = 0; d < 7; d++) DayHours(weekday: d, open: false),
        ])),
        throwsA(isA<ApiError>()),
      );
    });

    test('a peak rule shows up and can be taken away again', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final id = await firstSpaceId(container);
      final editor = container.read(spaceEditorProvider(slug, id).notifier);
      final wasEmpty =
          (await container.read(spaceEditorProvider(slug, id).future))
              .pricingRules
              .length;

      await editor.addPricingRule(const PricingRuleInput(
        label: 'Evening peak',
        weekdays: [1, 2, 3, 4, 5],
        startsAt: '18:00',
        endsAt: '22:00',
        priceCents: 60000,
      ));
      var now = container.read(spaceEditorProvider(slug, id)).value!;
      expect(now.pricingRules, hasLength(wasEmpty + 1));
      final added = now.pricingRules.firstWhere((r) => r.label == 'Evening peak');
      expect(added.daysLabel, 'Weekdays');
      expect(added.window, '18:00–22:00');

      await editor.removePricingRule(added.id);
      now = container.read(spaceEditorProvider(slug, id)).value!;
      expect(now.pricingRules.where((r) => r.id == added.id), isEmpty);
    });

    test('a closure is added in the venue\'s own zone and can be removed',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final id = await firstSpaceId(container);
      final editor = container.read(spaceEditorProvider(slug, id).notifier);
      final before = (await container.read(spaceEditorProvider(slug, id).future))
          .closures
          .length;

      // Far enough ahead that the seeded "now" cannot have passed it.
      await editor.addClosure(ClosureInput(
        spaceId: id,
        fromDate: '2027-03-01',
        fromTime: '09:00',
        toDate: '2027-03-01',
        toTime: '18:00',
        reason: 'Resurfacing',
      ));
      var now = container.read(spaceEditorProvider(slug, id)).value!;
      expect(now.closures, hasLength(before + 1));
      final added = now.closures.firstWhere((c) => c.reason == 'Resurfacing');
      expect(added.isWholeVenue, isFalse);

      await editor.removeClosure(added.id);
      now = container.read(spaceEditorProvider(slug, id)).value!;
      expect(now.closures.where((c) => c.id == added.id), isEmpty);
    });

    test('a whole-venue closure is scoped to the venue, not the space',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final id = await firstSpaceId(container);

      await container.read(spaceEditorProvider(slug, id).notifier).addClosure(
            const ClosureInput(
              fromDate: '2027-03-02',
              fromTime: '00:00',
              toDate: '2027-03-03',
              toTime: '00:00',
              reason: 'Holiday',
            ),
          );

      final now = container.read(spaceEditorProvider(slug, id)).value!;
      expect(
        now.closures.firstWhere((c) => c.reason == 'Holiday').isWholeVenue,
        isTrue,
      );
    });

    test('front desk cannot reshape a space, only look at it', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.staffEmail);
      final id = await firstSpaceId(container);

      // Reading is fine.
      final detail = await container.read(spaceEditorProvider(slug, id).future);
      expect(detail.id, id);

      await expectLater(
        container
            .read(spaceEditorProvider(slug, id).notifier)
            .saveBasics(const SpaceInput(name: 'Nope')),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 403)),
      );
    });

    test('deleting a space with bookings ahead is refused, pausing is not',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final spaces = await container.read(spacesProvider(slug).future);
      final busy = spaces.firstWhere((s) => s.upcomingBookings > 0);
      final editor = container.read(spaceEditorProvider(slug, busy.id).notifier);

      await expectLater(
        editor.delete(),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 409)),
      );

      // The reversible thing still works.
      await editor.setActive(false);
      expect(container.read(spaceEditorProvider(slug, busy.id)).value!.isActive,
          isFalse);
    });

    test('a new space is bookable the moment it exists', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final created = await container.read(spacesRepositoryProvider).create(
            slug,
            const SpaceInput(name: 'Court 5', priceCents: 40000),
          );

      // The web seeds all seven days 08:00–22:00 on create, or the space
      // would be unbookable the moment it appeared.
      expect(created.hours, hasLength(7));
      expect(created.hours.first.opensAt, '08:00');
      expect(created.slug, 'court-5');
      expect(created.isUnbookable, isFalse);
    });

    test('a second space with the same name gets a distinct address', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final repo = container.read(spacesRepositoryProvider);

      final first = await repo.create(slug, const SpaceInput(name: 'Pitch'));
      final second = await repo.create(slug, const SpaceInput(name: 'Pitch'));

      expect(first.slug, 'pitch');
      expect(second.slug, 'pitch-2');
    });
  });
}
