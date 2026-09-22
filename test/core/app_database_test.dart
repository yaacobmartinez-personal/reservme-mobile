import 'package:drift/drift.dart' show Migrator;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/storage/db/app_database.dart';
import 'package:reservme/core/storage/local_store.dart';

void main() {
  late AppDatabase db;
  late DriftLocalStore store;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    store = DriftLocalStore(db);
  });
  tearDown(() => db.close());

  final now = DateTime.utc(2026, 9, 26, 2);

  test('a fresh database has every table the app writes to', () async {
    await store.saveVenueCache('katipunan', 'today', {'date': '2026-09-26'}, now: now);

    final cached = await store.readVenueCache('katipunan', 'today');
    expect(cached!.payload['date'], '2026-09-26');
    expect(cached.fetchedAt, now);
  });

  test('upgrading from the wallet-only schema creates the read cache', () async {
    // What a phone that last ran Phase 1 has: no venue_cache table.
    await db.customStatement('DROP TABLE venue_cache');
    await expectLater(
      store.saveVenueCache('katipunan', 'today', const {}, now: now),
      throwsA(anything),
    );

    await db.migration.onUpgrade(Migrator(db), 1, 2);

    await store.saveVenueCache('katipunan', 'today', {'date': '2026-09-26'}, now: now);
    expect((await store.readVenueCache('katipunan', 'today'))!.payload['date'], '2026-09-26');
  });

  test('the cache can be cleared for one venue or all of them', () async {
    await store.saveVenueCache('katipunan', 'today', const {'a': 1}, now: now);
    await store.saveVenueCache('studio-norte', 'today', const {'a': 2}, now: now);

    await store.clearVenueCache('katipunan');
    expect(await store.readVenueCache('katipunan', 'today'), isNull);
    expect(await store.readVenueCache('studio-norte', 'today'), isNotNull);

    await store.clearVenueCache();
    expect(await store.readVenueCache('studio-norte', 'today'), isNull);
  });
}
