import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_for_your_medicine/core/data/medicine_repository.dart';
import 'package:time_for_your_medicine/core/db/app_database.dart';
import 'package:time_for_your_medicine/core/error/app_exception.dart';
import 'package:time_for_your_medicine/core/util/medicine_registry_csv.dart';

const _header =
    '"ID";"Торгівельне найменування";'
    '"Міжнародне непатентоване найменування";"Форма випуску"';

void main() {
  test(
    'parser supports semicolons, escaped quotes, and multiline fields',
    () async {
      final csv =
          '$_header\r\n'
          '"1";"ЛІКИ; ФОРТЕ";"Generic";"tablets\n10 mg"\r\n'
          '"2";"ЛІКИ ""ПЛЮС""";"Other";"capsules"\r\n';

      final items = await parseMedicineRegistryCsv(
        Stream<List<int>>.value(utf8.encode(csv)),
      );

      expect(items, hasLength(2));
      expect(items.first.name, 'ЛІКИ; ФОРТЕ');
      expect(items.first.form, 'tablets\n10 mg');
      expect(items.last.name, 'ЛІКИ "ПЛЮС"');
    },
  );

  test(
    'CSV import replaces the SQLite registry and remains searchable',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final repository = MedicineRepository(db, Talker());
      final csv =
          '$_header\n'
          '"1";"Амоксицилін";"Amoxicillin";"капсули 500 мг"\n'
          '"2";"Ібупрофен";"Ibuprofen";"таблетки 200 мг"\n';

      final imported = await repository.replaceMedicineRegistryFromCsv(
        Stream<List<int>>.value(utf8.encode(csv)),
        'update.csv',
      );
      final status = imported.getOrElse((failure) => throw failure);
      expect(status.entryCount, 2);
      expect(status.sourceName, 'update.csv');

      final matches = (await repository.searchMedicineRegistry(
        'amoxicillin',
      )).getOrElse((failure) => throw failure);
      expect(matches.single.name, 'Амоксицилін');
    },
  );

  test('generated reestr seed imports into SQLite on first use', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final repository = MedicineRepository(db, Talker());

    final status = (await repository.ensureMedicineRegistry()).getOrElse(
      (failure) => throw failure,
    );
    expect(status.sourceName, 'reestr.csv');
    expect(status.entryCount, 14931);

    final matches = (await repository.searchMedicineRegistry(
      'амоксицилін',
    )).getOrElse((failure) => throw failure);
    expect(matches, isNotEmpty);
  });

  test('invalid CSV does not delete the existing registry', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final repository = MedicineRepository(db, Talker());
    final valid = '$_header\n"1";"Aspirin";"Aspirin";"tablet"\n';
    await repository.replaceMedicineRegistryFromCsv(
      Stream<List<int>>.value(utf8.encode(valid)),
      'valid.csv',
    );

    final invalid = await repository.replaceMedicineRegistryFromCsv(
      Stream<List<int>>.value(utf8.encode('wrong,headers\n1,2')),
      'invalid.csv',
    );
    expect(invalid.isLeft(), isTrue);
    expect(
      invalid.fold(
        (failure) => failure,
        (_) => const AppException.unknown(error: 'x'),
      ),
      isA<InvalidRegistryFile>(),
    );
    final matches = (await repository.searchMedicineRegistry(
      'aspirin',
    )).getOrElse((failure) => throw failure);
    expect(matches, hasLength(1));
  });
}
