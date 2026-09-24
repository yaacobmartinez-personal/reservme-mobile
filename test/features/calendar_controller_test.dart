import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/connectivity/connectivity_provider.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/core/time/app_time.dart';
import 'package:reservme/features/venue/calendar/application/calendar_commands.dart';
import 'package:reservme/features/venue/calendar/application/calendar_controller.dart';
import 'package:reservme/features/venue/calendar/domain/manual_booking_input.dart';

import '../helpers/fakes.dart';

void main() {
  const slug = FakeVenues.katipunan;
  const zone = 'Asia/Manila';

  String today() => AppTime.today(testNow, zone);

  Future<void> goOffline(ProviderContainer container, TestWorld world) async {
    final sub = container.listen(isOnlineProvider, (_, _) {});
    addTearDown(sub.close);
    world.setOnline(false);
    while (container.read(isOnlineProvider)) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  test('the day has a lane per space, and the seeded block is a block', () async {
    final world = TestWorld();
    final container = world.container();

    final state = await container.read(calendarProvider(slug, today()).future);

    expect(state.stale, isFalse);
    expect(state.day.lanes, isNotEmpty);
    expect(state.day.rows, isNotEmpty);

    final blocks = [
      for (final lane in state.day.lanes)
        for (final item in lane.items)
          if (item.isBlock) item,
    ];
    // Court 3, 18:00-20:00, net repair - a closure, not a booking.
    expect(blocks, hasLength(1));
    expect(blocks.single.subtitle, 'Net repair');
    expect(blocks.single.title, 'Blocked');
  });

  test('a staff booking lands on the grid', () async {
    final world = TestWorld();
    final container = world.container();
    final date = today();
    final before = await container.read(calendarProvider(slug, date).future);
    final lane = before.day.lanes.first;

    final booking =
        await container.read(calendarCommandsProvider.notifier).createBooking(
              slug,
              ManualBookingInput(
                spaceId: lane.spaceId,
                date: date,
                time: '09:00',
                name: 'Walk In',
                email: 'walk@example.com',
              ),
            );

    expect(booking.spaceName, lane.spaceName);
    final after = await container.read(calendarProvider(slug, date).future);
    final placed = after.day.lanes
        .firstWhere((l) => l.spaceId == lane.spaceId)
        .items
        .where((i) => i.id == booking.id);
    expect(placed, hasLength(1));
  });

  test('staff skip notice and horizon but never the physical rules', () async {
    final world = TestWorld();
    final container = world.container();
    final date = today();
    final day = await container.read(calendarProvider(slug, date).future);
    final lane = day.day.lanes.first;
    final taken = lane.items.firstWhere((i) => i.isBooking);
    final commands = container.read(calendarCommandsProvider.notifier);

    // 08:00 is already past (the clock says 10:00), so the public path would
    // refuse it as too soon. Staff are not bound by the notice window.
    await commands.createBooking(
      slug,
      ManualBookingInput(
        spaceId: lane.spaceId,
        date: date,
        time: '08:00',
        customerId: taken.customerId,
      ),
    );

    // But a slot that is already sold stays sold.
    await expectLater(
      commands.createBooking(
        slug,
        ManualBookingInput(
          spaceId: lane.spaceId,
          date: date,
          time: AppTime.formatTime(taken.startsAt, zone),
          customerId: taken.customerId,
        ),
      ),
      throwsA(isA<ApiError>().having((e) => e.reason, 'reason', 'slot_taken')),
    );
  });

  test('a booking cannot be placed on top of a block', () async {
    final world = TestWorld();
    final container = world.container();
    final date = today();
    final day = await container.read(calendarProvider(slug, date).future);
    final blocked =
        day.day.lanes.firstWhere((l) => l.items.any((i) => i.isBlock));
    final block = blocked.items.firstWhere((i) => i.isBlock);

    await expectLater(
      container.read(calendarCommandsProvider.notifier).createBooking(
            slug,
            ManualBookingInput(
              spaceId: blocked.spaceId,
              date: date,
              time: AppTime.formatTime(block.startsAt, zone),
              name: 'Nope',
              email: 'nope@example.com',
            ),
          ),
      throwsA(isA<ApiError>()
          .having((e) => e.message, 'message', 'The venue is closed then.')),
    );
  });

  test('moving keeps the length and frees the old slot', () async {
    final world = TestWorld();
    final container = world.container();
    final date = today();
    final day = await container.read(calendarProvider(slug, date).future);
    final lane = day.day.lanes.first;
    final booking = lane.items.firstWhere((i) => i.isBooking);
    final minutes = booking.durationMinutes;
    final wasAt = AppTime.formatTime(booking.startsAt, zone);

    final moved = await container.read(calendarCommandsProvider.notifier).move(
          slug,
          booking.id,
          spaceId: lane.spaceId,
          fromDate: date,
          date: date,
          time: '08:00',
        );

    expect(moved.endsAt.difference(moved.startsAt).inMinutes, minutes);
    expect(AppTime.formatTime(moved.startsAt, zone), '08:00');

    final after = await container.read(calendarProvider(slug, date).future);
    final items =
        after.day.lanes.firstWhere((l) => l.spaceId == lane.spaceId).items;
    expect(items.where((i) => i.id == booking.id), hasLength(1));
    expect(
      items.where((i) => AppTime.formatTime(i.startsAt, zone) == wasAt),
      isEmpty,
    );
  });

  test('a move onto a taken slot is refused, not forced', () async {
    final world = TestWorld();
    final container = world.container();
    final date = today();
    final day = await container.read(calendarProvider(slug, date).future);
    final lane = day.day.lanes
        .firstWhere((l) => l.items.where((i) => i.isBooking).length > 1);
    final bookings = lane.items.where((i) => i.isBooking).toList();

    await expectLater(
      container.read(calendarCommandsProvider.notifier).move(
            slug,
            bookings.first.id,
            spaceId: lane.spaceId,
            fromDate: date,
            date: date,
            time: AppTime.formatTime(bookings[1].startsAt, zone),
          ),
      throwsA(isA<ApiError>().having((e) => e.reason, 'reason', 'slot_taken')),
    );
  });

  test('a block stops the next booking; lifting it lets one through', () async {
    final world = TestWorld();
    final container = world.container();
    final date = today();
    final commands = container.read(calendarCommandsProvider.notifier);
    final day = await container.read(calendarProvider(slug, date).future);
    final lane = day.day.lanes.first;

    final block = await commands.block(
      slug,
      BlockInput(spaceId: lane.spaceId, date: date, from: '08:00', to: '09:00'),
    );

    await expectLater(
      commands.createBooking(
        slug,
        ManualBookingInput(
          spaceId: lane.spaceId,
          date: date,
          time: '08:00',
          name: 'Nope',
          email: 'nope@example.com',
        ),
      ),
      throwsA(isA<ApiError>()),
    );

    await commands.removeBlock(slug, block.id, date);
    final booking = await commands.createBooking(
      slug,
      ManualBookingInput(
        spaceId: lane.spaceId,
        date: date,
        time: '08:00',
        name: 'Now Fine',
        email: 'fine@example.com',
      ),
    );
    expect(booking.id, isNotEmpty);
  });

  test('customer search matches a name and caps at six', () async {
    final world = TestWorld();
    final container = world.container();

    final byName = await container.read(customerSearchProvider(slug, 'Reyes').future);
    expect(byName, isNotEmpty);
    expect(byName.first.name, contains('Reyes'));

    final nothing = await container.read(customerSearchProvider(slug, 'zzzz').future);
    expect(nothing, isEmpty);

    final broad = await container.read(customerSearchProvider(slug, 'a').future);
    expect(broad.length, lessThanOrEqualTo(6));
  });

  test('offline falls back to the saved day, and only that day', () async {
    final world = TestWorld();
    final container = world.container();
    final date = today();
    final fresh = await container.read(calendarProvider(slug, date).future);

    await goOffline(container, world);
    container.invalidate(calendarProvider(slug, date));
    final cached = await container.read(calendarProvider(slug, date).future);

    expect(cached.stale, isTrue);
    expect(cached.fetchedAt, testNow);
    expect(cached.day.lanes.length, fresh.day.lanes.length);

    // A day that was never fetched has nothing to fall back to.
    final other = AppTime.addDays(date, 3, zone);
    final sub = container.listen(calendarProvider(slug, other), (_, _) {});
    addTearDown(sub.close);
    await expectLater(
      container.read(calendarProvider(slug, other).future),
      throwsA(isA<ApiError>()),
    );
  });
}
