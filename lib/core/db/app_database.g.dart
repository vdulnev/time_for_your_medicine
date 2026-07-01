// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MedicinesTable extends Medicines
    with TableInfo<$MedicinesTable, MedicineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doseMeta = const VerificationMeta('dose');
  @override
  late final GeneratedColumn<String> dose = GeneratedColumn<String>(
    'dose',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
    'period',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _withFoodMeta = const VerificationMeta(
    'withFood',
  );
  @override
  late final GeneratedColumn<bool> withFood = GeneratedColumn<bool>(
    'with_food',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("with_food" IN (0, 1))',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _c1Meta = const VerificationMeta('c1');
  @override
  late final GeneratedColumn<int> c1 = GeneratedColumn<int>(
    'c1',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _c2Meta = const VerificationMeta('c2');
  @override
  late final GeneratedColumn<int> c2 = GeneratedColumn<int>(
    'c2',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _softMeta = const VerificationMeta('soft');
  @override
  late final GeneratedColumn<int> soft = GeneratedColumn<int>(
    'soft',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplyMeta = const VerificationMeta('supply');
  @override
  late final GeneratedColumn<int> supply = GeneratedColumn<int>(
    'supply',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _capMeta = const VerificationMeta('cap');
  @override
  late final GeneratedColumn<int> cap = GeneratedColumn<int>(
    'cap',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    dose,
    time,
    period,
    withFood,
    kind,
    c1,
    c2,
    soft,
    supply,
    cap,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicines';
  @override
  VerificationContext validateIntegrity(
    Insertable<MedicineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('dose')) {
      context.handle(
        _doseMeta,
        dose.isAcceptableOrUnknown(data['dose']!, _doseMeta),
      );
    } else if (isInserting) {
      context.missing(_doseMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('with_food')) {
      context.handle(
        _withFoodMeta,
        withFood.isAcceptableOrUnknown(data['with_food']!, _withFoodMeta),
      );
    } else if (isInserting) {
      context.missing(_withFoodMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('c1')) {
      context.handle(_c1Meta, c1.isAcceptableOrUnknown(data['c1']!, _c1Meta));
    } else if (isInserting) {
      context.missing(_c1Meta);
    }
    if (data.containsKey('c2')) {
      context.handle(_c2Meta, c2.isAcceptableOrUnknown(data['c2']!, _c2Meta));
    }
    if (data.containsKey('soft')) {
      context.handle(
        _softMeta,
        soft.isAcceptableOrUnknown(data['soft']!, _softMeta),
      );
    } else if (isInserting) {
      context.missing(_softMeta);
    }
    if (data.containsKey('supply')) {
      context.handle(
        _supplyMeta,
        supply.isAcceptableOrUnknown(data['supply']!, _supplyMeta),
      );
    } else if (isInserting) {
      context.missing(_supplyMeta);
    }
    if (data.containsKey('cap')) {
      context.handle(
        _capMeta,
        cap.isAcceptableOrUnknown(data['cap']!, _capMeta),
      );
    } else if (isInserting) {
      context.missing(_capMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicineRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dose'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time'],
      )!,
      period: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period'],
      )!,
      withFood: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}with_food'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      c1: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}c1'],
      )!,
      c2: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}c2'],
      ),
      soft: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}soft'],
      )!,
      supply: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supply'],
      )!,
      cap: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cap'],
      )!,
    );
  }

  @override
  $MedicinesTable createAlias(String alias) {
    return $MedicinesTable(attachedDatabase, alias);
  }
}

class MedicineRow extends DataClass implements Insertable<MedicineRow> {
  final String id;
  final String name;
  final String dose;
  final String time;
  final String period;
  final bool withFood;
  final String kind;
  final int c1;
  final int? c2;
  final int soft;
  final int supply;
  final int cap;
  const MedicineRow({
    required this.id,
    required this.name,
    required this.dose,
    required this.time,
    required this.period,
    required this.withFood,
    required this.kind,
    required this.c1,
    this.c2,
    required this.soft,
    required this.supply,
    required this.cap,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['dose'] = Variable<String>(dose);
    map['time'] = Variable<String>(time);
    map['period'] = Variable<String>(period);
    map['with_food'] = Variable<bool>(withFood);
    map['kind'] = Variable<String>(kind);
    map['c1'] = Variable<int>(c1);
    if (!nullToAbsent || c2 != null) {
      map['c2'] = Variable<int>(c2);
    }
    map['soft'] = Variable<int>(soft);
    map['supply'] = Variable<int>(supply);
    map['cap'] = Variable<int>(cap);
    return map;
  }

  MedicinesCompanion toCompanion(bool nullToAbsent) {
    return MedicinesCompanion(
      id: Value(id),
      name: Value(name),
      dose: Value(dose),
      time: Value(time),
      period: Value(period),
      withFood: Value(withFood),
      kind: Value(kind),
      c1: Value(c1),
      c2: c2 == null && nullToAbsent ? const Value.absent() : Value(c2),
      soft: Value(soft),
      supply: Value(supply),
      cap: Value(cap),
    );
  }

  factory MedicineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicineRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dose: serializer.fromJson<String>(json['dose']),
      time: serializer.fromJson<String>(json['time']),
      period: serializer.fromJson<String>(json['period']),
      withFood: serializer.fromJson<bool>(json['withFood']),
      kind: serializer.fromJson<String>(json['kind']),
      c1: serializer.fromJson<int>(json['c1']),
      c2: serializer.fromJson<int?>(json['c2']),
      soft: serializer.fromJson<int>(json['soft']),
      supply: serializer.fromJson<int>(json['supply']),
      cap: serializer.fromJson<int>(json['cap']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'dose': serializer.toJson<String>(dose),
      'time': serializer.toJson<String>(time),
      'period': serializer.toJson<String>(period),
      'withFood': serializer.toJson<bool>(withFood),
      'kind': serializer.toJson<String>(kind),
      'c1': serializer.toJson<int>(c1),
      'c2': serializer.toJson<int?>(c2),
      'soft': serializer.toJson<int>(soft),
      'supply': serializer.toJson<int>(supply),
      'cap': serializer.toJson<int>(cap),
    };
  }

