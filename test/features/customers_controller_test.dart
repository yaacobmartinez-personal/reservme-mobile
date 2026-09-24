import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/features/venue/customers/application/customers_controller.dart';
import 'package:reservme/features/venue/customers/domain/customer.dart';
import 'package:reservme/features/venue/customers/domain/customers_repository.dart';

import '../helpers/fakes.dart';

void main() {
  const slug = FakeVenues.katipunan;

  test('the list carries the total, not just the page', () async {
    final world = TestWorld();
    final container = world.container();

    final page = await container.read(customersProvider(slug).future);

    expect(page.rows, isNotEmpty);
    expect(page.total, page.rows.length);
  });

  test('search matches name, email and phone', () async {
    final world = TestWorld();
    final container = world.container();
    final all = await container.read(customersProvider(slug).future);
    final someone = all.rows.firstWhere((c) => (c.phone ?? '').isNotEmpty);

    final byName = await container.read(
      customersProvider(slug, search: someone.name).future,
    );
    expect(byName.rows.map((c) => c.id), contains(someone.id));

    final byPhone = await container.read(
      customersProvider(slug, search: someone.phone!).future,
    );
    expect(byPhone.rows.map((c) => c.id), contains(someone.id));

    final byEmail = await container.read(
      customersProvider(slug, search: someone.email).future,
    );
    expect(byEmail.rows.map((c) => c.id), contains(someone.id));
  });

  test('the no-shows segment only shows people with one', () async {
    final world = TestWorld();
    final container = world.container();

    final page = await container.read(
      customersProvider(slug, segment: CustomerSegment.noShows).future,
    );

    expect(page.rows, isNotEmpty);
    expect(page.rows.every((c) => c.noShowCount > 0), isTrue);
  });

  test('lifetime value counts confirmed bookings only', () async {
    final world = TestWorld();
    final container = world.container();
    final page = await container.read(customersProvider(slug).future);
    final someone = page.rows.firstWhere((c) => c.bookings > 0);

    final profile = await container.read(
      customerDetailProvider(slug, someone.id).future,
    );

    // Every cancelled or no-show booking is on the history but not the total.
    final confirmedTotal = [...profile.upcoming, ...profile.past]
        .where((b) => b.status.name == 'confirmed')
        .fold(0, (sum, b) => sum + b.amountCents);
    expect(profile.customer.lifetimeValueCents, confirmedTotal);
  });

  test('a note round-trips and can be taken back', () async {
    final world = TestWorld();
    final container = world.container();
    final page = await container.read(customersProvider(slug).future);
    final id = page.rows.first.id;
    final notifier = container.read(customerDetailProvider(slug, id).notifier);
    final sub = container.listen(customerDetailProvider(slug, id), (_, _) {});
    addTearDown(sub.close);
    await container.read(customerDetailProvider(slug, id).future);

    await notifier.addNote('  Brings his own shuttles.  ');
    var profile = await container.read(customerDetailProvider(slug, id).future);
    expect(profile.notes.first.body, 'Brings his own shuttles.');

    await notifier.deleteNote(profile.notes.first.id);
    profile = await container.read(customerDetailProvider(slug, id).future);
    expect(profile.notes.where((n) => n.body.contains('shuttles')), isEmpty);
  });

  test('an empty note is refused with the server wording', () async {
    final world = TestWorld();
    final container = world.container();
    final page = await container.read(customersProvider(slug).future);
    final id = page.rows.first.id;
    final sub = container.listen(customerDetailProvider(slug, id), (_, _) {});
    addTearDown(sub.close);
    await container.read(customerDetailProvider(slug, id).future);

    await expectLater(
      container.read(customerDetailProvider(slug, id).notifier).addNote('   '),
      throwsA(isA<ApiError>()
          .having((e) => e.message, 'message', 'Write something first.')),
    );
  });

  test('tags save, and the rules match the web schema', () async {
    final world = TestWorld();
    final container = world.container();
    final page = await container.read(customersProvider(slug).future);
    final id = page.rows.first.id;
    final sub = container.listen(customerDetailProvider(slug, id), (_, _) {});
    addTearDown(sub.close);
    await container.read(customerDetailProvider(slug, id).future);
    final notifier = container.read(customerDetailProvider(slug, id).notifier);

    await notifier.setTags(['Regular', 'Weekday league']);
    final profile = await container.read(customerDetailProvider(slug, id).future);
    expect(profile.customer.tags, ['Regular', 'Weekday league']);

    await expectLater(
      notifier.setTags(['no/slashes']),
      throwsA(isA<ApiError>()),
    );
  });

  test('contact edits take name and phone, never email', () async {
    final world = TestWorld();
    final container = world.container();
    final page = await container.read(customersProvider(slug).future);
    final someone = page.rows.first;
    final sub = container.listen(customerDetailProvider(slug, someone.id), (_, _) {});
    addTearDown(sub.close);
    await container.read(customerDetailProvider(slug, someone.id).future);

    await container
        .read(customerDetailProvider(slug, someone.id).notifier)
        .updateContact(name: 'Renamed Person', phone: '0917 000 0000');

    final profile =
        await container.read(customerDetailProvider(slug, someone.id).future);
    expect(profile.customer.name, 'Renamed Person');
    expect(profile.customer.phone, '0917 000 0000');
    // Email is the identity key and is not editable.
    expect(profile.customer.email, someone.email);
  });

  group('tag rules', () {
    test('reject empty, long, odd, duplicate and over-cap tags', () {
      expect(TagRules.validate('  ', const []), "Tag can't be empty.");
      expect(TagRules.validate('x' * 31, const []),
          'Keep tags under 30 characters.');
      expect(TagRules.validate('no/slash', const []),
          'Tags can use letters, numbers, spaces and - . &');
      expect(TagRules.validate('Regular', const ['regular']), isNotNull);
      expect(
        TagRules.validate('One more', List.generate(20, (i) => 'tag $i')),
        isNotNull,
      );
    });

    test('accept the punctuation the web allows', () {
      for (final tag in ['Regular', 'Weekday league', 'A-B', 'A.B', 'Tom & Jerry', 'Liga 7']) {
        expect(TagRules.validate(tag, const []), isNull, reason: tag);
      }
    });
  });
}
