import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;
import 'package:time_for_your_medicine/core/db/app_database.dart';

/// Regression test for a bug where every real device that had ever
/// upgraded through schema v5 was physically stuck with `dose_log`
/// keyed on just `(iso, med_id)`, because the v4 → v5 migration added
/// `doseTimeId` via `addColumn` — which cannot change a PRIMARY KEY.
/// `insertOnConflictUpdate` (used by `setDoseStatus`) targets the
/// *declared* `(iso, med_id, dose_time_id)` key, which SQLite rejects
/// when it doesn't match an actual constraint — so marking a dose
/// taken/rejected silently failed on every such device (caught by
/// `MedicineRepository._guard`, never surfaced), and reverted to
/// pending on the next app restart. This never showed up in the rest
/// of the suite because every other test opens a brand-new
/// `NativeDatabase.memory()`, which always builds tables from the
/// *current* Dart schema via `onCreate` — never through a real
/// migration chain.
void main() {
  test('upgrading a device stuck on the old dose_log key repairs it, and '
      'independent dose slots on the same day no longer collide', () async {
    final dir = await Directory.systemTemp.createTemp('pillpal_migration_test');
    final file = File('${dir.path}/pillpal.sqlite');
    addTearDown(() => dir.delete(recursive: true));

    // Build a fresh, correctly-created database first, purely to copy
    // exact CREATE TABLE DDL for every table this migration doesn't
    // touch — so the fixture below can't drift out of sync with the
    // real schema by hand-transcription error.
    final templateFile = File('${dir.path}/template.sqlite');
    final template = AppDatabase(NativeDatabase(templateFile));
    final ddl = <String, String>{};
    for (final row
        in await template
            .customSelect(
              "SELECT name, sql FROM sqlite_master WHERE type = 'table' "
              "AND name NOT IN ('dose_log', 'medicines', 'sqlite_sequence')",
            )
            .get()) {
      ddl[row.data['name'] as String] = row.data['sql'] as String;
    }
    await template.close();

    // Hand-build the exact broken schema a real migrated device ends
    // up with: every other table matches the current schema, but
    // `dose_log` still carries the old 2-column primary key — verified
    // directly against a live simulator's on-disk `pillpal.sqlite`
    // before this fix. `medicines` is also hand-written (rather than
    // copied from the template like the other untouched tables)
    // because it still had its `cap` column at schema v7 — the
    // template reflects *today's* schema, which dropped it in v9.
    final raw = sqlite3.sqlite3.open(file.path);
    for (final createTable in ddl.values) {
      raw.execute(createTable);
    }
    raw.execute('''
        CREATE TABLE medicines (
          id TEXT NOT NULL PRIMARY KEY,
          name TEXT NOT NULL,
          dose TEXT NOT NULL,
          with_food INTEGER NOT NULL,
          kind TEXT NOT NULL,
          c1 INTEGER NOT NULL,
          c2 INTEGER,
          soft INTEGER NOT NULL,
          cap INTEGER NOT NULL
        );
      ''');
    raw.execute('''
        CREATE TABLE dose_log (
          iso TEXT NOT NULL,
          med_id TEXT NOT NULL,
          dose_time_id TEXT NOT NULL DEFAULT '',
          status TEXT NOT NULL DEFAULT 'pending',
          PRIMARY KEY (iso, med_id)
        );
      ''');
    raw.execute(
      "INSERT INTO medicines (id, name, dose, with_food, kind, c1, soft, cap) "
      "VALUES ('m1', 'Test', '1 dose', 1, 'round', 0, 0, 30);",
    );
    raw.execute('PRAGMA user_version = 7;');
    raw.dispose();

    final db = AppDatabase(NativeDatabase(file));
    addTearDown(db.close);

    // Any query is enough to make drift open the connection and run
    // the pending migration from v7 to the current schema version.
    await db.select(db.medicines).get();

    final rebuilt = await db
        .customSelect(
          "SELECT sql FROM sqlite_master WHERE type = 'table' "
          "AND name = 'dose_log'",
        )
        .getSingle();
    expect(
      rebuilt.data['sql'],
      allOf(contains('iso'), contains('med_id'), contains('dose_time_id')),
    );

    // The actual regression: two independent dose slots for the same
    // medicine on the same day must both survive `insertOnConflictUpdate`
    // without throwing or overwriting each other.
    await db
        .into(db.doseLog)
        .insertOnConflictUpdate(
          const DoseLogCompanion(
            iso: Value('2026-07-02'),
            medId: Value('m1'),
            doseTimeId: Value('t1'),
            status: Value('taken'),
          ),
        );
    await db
        .into(db.doseLog)
        .insertOnConflictUpdate(
          const DoseLogCompanion(
            iso: Value('2026-07-02'),
            medId: Value('m1'),
            doseTimeId: Value('t2'),
            status: Value('rejected'),
          ),
        );

    final rows = await db.select(db.doseLog).get();
    expect(rows, hasLength(2));
    expect(rows.map((r) => r.status), containsAll(['taken', 'rejected']));
  });
}