  MedicineRow copyWith({
    String? id,
    String? name,
    String? dose,
    String? time,
    String? period,
    bool? withFood,
    String? kind,
    int? c1,
    Value<int?> c2 = const Value.absent(),
    int? soft,
    int? supply,
    int? cap,
  }) => MedicineRow(
    id: id ?? this.id,
    name: name ?? this.name,
    dose: dose ?? this.dose,
    time: time ?? this.time,
    period: period ?? this.period,
    withFood: withFood ?? this.withFood,
    kind: kind ?? this.kind,
    c1: c1 ?? this.c1,
    c2: c2.present ? c2.value : this.c2,
    soft: soft ?? this.soft,
    supply: supply ?? this.supply,
    cap: cap ?? this.cap,
  );
  MedicineRow copyWithCompanion(MedicinesCompanion data) {
    return MedicineRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      dose: data.dose.present ? data.dose.value : this.dose,
      time: data.time.present ? data.time.value : this.time,
      period: data.period.present ? data.period.value : this.period,
      withFood: data.withFood.present ? data.withFood.value : this.withFood,
      kind: data.kind.present ? data.kind.value : this.kind,
      c1: data.c1.present ? data.c1.value : this.c1,
      c2: data.c2.present ? data.c2.value : this.c2,
      soft: data.soft.present ? data.soft.value : this.soft,
      supply: data.supply.present ? data.supply.value : this.supply,
      cap: data.cap.present ? data.cap.value : this.cap,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicineRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dose: $dose, ')
          ..write('time: $time, ')
          ..write('period: $period, ')
          ..write('withFood: $withFood, ')
          ..write('kind: $kind, ')
          ..write('c1: $c1, ')
          ..write('c2: $c2, ')
          ..write('soft: $soft, ')
          ..write('supply: $supply, ')
          ..write('cap: $cap')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    dose,
    time,
    period,
    withFood,
    kind,
    c1,
    c2,
    soft,
    supply,
    cap,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicineRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.dose == this.dose &&
          other.time == this.time &&
          other.period == this.period &&
          other.withFood == this.withFood &&
          other.kind == this.kind &&
          other.c1 == this.c1 &&
          other.c2 == this.c2 &&
          other.soft == this.soft &&
          other.supply == this.supply &&
          other.cap == this.cap);
}

class MedicinesCompanion extends UpdateCompanion<MedicineRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> dose;
  final Value<String> time;
  final Value<String> period;
  final Value<bool> withFood;
  final Value<String> kind;
  final Value<int> c1;
  final Value<int?> c2;
  final Value<int> soft;
  final Value<int> supply;
  final Value<int> cap;
  final Value<int> rowid;
  const MedicinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dose = const Value.absent(),
    this.time = const Value.absent(),
    this.period = const Value.absent(),
    this.withFood = const Value.absent(),
    this.kind = const Value.absent(),
    this.c1 = const Value.absent(),
    this.c2 = const Value.absent(),
    this.soft = const Value.absent(),
    this.supply = const Value.absent(),
    this.cap = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicinesCompanion.insert({
    required String id,
    required String name,
    required String dose,
    required String time,
    required String period,
    required bool withFood,
    required String kind,
    required int c1,
    this.c2 = const Value.absent(),
    required int soft,
    required int supply,
    required int cap,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       dose = Value(dose),
       time = Value(time),
       period = Value(period),
       withFood = Value(withFood),
       kind = Value(kind),
       c1 = Value(c1),
       soft = Value(soft),
       supply = Value(supply),
       cap = Value(cap);
  static Insertable<MedicineRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? dose,
    Expression<String>? time,
    Expression<String>? period,
    Expression<bool>? withFood,
    Expression<String>? kind,
    Expression<int>? c1,
    Expression<int>? c2,
    Expression<int>? soft,
    Expression<int>? supply,
    Expression<int>? cap,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (dose != null) 'dose': dose,
      if (time != null) 'time': time,
      if (period != null) 'period': period,
      if (withFood != null) 'with_food': withFood,
      if (kind != null) 'kind': kind,
      if (c1 != null) 'c1': c1,
      if (c2 != null) 'c2': c2,
      if (soft != null) 'soft': soft,
      if (supply != null) 'supply': supply,
      if (cap != null) 'cap': cap,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicinesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? dose,
    Value<String>? time,
    Value<String>? period,
    Value<bool>? withFood,
    Value<String>? kind,
    Value<int>? c1,
    Value<int?>? c2,
    Value<int>? soft,
    Value<int>? supply,
    Value<int>? cap,
    Value<int>? rowid,
  }) {
    return MedicinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dose: dose ?? this.dose,
      time: time ?? this.time,
      period: period ?? this.period,
      withFood: withFood ?? this.withFood,
      kind: kind ?? this.kind,
      c1: c1 ?? this.c1,
      c2: c2 ?? this.c2,
      soft: soft ?? this.soft,
      supply: supply ?? this.supply,
      cap: cap ?? this.cap,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dose.present) {
      map['dose'] = Variable<String>(dose.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (withFood.present) {
      map['with_food'] = Variable<bool>(withFood.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (c1.present) {
      map['c1'] = Variable<int>(c1.value);
    }
    if (c2.present) {
      map['c2'] = Variable<int>(c2.value);
    }
    if (soft.present) {
      map['soft'] = Variable<int>(soft.value);
    }
    if (supply.present) {
      map['supply'] = Variable<int>(supply.value);
    }
    if (cap.present) {
      map['cap'] = Variable<int>(cap.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dose: $dose, ')
          ..write('time: $time, ')
          ..write('period: $period, ')
          ..write('withFood: $withFood, ')
          ..write('kind: $kind, ')
          ..write('c1: $c1, ')
          ..write('c2: $c2, ')
          ..write('soft: $soft, ')
          ..write('supply: $supply, ')
          ..write('cap: $cap, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DoseLogTable extends DoseLog with TableInfo<$DoseLogTable, DoseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoseLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _isoMeta = const VerificationMeta('iso');
  @override
  late final GeneratedColumn<String> iso = GeneratedColumn<String>(
    'iso',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _medIdMeta = const VerificationMeta('medId');
  @override
  late final GeneratedColumn<String> medId = GeneratedColumn<String>(
    'med_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _takenMeta = const VerificationMeta('taken');
  @override
  late final GeneratedColumn<bool> taken = GeneratedColumn<bool>(
    'taken',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("taken" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [iso, medId, taken];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dose_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<DoseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('iso')) {
      context.handle(
        _isoMeta,
        iso.isAcceptableOrUnknown(data['iso']!, _isoMeta),
      );
    } else if (isInserting) {
      context.missing(_isoMeta);
    }
    if (data.containsKey('med_id')) {
      context.handle(
        _medIdMeta,
        medId.isAcceptableOrUnknown(data['med_id']!, _medIdMeta),
      );
    } else if (isInserting) {
      context.missing(_medIdMeta);
    }
    if (data.containsKey('taken')) {
      context.handle(
        _takenMeta,
        taken.isAcceptableOrUnknown(data['taken']!, _takenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {iso, medId};
  @override
  DoseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoseRow(
      iso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}iso'],
      )!,
      medId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}med_id'],
      )!,
      taken: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}taken'],
      )!,
    );
  }

  @override
  $DoseLogTable createAlias(String alias) {
    return $DoseLogTable(attachedDatabase, alias);
  }
}

class DoseRow extends DataClass implements Insertable<DoseRow> {
  final String iso;
  final String medId;
  final bool taken;
  const DoseRow({required this.iso, required this.medId, required this.taken});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['iso'] = Variable<String>(iso);
    map['med_id'] = Variable<String>(medId);
    map['taken'] = Variable<bool>(taken);
    return map;
  }

  DoseLogCompanion toCompanion(bool nullToAbsent) {
    return DoseLogCompanion(
      iso: Value(iso),
      medId: Value(medId),
      taken: Value(taken),
    );
  }

  factory DoseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoseRow(
      iso: serializer.fromJson<String>(json['iso']),
      medId: serializer.fromJson<String>(json['medId']),
      taken: serializer.fromJson<bool>(json['taken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'iso': serializer.toJson<String>(iso),
      'medId': serializer.toJson<String>(medId),
      'taken': serializer.toJson<bool>(taken),
    };
  }

  DoseRow copyWith({String? iso, String? medId, bool? taken}) => DoseRow(
    iso: iso ?? this.iso,
    medId: medId ?? this.medId,
    taken: taken ?? this.taken,
  );
  DoseRow copyWithCompanion(DoseLogCompanion data) {
    return DoseRow(
      iso: data.iso.present ? data.iso.value : this.iso,
      medId: data.medId.present ? data.medId.value : this.medId,
      taken: data.taken.present ? data.taken.value : this.taken,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoseRow(')
          ..write('iso: $iso, ')
          ..write('medId: $medId, ')
          ..write('taken: $taken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(iso, medId, taken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoseRow &&
          other.iso == this.iso &&
          other.medId == this.medId &&
          other.taken == this.taken);
}

class DoseLogCompanion extends UpdateCompanion<DoseRow> {
  final Value<String> iso;
  final Value<String> medId;
  final Value<bool> taken;
  final Value<int> rowid;
  const DoseLogCompanion({
    this.iso = const Value.absent(),
    this.medId = const Value.absent(),
    this.taken = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DoseLogCompanion.insert({
    required String iso,
    required String medId,
    this.taken = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : iso = Value(iso),
       medId = Value(medId);
  static Insertable<DoseRow> custom({
    Expression<String>? iso,
    Expression<String>? medId,
    Expression<bool>? taken,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (iso != null) 'iso': iso,
      if (medId != null) 'med_id': medId,
      if (taken != null) 'taken': taken,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DoseLogCompanion copyWith({
    Value<String>? iso,
    Value<String>? medId,
    Value<bool>? taken,
    Value<int>? rowid,
  }) {
    return DoseLogCompanion(
      iso: iso ?? this.iso,
      medId: medId ?? this.medId,
      taken: taken ?? this.taken,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (iso.present) {
      map['iso'] = Variable<String>(iso.value);
    }
    if (medId.present) {
      map['med_id'] = Variable<String>(medId.value);
    }
    if (taken.present) {
      map['taken'] = Variable<bool>(taken.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoseLogCompanion(')
          ..write('iso: $iso, ')
          ..write('medId: $medId, ')
          ..write('taken: $taken, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsRowsTable extends SettingsRows
    with TableInfo<$SettingsRowsTable, SettingsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _soundMeta = const VerificationMeta('sound');
  @override
  late final GeneratedColumn<bool> sound = GeneratedColumn<bool>(
    'sound',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _vibrateMeta = const VerificationMeta(
    'vibrate',
  );
  @override
  late final GeneratedColumn<bool> vibrate = GeneratedColumn<bool>(
    'vibrate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("vibrate" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _refillMeta = const VerificationMeta('refill');
  @override
  late final GeneratedColumn<bool> refill = GeneratedColumn<bool>(
    'refill',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("refill" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _localeOverrideMeta = const VerificationMeta(
    'localeOverride',
  );
  @override
  late final GeneratedColumn<String> localeOverride = GeneratedColumn<String>(
    'locale_override',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sound,
    vibrate,
    refill,
    localeOverride,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sound')) {
      context.handle(
        _soundMeta,
        sound.isAcceptableOrUnknown(data['sound']!, _soundMeta),
      );
    }
    if (data.containsKey('vibrate')) {
      context.handle(
        _vibrateMeta,
        vibrate.isAcceptableOrUnknown(data['vibrate']!, _vibrateMeta),
      );
    }
    if (data.containsKey('refill')) {
      context.handle(
        _refillMeta,
        refill.isAcceptableOrUnknown(data['refill']!, _refillMeta),
      );
    }
    if (data.containsKey('locale_override')) {
      context.handle(
        _localeOverrideMeta,
        localeOverride.isAcceptableOrUnknown(
          data['locale_override']!,
          _localeOverrideMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sound: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound'],
      )!,
      vibrate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}vibrate'],
      )!,
      refill: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}refill'],
      )!,
      localeOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale_override'],
      ),
    );
  }

  @override
  $SettingsRowsTable createAlias(String alias) {
    return $SettingsRowsTable(attachedDatabase, alias);
  }
}

class SettingsData extends DataClass implements Insertable<SettingsData> {
  final int id;
  final bool sound;
  final bool vibrate;
  final bool refill;

  /// User-chosen language override ("en" / "uk"), or null to follow the
  /// device locale (see `resolveLocale`).
  final String? localeOverride;
  const SettingsData({
    required this.id,
    required this.sound,
    required this.vibrate,
    required this.refill,
    this.localeOverride,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sound'] = Variable<bool>(sound);
    map['vibrate'] = Variable<bool>(vibrate);
    map['refill'] = Variable<bool>(refill);
    if (!nullToAbsent || localeOverride != null) {
      map['locale_override'] = Variable<String>(localeOverride);
    }
    return map;
  }

  SettingsRowsCompanion toCompanion(bool nullToAbsent) {
    return SettingsRowsCompanion(
      id: Value(id),
      sound: Value(sound),
      vibrate: Value(vibrate),
      refill: Value(refill),
      localeOverride: localeOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(localeOverride),
    );
  }

  factory SettingsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsData(
      id: serializer.fromJson<int>(json['id']),
      sound: serializer.fromJson<bool>(json['sound']),
      vibrate: serializer.fromJson<bool>(json['vibrate']),
      refill: serializer.fromJson<bool>(json['refill']),
      localeOverride: serializer.fromJson<String?>(json['localeOverride']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sound': serializer.toJson<bool>(sound),
      'vibrate': serializer.toJson<bool>(vibrate),
      'refill': serializer.toJson<bool>(refill),
      'localeOverride': serializer.toJson<String?>(localeOverride),
    };
  }

  SettingsData copyWith({
    int? id,
    bool? sound,
    bool? vibrate,
    bool? refill,
    Value<String?> localeOverride = const Value.absent(),
  }) => SettingsData(
    id: id ?? this.id,
    sound: sound ?? this.sound,
    vibrate: vibrate ?? this.vibrate,
    refill: refill ?? this.refill,
    localeOverride: localeOverride.present
        ? localeOverride.value
        : this.localeOverride,
  );
  SettingsData copyWithCompanion(SettingsRowsCompanion data) {
    return SettingsData(
      id: data.id.present ? data.id.value : this.id,
      sound: data.sound.present ? data.sound.value : this.sound,
      vibrate: data.vibrate.present ? data.vibrate.value : this.vibrate,
      refill: data.refill.present ? data.refill.value : this.refill,
      localeOverride: data.localeOverride.present
          ? data.localeOverride.value
          : this.localeOverride,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsData(')
          ..write('id: $id, ')
          ..write('sound: $sound, ')
          ..write('vibrate: $vibrate, ')
          ..write('refill: $refill, ')
          ..write('localeOverride: $localeOverride')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sound, vibrate, refill, localeOverride);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsData &&
          other.id == this.id &&
          other.sound == this.sound &&
          other.vibrate == this.vibrate &&
          other.refill == this.refill &&
          other.localeOverride == this.localeOverride);
}

class SettingsRowsCompanion extends UpdateCompanion<SettingsData> {
  final Value<int> id;
  final Value<bool> sound;
  final Value<bool> vibrate;
  final Value<bool> refill;
  final Value<String?> localeOverride;
  const SettingsRowsCompanion({
    this.id = const Value.absent(),
    this.sound = const Value.absent(),
    this.vibrate = const Value.absent(),
    this.refill = const Value.absent(),
    this.localeOverride = const Value.absent(),
  });
  SettingsRowsCompanion.insert({
    this.id = const Value.absent(),
    this.sound = const Value.absent(),
    this.vibrate = const Value.absent(),
    this.refill = const Value.absent(),
    this.localeOverride = const Value.absent(),
  });
  static Insertable<SettingsData> custom({
    Expression<int>? id,
    Expression<bool>? sound,
    Expression<bool>? vibrate,
    Expression<bool>? refill,
    Expression<String>? localeOverride,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sound != null) 'sound': sound,
      if (vibrate != null) 'vibrate': vibrate,
      if (refill != null) 'refill': refill,
      if (localeOverride != null) 'locale_override': localeOverride,
    });
  }

  SettingsRowsCompanion copyWith({
    Value<int>? id,
    Value<bool>? sound,
    Value<bool>? vibrate,
    Value<bool>? refill,
    Value<String?>? localeOverride,
  }) {
    return SettingsRowsCompanion(
      id: id ?? this.id,
      sound: sound ?? this.sound,
      vibrate: vibrate ?? this.vibrate,
      refill: refill ?? this.refill,
      localeOverride: localeOverride ?? this.localeOverride,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sound.present) {
      map['sound'] = Variable<bool>(sound.value);
    }
    if (vibrate.present) {
      map['vibrate'] = Variable<bool>(vibrate.value);
    }
    if (refill.present) {
      map['refill'] = Variable<bool>(refill.value);
    }
    if (localeOverride.present) {
      map['locale_override'] = Variable<String>(localeOverride.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRowsCompanion(')
          ..write('id: $id, ')
          ..write('sound: $sound, ')
          ..write('vibrate: $vibrate, ')
          ..write('refill: $refill, ')
          ..write('localeOverride: $localeOverride')
          ..write(')'))
        .toString();
  }
}

class $NotifOffRowsTable extends NotifOffRows
    with TableInfo<$NotifOffRowsTable, NotifOffRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotifOffRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _medIdMeta = const VerificationMeta('medId');
  @override
  late final GeneratedColumn<String> medId = GeneratedColumn<String>(
    'med_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [medId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notif_off_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotifOffRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('med_id')) {
      context.handle(
        _medIdMeta,
        medId.isAcceptableOrUnknown(data['med_id']!, _medIdMeta),
      );
    } else if (isInserting) {
      context.missing(_medIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {medId};
  @override
  NotifOffRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotifOffRow(
      medId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}med_id'],
      )!,
    );
  }

  @override
  $NotifOffRowsTable createAlias(String alias) {
    return $NotifOffRowsTable(attachedDatabase, alias);
  }
}

class NotifOffRow extends DataClass implements Insertable<NotifOffRow> {
  final String medId;
  const NotifOffRow({required this.medId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['med_id'] = Variable<String>(medId);
    return map;
  }

  NotifOffRowsCompanion toCompanion(bool nullToAbsent) {
    return NotifOffRowsCompanion(medId: Value(medId));
  }

  factory NotifOffRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotifOffRow(medId: serializer.fromJson<String>(json['medId']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'medId': serializer.toJson<String>(medId)};
  }

  NotifOffRow copyWith({String? medId}) =>
      NotifOffRow(medId: medId ?? this.medId);
  NotifOffRow copyWithCompanion(NotifOffRowsCompanion data) {
    return NotifOffRow(
      medId: data.medId.present ? data.medId.value : this.medId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotifOffRow(')
          ..write('medId: $medId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => medId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotifOffRow && other.medId == this.medId);
}

class NotifOffRowsCompanion extends UpdateCompanion<NotifOffRow> {
  final Value<String> medId;
  final Value<int> rowid;
  const NotifOffRowsCompanion({
    this.medId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotifOffRowsCompanion.insert({
    required String medId,
    this.rowid = const Value.absent(),
  }) : medId = Value(medId);
  static Insertable<NotifOffRow> custom({
    Expression<String>? medId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (medId != null) 'med_id': medId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotifOffRowsCompanion copyWith({Value<String>? medId, Value<int>? rowid}) {
    return NotifOffRowsCompanion(
      medId: medId ?? this.medId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (medId.present) {
      map['med_id'] = Variable<String>(medId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotifOffRowsCompanion(')
          ..write('medId: $medId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MedicinesTable medicines = $MedicinesTable(this);
  late final $DoseLogTable doseLog = $DoseLogTable(this);
  late final $SettingsRowsTable settingsRows = $SettingsRowsTable(this);
  late final $NotifOffRowsTable notifOffRows = $NotifOffRowsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    medicines,
    doseLog,
    settingsRows,
    notifOffRows,
  ];
}

typedef $$MedicinesTableCreateCompanionBuilder =
    MedicinesCompanion Function({
      required String id,
      required String name,
      required String dose,
      required String time,
      required String period,
      required bool withFood,
      required String kind,
      required int c1,
      Value<int?> c2,
      required int soft,
      required int supply,
      required int cap,
      Value<int> rowid,
    });
typedef $$MedicinesTableUpdateCompanionBuilder =
    MedicinesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> dose,
      Value<String> time,
      Value<String> period,
      Value<bool> withFood,
      Value<String> kind,
      Value<int> c1,
      Value<int?> c2,
      Value<int> soft,
      Value<int> supply,
      Value<int> cap,
      Value<int> rowid,
    });

class $$MedicinesTableFilterComposer
    extends Composer<_$AppDatabase, $MedicinesTable> {
  $$MedicinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get withFood => $composableBuilder(
    column: $table.withFood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get c1 => $composableBuilder(
    column: $table.c1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get c2 => $composableBuilder(
    column: $table.c2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get soft => $composableBuilder(
    column: $table.soft,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get supply => $composableBuilder(
    column: $table.supply,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cap => $composableBuilder(
    column: $table.cap,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MedicinesTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicinesTable> {
  $$MedicinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get withFood => $composableBuilder(
    column: $table.withFood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get c1 => $composableBuilder(
    column: $table.c1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get c2 => $composableBuilder(
    column: $table.c2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get soft => $composableBuilder(
    column: $table.soft,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get supply => $composableBuilder(
    column: $table.supply,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cap => $composableBuilder(
    column: $table.cap,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MedicinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicinesTable> {
  $$MedicinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dose =>
      $composableBuilder(column: $table.dose, builder: (column) => column);

  GeneratedColumn<String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<bool> get withFood =>
      $composableBuilder(column: $table.withFood, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get c1 =>
      $composableBuilder(column: $table.c1, builder: (column) => column);

  GeneratedColumn<int> get c2 =>
      $composableBuilder(column: $table.c2, builder: (column) => column);

  GeneratedColumn<int> get soft =>
      $composableBuilder(column: $table.soft, builder: (column) => column);

  GeneratedColumn<int> get supply =>
      $composableBuilder(column: $table.supply, builder: (column) => column);

  GeneratedColumn<int> get cap =>
      $composableBuilder(column: $table.cap, builder: (column) => column);
}

class $$MedicinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedicinesTable,
          MedicineRow,
          $$MedicinesTableFilterComposer,
          $$MedicinesTableOrderingComposer,
          $$MedicinesTableAnnotationComposer,
          $$MedicinesTableCreateCompanionBuilder,
          $$MedicinesTableUpdateCompanionBuilder,
          (
            MedicineRow,
            BaseReferences<_$AppDatabase, $MedicinesTable, MedicineRow>,
          ),
          MedicineRow,
          PrefetchHooks Function()
        > {
  $$MedicinesTableTableManager(_$AppDatabase db, $MedicinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> dose = const Value.absent(),
                Value<String> time = const Value.absent(),
                Value<String> period = const Value.absent(),
                Value<bool> withFood = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> c1 = const Value.absent(),
                Value<int?> c2 = const Value.absent(),
                Value<int> soft = const Value.absent(),
                Value<int> supply = const Value.absent(),
                Value<int> cap = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MedicinesCompanion(
                id: id,
                name: name,
                dose: dose,
                time: time,
                period: period,
                withFood: withFood,
                kind: kind,
                c1: c1,
                c2: c2,
                soft: soft,
                supply: supply,
                cap: cap,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String dose,
                required String time,
                required String period,
                required bool withFood,
                required String kind,
                required int c1,
                Value<int?> c2 = const Value.absent(),
                required int soft,
                required int supply,
                required int cap,
                Value<int> rowid = const Value.absent(),
              }) => MedicinesCompanion.insert(
                id: id,
                name: name,
                dose: dose,
                time: time,
                period: period,
                withFood: withFood,
                kind: kind,
                c1: c1,
                c2: c2,
                soft: soft,
                supply: supply,
                cap: cap,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MedicinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedicinesTable,
      MedicineRow,
      $$MedicinesTableFilterComposer,
      $$MedicinesTableOrderingComposer,
      $$MedicinesTableAnnotationComposer,
      $$MedicinesTableCreateCompanionBuilder,
      $$MedicinesTableUpdateCompanionBuilder,
      (
        MedicineRow,
        BaseReferences<_$AppDatabase, $MedicinesTable, MedicineRow>,
      ),
      MedicineRow,
      PrefetchHooks Function()
    >;
typedef $$DoseLogTableCreateCompanionBuilder =
    DoseLogCompanion Function({
      required String iso,
      required String medId,
      Value<bool> taken,
      Value<int> rowid,
    });
typedef $$DoseLogTableUpdateCompanionBuilder =
    DoseLogCompanion Function({
      Value<String> iso,
      Value<String> medId,
      Value<bool> taken,
      Value<int> rowid,
    });

class $$DoseLogTableFilterComposer
    extends Composer<_$AppDatabase, $DoseLogTable> {
  $$DoseLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get iso => $composableBuilder(
    column: $table.iso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medId => $composableBuilder(
    column: $table.medId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get taken => $composableBuilder(
    column: $table.taken,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DoseLogTableOrderingComposer
    extends Composer<_$AppDatabase, $DoseLogTable> {
  $$DoseLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get iso => $composableBuilder(
    column: $table.iso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medId => $composableBuilder(
    column: $table.medId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get taken => $composableBuilder(
    column: $table.taken,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DoseLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoseLogTable> {
  $$DoseLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get iso =>
      $composableBuilder(column: $table.iso, builder: (column) => column);

  GeneratedColumn<String> get medId =>
      $composableBuilder(column: $table.medId, builder: (column) => column);

  GeneratedColumn<bool> get taken =>
      $composableBuilder(column: $table.taken, builder: (column) => column);
}

class $$DoseLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DoseLogTable,
          DoseRow,
          $$DoseLogTableFilterComposer,
          $$DoseLogTableOrderingComposer,
          $$DoseLogTableAnnotationComposer,
          $$DoseLogTableCreateCompanionBuilder,
          $$DoseLogTableUpdateCompanionBuilder,
          (DoseRow, BaseReferences<_$AppDatabase, $DoseLogTable, DoseRow>),
          DoseRow,
          PrefetchHooks Function()
        > {
  $$DoseLogTableTableManager(_$AppDatabase db, $DoseLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoseLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoseLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoseLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> iso = const Value.absent(),
                Value<String> medId = const Value.absent(),
                Value<bool> taken = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseLogCompanion(
                iso: iso,
                medId: medId,
                taken: taken,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String iso,
                required String medId,
                Value<bool> taken = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseLogCompanion.insert(
                iso: iso,
                medId: medId,
                taken: taken,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DoseLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DoseLogTable,
      DoseRow,
      $$DoseLogTableFilterComposer,
      $$DoseLogTableOrderingComposer,
      $$DoseLogTableAnnotationComposer,
      $$DoseLogTableCreateCompanionBuilder,
      $$DoseLogTableUpdateCompanionBuilder,
      (DoseRow, BaseReferences<_$AppDatabase, $DoseLogTable, DoseRow>),
      DoseRow,
      PrefetchHooks Function()
    >;
typedef $$SettingsRowsTableCreateCompanionBuilder =
    SettingsRowsCompanion Function({
      Value<int> id,
      Value<bool> sound,
      Value<bool> vibrate,
      Value<bool> refill,
      Value<String?> localeOverride,
    });
typedef $$SettingsRowsTableUpdateCompanionBuilder =
    SettingsRowsCompanion Function({
      Value<int> id,
      Value<bool> sound,
      Value<bool> vibrate,
      Value<bool> refill,
      Value<String?> localeOverride,
    });

class $$SettingsRowsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sound => $composableBuilder(
    column: $table.sound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get vibrate => $composableBuilder(
    column: $table.vibrate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get refill => $composableBuilder(
    column: $table.refill,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localeOverride => $composableBuilder(
    column: $table.localeOverride,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sound => $composableBuilder(
    column: $table.sound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get vibrate => $composableBuilder(
    column: $table.vibrate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get refill => $composableBuilder(
    column: $table.refill,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localeOverride => $composableBuilder(
    column: $table.localeOverride,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get sound =>
      $composableBuilder(column: $table.sound, builder: (column) => column);

  GeneratedColumn<bool> get vibrate =>
      $composableBuilder(column: $table.vibrate, builder: (column) => column);

  GeneratedColumn<bool> get refill =>
      $composableBuilder(column: $table.refill, builder: (column) => column);

  GeneratedColumn<String> get localeOverride => $composableBuilder(
    column: $table.localeOverride,
    builder: (column) => column,
  );
}

class $$SettingsRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsRowsTable,
          SettingsData,
          $$SettingsRowsTableFilterComposer,
          $$SettingsRowsTableOrderingComposer,
          $$SettingsRowsTableAnnotationComposer,
          $$SettingsRowsTableCreateCompanionBuilder,
          $$SettingsRowsTableUpdateCompanionBuilder,
          (
            SettingsData,
            BaseReferences<_$AppDatabase, $SettingsRowsTable, SettingsData>,
          ),
          SettingsData,
          PrefetchHooks Function()
        > {
  $$SettingsRowsTableTableManager(_$AppDatabase db, $SettingsRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> sound = const Value.absent(),
                Value<bool> vibrate = const Value.absent(),
                Value<bool> refill = const Value.absent(),
                Value<String?> localeOverride = const Value.absent(),
              }) => SettingsRowsCompanion(
                id: id,
                sound: sound,
                vibrate: vibrate,
                refill: refill,
                localeOverride: localeOverride,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> sound = const Value.absent(),
                Value<bool> vibrate = const Value.absent(),
                Value<bool> refill = const Value.absent(),
                Value<String?> localeOverride = const Value.absent(),
              }) => SettingsRowsCompanion.insert(
                id: id,
                sound: sound,
                vibrate: vibrate,
                refill: refill,
                localeOverride: localeOverride,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsRowsTable,
      SettingsData,
      $$SettingsRowsTableFilterComposer,
      $$SettingsRowsTableOrderingComposer,
      $$SettingsRowsTableAnnotationComposer,
      $$SettingsRowsTableCreateCompanionBuilder,
      $$SettingsRowsTableUpdateCompanionBuilder,
      (
        SettingsData,
        BaseReferences<_$AppDatabase, $SettingsRowsTable, SettingsData>,
      ),
      SettingsData,
      PrefetchHooks Function()
    >;
typedef $$NotifOffRowsTableCreateCompanionBuilder =
    NotifOffRowsCompanion Function({required String medId, Value<int> rowid});
typedef $$NotifOffRowsTableUpdateCompanionBuilder =
    NotifOffRowsCompanion Function({Value<String> medId, Value<int> rowid});

class $$NotifOffRowsTableFilterComposer
    extends Composer<_$AppDatabase, $NotifOffRowsTable> {
  $$NotifOffRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get medId => $composableBuilder(
    column: $table.medId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotifOffRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotifOffRowsTable> {
  $$NotifOffRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get medId => $composableBuilder(
    column: $table.medId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotifOffRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotifOffRowsTable> {
  $$NotifOffRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get medId =>
      $composableBuilder(column: $table.medId, builder: (column) => column);
}

class $$NotifOffRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotifOffRowsTable,
          NotifOffRow,
          $$NotifOffRowsTableFilterComposer,
          $$NotifOffRowsTableOrderingComposer,
          $$NotifOffRowsTableAnnotationComposer,
          $$NotifOffRowsTableCreateCompanionBuilder,
          $$NotifOffRowsTableUpdateCompanionBuilder,
          (
            NotifOffRow,
            BaseReferences<_$AppDatabase, $NotifOffRowsTable, NotifOffRow>,
          ),
          NotifOffRow,
          PrefetchHooks Function()
        > {
  $$NotifOffRowsTableTableManager(_$AppDatabase db, $NotifOffRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotifOffRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotifOffRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotifOffRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> medId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotifOffRowsCompanion(medId: medId, rowid: rowid),
          createCompanionCallback:
              ({
                required String medId,
                Value<int> rowid = const Value.absent(),
              }) => NotifOffRowsCompanion.insert(medId: medId, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotifOffRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotifOffRowsTable,
      NotifOffRow,
      $$NotifOffRowsTableFilterComposer,
      $$NotifOffRowsTableOrderingComposer,
      $$NotifOffRowsTableAnnotationComposer,
      $$NotifOffRowsTableCreateCompanionBuilder,
      $$NotifOffRowsTableUpdateCompanionBuilder,
      (
        NotifOffRow,
        BaseReferences<_$AppDatabase, $NotifOffRowsTable, NotifOffRow>,
      ),
      NotifOffRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MedicinesTableTableManager get medicines =>
      $$MedicinesTableTableManager(_db, _db.medicines);
  $$DoseLogTableTableManager get doseLog =>
      $$DoseLogTableTableManager(_db, _db.doseLog);
  $$SettingsRowsTableTableManager get settingsRows =>
      $$SettingsRowsTableTableManager(_db, _db.settingsRows);
  $$NotifOffRowsTableTableManager get notifOffRows =>
      $$NotifOffRowsTableTableManager(_db, _db.notifOffRows);
}
