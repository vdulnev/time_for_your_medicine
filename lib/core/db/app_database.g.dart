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
    withFood,
    kind,
    c1,
    c2,
    soft,
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
  final bool withFood;
  final String kind;
  final int c1;
  final int? c2;
  final int soft;

  /// The "full pack" size, for refill %/alerts. The *current* pill count
  /// is not stored here — it's derived from [SupplyTransactions], see
  /// `MedicineRepository._currentSupply`.
  final int cap;
  const MedicineRow({
    required this.id,
    required this.name,
    required this.dose,
    required this.withFood,
    required this.kind,
    required this.c1,
    this.c2,
    required this.soft,
    required this.cap,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['dose'] = Variable<String>(dose);
    map['with_food'] = Variable<bool>(withFood);
    map['kind'] = Variable<String>(kind);
    map['c1'] = Variable<int>(c1);
    if (!nullToAbsent || c2 != null) {
      map['c2'] = Variable<int>(c2);
    }
    map['soft'] = Variable<int>(soft);
    map['cap'] = Variable<int>(cap);
    return map;
  }

  MedicinesCompanion toCompanion(bool nullToAbsent) {
    return MedicinesCompanion(
      id: Value(id),
      name: Value(name),
      dose: Value(dose),
      withFood: Value(withFood),
      kind: Value(kind),
      c1: Value(c1),
      c2: c2 == null && nullToAbsent ? const Value.absent() : Value(c2),
      soft: Value(soft),
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
      withFood: serializer.fromJson<bool>(json['withFood']),
      kind: serializer.fromJson<String>(json['kind']),
      c1: serializer.fromJson<int>(json['c1']),
      c2: serializer.fromJson<int?>(json['c2']),
      soft: serializer.fromJson<int>(json['soft']),
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
      'withFood': serializer.toJson<bool>(withFood),
      'kind': serializer.toJson<String>(kind),
      'c1': serializer.toJson<int>(c1),
      'c2': serializer.toJson<int?>(c2),
      'soft': serializer.toJson<int>(soft),
      'cap': serializer.toJson<int>(cap),
    };
  }

  MedicineRow copyWith({
    String? id,
    String? name,
    String? dose,
    bool? withFood,
    String? kind,
    int? c1,
    Value<int?> c2 = const Value.absent(),
    int? soft,
    int? cap,
  }) => MedicineRow(
    id: id ?? this.id,
    name: name ?? this.name,
    dose: dose ?? this.dose,
    withFood: withFood ?? this.withFood,
    kind: kind ?? this.kind,
    c1: c1 ?? this.c1,
    c2: c2.present ? c2.value : this.c2,
    soft: soft ?? this.soft,
    cap: cap ?? this.cap,
  );
  MedicineRow copyWithCompanion(MedicinesCompanion data) {
    return MedicineRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      dose: data.dose.present ? data.dose.value : this.dose,
      withFood: data.withFood.present ? data.withFood.value : this.withFood,
      kind: data.kind.present ? data.kind.value : this.kind,
      c1: data.c1.present ? data.c1.value : this.c1,
      c2: data.c2.present ? data.c2.value : this.c2,
      soft: data.soft.present ? data.soft.value : this.soft,
      cap: data.cap.present ? data.cap.value : this.cap,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicineRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dose: $dose, ')
          ..write('withFood: $withFood, ')
          ..write('kind: $kind, ')
          ..write('c1: $c1, ')
          ..write('c2: $c2, ')
          ..write('soft: $soft, ')
          ..write('cap: $cap')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, dose, withFood, kind, c1, c2, soft, cap);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicineRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.dose == this.dose &&
          other.withFood == this.withFood &&
          other.kind == this.kind &&
          other.c1 == this.c1 &&
          other.c2 == this.c2 &&
          other.soft == this.soft &&
          other.cap == this.cap);
}

class MedicinesCompanion extends UpdateCompanion<MedicineRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> dose;
  final Value<bool> withFood;
  final Value<String> kind;
  final Value<int> c1;
  final Value<int?> c2;
  final Value<int> soft;
  final Value<int> cap;
  final Value<int> rowid;
  const MedicinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dose = const Value.absent(),
    this.withFood = const Value.absent(),
    this.kind = const Value.absent(),
    this.c1 = const Value.absent(),
    this.c2 = const Value.absent(),
    this.soft = const Value.absent(),
    this.cap = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicinesCompanion.insert({
    required String id,
    required String name,
    required String dose,
    required bool withFood,
    required String kind,
    required int c1,
    this.c2 = const Value.absent(),
    required int soft,
    required int cap,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       dose = Value(dose),
       withFood = Value(withFood),
       kind = Value(kind),
       c1 = Value(c1),
       soft = Value(soft),
       cap = Value(cap);
  static Insertable<MedicineRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? dose,
    Expression<bool>? withFood,
    Expression<String>? kind,
    Expression<int>? c1,
    Expression<int>? c2,
    Expression<int>? soft,
    Expression<int>? cap,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (dose != null) 'dose': dose,
      if (withFood != null) 'with_food': withFood,
      if (kind != null) 'kind': kind,
      if (c1 != null) 'c1': c1,
      if (c2 != null) 'c2': c2,
      if (soft != null) 'soft': soft,
      if (cap != null) 'cap': cap,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicinesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? dose,
    Value<bool>? withFood,
    Value<String>? kind,
    Value<int>? c1,
    Value<int?>? c2,
    Value<int>? soft,
    Value<int>? cap,
    Value<int>? rowid,
  }) {
    return MedicinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dose: dose ?? this.dose,
      withFood: withFood ?? this.withFood,
      kind: kind ?? this.kind,
      c1: c1 ?? this.c1,
      c2: c2 ?? this.c2,
      soft: soft ?? this.soft,
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
          ..write('withFood: $withFood, ')
          ..write('kind: $kind, ')
          ..write('c1: $c1, ')
          ..write('c2: $c2, ')
          ..write('soft: $soft, ')
          ..write('cap: $cap, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DoseTimesTable extends DoseTimes
    with TableInfo<$DoseTimesTable, DoseTimeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoseTimesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _medIdMeta = const VerificationMeta('medId');
  @override
  late final GeneratedColumn<String> medId = GeneratedColumn<String>(
    'med_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [medId, id, time, period, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dose_times';
  @override
  VerificationContext validateIntegrity(
    Insertable<DoseTimeRow> instance, {
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {medId, id};
  @override
  DoseTimeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoseTimeRow(
      medId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}med_id'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time'],
      )!,
      period: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $DoseTimesTable createAlias(String alias) {
    return $DoseTimesTable(attachedDatabase, alias);
  }
}

class DoseTimeRow extends DataClass implements Insertable<DoseTimeRow> {
  final String medId;
  final String id;
  final String time;
  final String period;
  final int sortOrder;
  const DoseTimeRow({
    required this.medId,
    required this.id,
    required this.time,
    required this.period,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['med_id'] = Variable<String>(medId);
    map['id'] = Variable<String>(id);
    map['time'] = Variable<String>(time);
    map['period'] = Variable<String>(period);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  DoseTimesCompanion toCompanion(bool nullToAbsent) {
    return DoseTimesCompanion(
      medId: Value(medId),
      id: Value(id),
      time: Value(time),
      period: Value(period),
      sortOrder: Value(sortOrder),
    );
  }

  factory DoseTimeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoseTimeRow(
      medId: serializer.fromJson<String>(json['medId']),
      id: serializer.fromJson<String>(json['id']),
      time: serializer.fromJson<String>(json['time']),
      period: serializer.fromJson<String>(json['period']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'medId': serializer.toJson<String>(medId),
      'id': serializer.toJson<String>(id),
      'time': serializer.toJson<String>(time),
      'period': serializer.toJson<String>(period),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  DoseTimeRow copyWith({
    String? medId,
    String? id,
    String? time,
    String? period,
    int? sortOrder,
  }) => DoseTimeRow(
    medId: medId ?? this.medId,
    id: id ?? this.id,
    time: time ?? this.time,
    period: period ?? this.period,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  DoseTimeRow copyWithCompanion(DoseTimesCompanion data) {
    return DoseTimeRow(
      medId: data.medId.present ? data.medId.value : this.medId,
      id: data.id.present ? data.id.value : this.id,
      time: data.time.present ? data.time.value : this.time,
      period: data.period.present ? data.period.value : this.period,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoseTimeRow(')
          ..write('medId: $medId, ')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('period: $period, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(medId, id, time, period, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoseTimeRow &&
          other.medId == this.medId &&
          other.id == this.id &&
          other.time == this.time &&
          other.period == this.period &&
          other.sortOrder == this.sortOrder);
}

class DoseTimesCompanion extends UpdateCompanion<DoseTimeRow> {
  final Value<String> medId;
  final Value<String> id;
  final Value<String> time;
  final Value<String> period;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const DoseTimesCompanion({
    this.medId = const Value.absent(),
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    this.period = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DoseTimesCompanion.insert({
    required String medId,
    required String id,
    required String time,
    required String period,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : medId = Value(medId),
       id = Value(id),
       time = Value(time),
       period = Value(period);
  static Insertable<DoseTimeRow> custom({
    Expression<String>? medId,
    Expression<String>? id,
    Expression<String>? time,
    Expression<String>? period,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (medId != null) 'med_id': medId,
      if (id != null) 'id': id,
      if (time != null) 'time': time,
      if (period != null) 'period': period,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DoseTimesCompanion copyWith({
    Value<String>? medId,
    Value<String>? id,
    Value<String>? time,
    Value<String>? period,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return DoseTimesCompanion(
      medId: medId ?? this.medId,
      id: id ?? this.id,
      time: time ?? this.time,
      period: period ?? this.period,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (medId.present) {
      map['med_id'] = Variable<String>(medId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoseTimesCompanion(')
          ..write('medId: $medId, ')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('period: $period, ')
          ..write('sortOrder: $sortOrder, ')
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
  static const VerificationMeta _doseTimeIdMeta = const VerificationMeta(
    'doseTimeId',
  );
  @override
  late final GeneratedColumn<String> doseTimeId = GeneratedColumn<String>(
    'dose_time_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [iso, medId, doseTimeId, status];
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
    if (data.containsKey('dose_time_id')) {
      context.handle(
        _doseTimeIdMeta,
        doseTimeId.isAcceptableOrUnknown(
          data['dose_time_id']!,
          _doseTimeIdMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {iso, medId, doseTimeId};
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
      doseTimeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dose_time_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
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
  final String doseTimeId;

  /// A [DoseStatus] name. A row only exists once a dose has been touched —
  /// absence means pending, so this is never actually 'pending' in practice.
  final String status;
  const DoseRow({
    required this.iso,
    required this.medId,
    required this.doseTimeId,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['iso'] = Variable<String>(iso);
    map['med_id'] = Variable<String>(medId);
    map['dose_time_id'] = Variable<String>(doseTimeId);
    map['status'] = Variable<String>(status);
    return map;
  }

  DoseLogCompanion toCompanion(bool nullToAbsent) {
    return DoseLogCompanion(
      iso: Value(iso),
      medId: Value(medId),
      doseTimeId: Value(doseTimeId),
      status: Value(status),
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
      doseTimeId: serializer.fromJson<String>(json['doseTimeId']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'iso': serializer.toJson<String>(iso),
      'medId': serializer.toJson<String>(medId),
      'doseTimeId': serializer.toJson<String>(doseTimeId),
      'status': serializer.toJson<String>(status),
    };
  }

  DoseRow copyWith({
    String? iso,
    String? medId,
    String? doseTimeId,
    String? status,
  }) => DoseRow(
    iso: iso ?? this.iso,
    medId: medId ?? this.medId,
    doseTimeId: doseTimeId ?? this.doseTimeId,
    status: status ?? this.status,
  );
  DoseRow copyWithCompanion(DoseLogCompanion data) {
    return DoseRow(
      iso: data.iso.present ? data.iso.value : this.iso,
      medId: data.medId.present ? data.medId.value : this.medId,
      doseTimeId: data.doseTimeId.present
          ? data.doseTimeId.value
          : this.doseTimeId,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoseRow(')
          ..write('iso: $iso, ')
          ..write('medId: $medId, ')
          ..write('doseTimeId: $doseTimeId, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(iso, medId, doseTimeId, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoseRow &&
          other.iso == this.iso &&
          other.medId == this.medId &&
          other.doseTimeId == this.doseTimeId &&
          other.status == this.status);
}

class DoseLogCompanion extends UpdateCompanion<DoseRow> {
  final Value<String> iso;
  final Value<String> medId;
  final Value<String> doseTimeId;
  final Value<String> status;
  final Value<int> rowid;
  const DoseLogCompanion({
    this.iso = const Value.absent(),
    this.medId = const Value.absent(),
    this.doseTimeId = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DoseLogCompanion.insert({
    required String iso,
    required String medId,
    this.doseTimeId = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : iso = Value(iso),
       medId = Value(medId);
  static Insertable<DoseRow> custom({
    Expression<String>? iso,
    Expression<String>? medId,
    Expression<String>? doseTimeId,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (iso != null) 'iso': iso,
      if (medId != null) 'med_id': medId,
      if (doseTimeId != null) 'dose_time_id': doseTimeId,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DoseLogCompanion copyWith({
    Value<String>? iso,
    Value<String>? medId,
    Value<String>? doseTimeId,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return DoseLogCompanion(
      iso: iso ?? this.iso,
      medId: medId ?? this.medId,
      doseTimeId: doseTimeId ?? this.doseTimeId,
      status: status ?? this.status,
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
    if (doseTimeId.present) {
      map['dose_time_id'] = Variable<String>(doseTimeId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
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
          ..write('doseTimeId: $doseTimeId, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SupplyTransactionsTable extends SupplyTransactions
    with TableInfo<$SupplyTransactionsTable, SupplyTransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplyTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _deltaMeta = const VerificationMeta('delta');
  @override
  late final GeneratedColumn<int> delta = GeneratedColumn<int>(
    'delta',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isoMeta = const VerificationMeta('iso');
  @override
  late final GeneratedColumn<String> iso = GeneratedColumn<String>(
    'iso',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doseTimeIdMeta = const VerificationMeta(
    'doseTimeId',
  );
  @override
  late final GeneratedColumn<String> doseTimeId = GeneratedColumn<String>(
    'dose_time_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    medId,
    delta,
    kind,
    createdAt,
    iso,
    doseTimeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supply_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplyTransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('med_id')) {
      context.handle(
        _medIdMeta,
        medId.isAcceptableOrUnknown(data['med_id']!, _medIdMeta),
      );
    } else if (isInserting) {
      context.missing(_medIdMeta);
    }
    if (data.containsKey('delta')) {
      context.handle(
        _deltaMeta,
        delta.isAcceptableOrUnknown(data['delta']!, _deltaMeta),
      );
    } else if (isInserting) {
      context.missing(_deltaMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('iso')) {
      context.handle(
        _isoMeta,
        iso.isAcceptableOrUnknown(data['iso']!, _isoMeta),
      );
    }
    if (data.containsKey('dose_time_id')) {
      context.handle(
        _doseTimeIdMeta,
        doseTimeId.isAcceptableOrUnknown(
          data['dose_time_id']!,
          _doseTimeIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplyTransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplyTransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      medId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}med_id'],
      )!,
      delta: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delta'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      iso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}iso'],
      ),
      doseTimeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dose_time_id'],
      ),
    );
  }

  @override
  $SupplyTransactionsTable createAlias(String alias) {
    return $SupplyTransactionsTable(attachedDatabase, alias);
  }
}

class SupplyTransactionRow extends DataClass
    implements Insertable<SupplyTransactionRow> {
  final int id;
  final String medId;
  final int delta;

  /// 'initial' | 'refill' | 'take' | 'revertTake'
  final String kind;
  final DateTime createdAt;

  /// Set for 'take' / 'revertTake' transactions, tying them back to the
  /// specific dose that caused them.
  final String? iso;
  final String? doseTimeId;
  const SupplyTransactionRow({
    required this.id,
    required this.medId,
    required this.delta,
    required this.kind,
    required this.createdAt,
    this.iso,
    this.doseTimeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['med_id'] = Variable<String>(medId);
    map['delta'] = Variable<int>(delta);
    map['kind'] = Variable<String>(kind);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || iso != null) {
      map['iso'] = Variable<String>(iso);
    }
    if (!nullToAbsent || doseTimeId != null) {
      map['dose_time_id'] = Variable<String>(doseTimeId);
    }
    return map;
  }

  SupplyTransactionsCompanion toCompanion(bool nullToAbsent) {
    return SupplyTransactionsCompanion(
      id: Value(id),
      medId: Value(medId),
      delta: Value(delta),
      kind: Value(kind),
      createdAt: Value(createdAt),
      iso: iso == null && nullToAbsent ? const Value.absent() : Value(iso),
      doseTimeId: doseTimeId == null && nullToAbsent
          ? const Value.absent()
          : Value(doseTimeId),
    );
  }

  factory SupplyTransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplyTransactionRow(
      id: serializer.fromJson<int>(json['id']),
      medId: serializer.fromJson<String>(json['medId']),
      delta: serializer.fromJson<int>(json['delta']),
      kind: serializer.fromJson<String>(json['kind']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      iso: serializer.fromJson<String?>(json['iso']),
      doseTimeId: serializer.fromJson<String?>(json['doseTimeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'medId': serializer.toJson<String>(medId),
      'delta': serializer.toJson<int>(delta),
      'kind': serializer.toJson<String>(kind),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'iso': serializer.toJson<String?>(iso),
      'doseTimeId': serializer.toJson<String?>(doseTimeId),
    };
  }

  SupplyTransactionRow copyWith({
    int? id,
    String? medId,
    int? delta,
    String? kind,
    DateTime? createdAt,
    Value<String?> iso = const Value.absent(),
    Value<String?> doseTimeId = const Value.absent(),
  }) => SupplyTransactionRow(
    id: id ?? this.id,
    medId: medId ?? this.medId,
    delta: delta ?? this.delta,
    kind: kind ?? this.kind,
    createdAt: createdAt ?? this.createdAt,
    iso: iso.present ? iso.value : this.iso,
    doseTimeId: doseTimeId.present ? doseTimeId.value : this.doseTimeId,
  );
  SupplyTransactionRow copyWithCompanion(SupplyTransactionsCompanion data) {
    return SupplyTransactionRow(
      id: data.id.present ? data.id.value : this.id,
      medId: data.medId.present ? data.medId.value : this.medId,
      delta: data.delta.present ? data.delta.value : this.delta,
      kind: data.kind.present ? data.kind.value : this.kind,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      iso: data.iso.present ? data.iso.value : this.iso,
      doseTimeId: data.doseTimeId.present
          ? data.doseTimeId.value
          : this.doseTimeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplyTransactionRow(')
          ..write('id: $id, ')
          ..write('medId: $medId, ')
          ..write('delta: $delta, ')
          ..write('kind: $kind, ')
          ..write('createdAt: $createdAt, ')
          ..write('iso: $iso, ')
          ..write('doseTimeId: $doseTimeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, medId, delta, kind, createdAt, iso, doseTimeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplyTransactionRow &&
          other.id == this.id &&
          other.medId == this.medId &&
          other.delta == this.delta &&
          other.kind == this.kind &&
          other.createdAt == this.createdAt &&
          other.iso == this.iso &&
          other.doseTimeId == this.doseTimeId);
}

class SupplyTransactionsCompanion
    extends UpdateCompanion<SupplyTransactionRow> {
  final Value<int> id;
  final Value<String> medId;
  final Value<int> delta;
  final Value<String> kind;
  final Value<DateTime> createdAt;
  final Value<String?> iso;
  final Value<String?> doseTimeId;
  const SupplyTransactionsCompanion({
    this.id = const Value.absent(),
    this.medId = const Value.absent(),
    this.delta = const Value.absent(),
    this.kind = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.iso = const Value.absent(),
    this.doseTimeId = const Value.absent(),
  });
  SupplyTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String medId,
    required int delta,
    required String kind,
    required DateTime createdAt,
    this.iso = const Value.absent(),
    this.doseTimeId = const Value.absent(),
  }) : medId = Value(medId),
       delta = Value(delta),
       kind = Value(kind),
       createdAt = Value(createdAt);
  static Insertable<SupplyTransactionRow> custom({
    Expression<int>? id,
    Expression<String>? medId,
    Expression<int>? delta,
    Expression<String>? kind,
    Expression<DateTime>? createdAt,
    Expression<String>? iso,
    Expression<String>? doseTimeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (medId != null) 'med_id': medId,
      if (delta != null) 'delta': delta,
      if (kind != null) 'kind': kind,
      if (createdAt != null) 'created_at': createdAt,
      if (iso != null) 'iso': iso,
      if (doseTimeId != null) 'dose_time_id': doseTimeId,
    });
  }

  SupplyTransactionsCompanion copyWith({
    Value<int>? id,
    Value<String>? medId,
    Value<int>? delta,
    Value<String>? kind,
    Value<DateTime>? createdAt,
    Value<String?>? iso,
    Value<String?>? doseTimeId,
  }) {
    return SupplyTransactionsCompanion(
      id: id ?? this.id,
      medId: medId ?? this.medId,
      delta: delta ?? this.delta,
      kind: kind ?? this.kind,
      createdAt: createdAt ?? this.createdAt,
      iso: iso ?? this.iso,
      doseTimeId: doseTimeId ?? this.doseTimeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (medId.present) {
      map['med_id'] = Variable<String>(medId.value);
    }
    if (delta.present) {
      map['delta'] = Variable<int>(delta.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (iso.present) {
      map['iso'] = Variable<String>(iso.value);
    }
    if (doseTimeId.present) {
      map['dose_time_id'] = Variable<String>(doseTimeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplyTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('medId: $medId, ')
          ..write('delta: $delta, ')
          ..write('kind: $kind, ')
          ..write('createdAt: $createdAt, ')
          ..write('iso: $iso, ')
          ..write('doseTimeId: $doseTimeId')
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

class $MedicineRegistryEntriesTable extends MedicineRegistryEntries
    with TableInfo<$MedicineRegistryEntriesTable, MedicineRegistryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicineRegistryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _genericNameMeta = const VerificationMeta(
    'genericName',
  );
  @override
  late final GeneratedColumn<String> genericName = GeneratedColumn<String>(
    'generic_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  @override
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
    'form',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchTextMeta = const VerificationMeta(
    'searchText',
  );
  @override
  late final GeneratedColumn<String> searchText = GeneratedColumn<String>(
    'search_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    genericName,
    form,
    searchText,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicine_registry_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MedicineRegistryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('generic_name')) {
      context.handle(
        _genericNameMeta,
        genericName.isAcceptableOrUnknown(
          data['generic_name']!,
          _genericNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_genericNameMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('search_text')) {
      context.handle(
        _searchTextMeta,
        searchText.isAcceptableOrUnknown(data['search_text']!, _searchTextMeta),
      );
    } else if (isInserting) {
      context.missing(_searchTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicineRegistryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicineRegistryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      genericName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}generic_name'],
      )!,
      form: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      searchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_text'],
      )!,
    );
  }

  @override
  $MedicineRegistryEntriesTable createAlias(String alias) {
    return $MedicineRegistryEntriesTable(attachedDatabase, alias);
  }
}

class MedicineRegistryRow extends DataClass
    implements Insertable<MedicineRegistryRow> {
  final int id;
  final String name;
  final String genericName;
  final String form;
  final String searchText;
  const MedicineRegistryRow({
    required this.id,
    required this.name,
    required this.genericName,
    required this.form,
    required this.searchText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['generic_name'] = Variable<String>(genericName);
    map['form'] = Variable<String>(form);
    map['search_text'] = Variable<String>(searchText);
    return map;
  }

  MedicineRegistryEntriesCompanion toCompanion(bool nullToAbsent) {
    return MedicineRegistryEntriesCompanion(
      id: Value(id),
      name: Value(name),
      genericName: Value(genericName),
      form: Value(form),
      searchText: Value(searchText),
    );
  }

  factory MedicineRegistryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicineRegistryRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      genericName: serializer.fromJson<String>(json['genericName']),
      form: serializer.fromJson<String>(json['form']),
      searchText: serializer.fromJson<String>(json['searchText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'genericName': serializer.toJson<String>(genericName),
      'form': serializer.toJson<String>(form),
      'searchText': serializer.toJson<String>(searchText),
    };
  }

  MedicineRegistryRow copyWith({
    int? id,
    String? name,
    String? genericName,
    String? form,
    String? searchText,
  }) => MedicineRegistryRow(
    id: id ?? this.id,
    name: name ?? this.name,
    genericName: genericName ?? this.genericName,
    form: form ?? this.form,
    searchText: searchText ?? this.searchText,
  );
  MedicineRegistryRow copyWithCompanion(MedicineRegistryEntriesCompanion data) {
    return MedicineRegistryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      genericName: data.genericName.present
          ? data.genericName.value
          : this.genericName,
      form: data.form.present ? data.form.value : this.form,
      searchText: data.searchText.present
          ? data.searchText.value
          : this.searchText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicineRegistryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('genericName: $genericName, ')
          ..write('form: $form, ')
          ..write('searchText: $searchText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, genericName, form, searchText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicineRegistryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.genericName == this.genericName &&
          other.form == this.form &&
          other.searchText == this.searchText);
}

class MedicineRegistryEntriesCompanion
    extends UpdateCompanion<MedicineRegistryRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> genericName;
  final Value<String> form;
  final Value<String> searchText;
  const MedicineRegistryEntriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.genericName = const Value.absent(),
    this.form = const Value.absent(),
    this.searchText = const Value.absent(),
  });
  MedicineRegistryEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String genericName,
    required String form,
    required String searchText,
  }) : name = Value(name),
       genericName = Value(genericName),
       form = Value(form),
       searchText = Value(searchText);
  static Insertable<MedicineRegistryRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? genericName,
    Expression<String>? form,
    Expression<String>? searchText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (genericName != null) 'generic_name': genericName,
      if (form != null) 'form': form,
      if (searchText != null) 'search_text': searchText,
    });
  }

  MedicineRegistryEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? genericName,
    Value<String>? form,
    Value<String>? searchText,
  }) {
    return MedicineRegistryEntriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      genericName: genericName ?? this.genericName,
      form: form ?? this.form,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (genericName.present) {
      map['generic_name'] = Variable<String>(genericName.value);
    }
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (searchText.present) {
      map['search_text'] = Variable<String>(searchText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicineRegistryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('genericName: $genericName, ')
          ..write('form: $form, ')
          ..write('searchText: $searchText')
          ..write(')'))
        .toString();
  }
}

class $MedicineRegistryMetaTable extends MedicineRegistryMeta
    with TableInfo<$MedicineRegistryMetaTable, MedicineRegistryMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicineRegistryMetaTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sourceNameMeta = const VerificationMeta(
    'sourceName',
  );
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
    'source_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entryCountMeta = const VerificationMeta(
    'entryCount',
  );
  @override
  late final GeneratedColumn<int> entryCount = GeneratedColumn<int>(
    'entry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceName,
    importedAt,
    entryCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicine_registry_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<MedicineRegistryMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_name')) {
      context.handle(
        _sourceNameMeta,
        sourceName.isAcceptableOrUnknown(data['source_name']!, _sourceNameMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceNameMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    if (data.containsKey('entry_count')) {
      context.handle(
        _entryCountMeta,
        entryCount.isAcceptableOrUnknown(data['entry_count']!, _entryCountMeta),
      );
    } else if (isInserting) {
      context.missing(_entryCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicineRegistryMetaRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicineRegistryMetaRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_name'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
      entryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entry_count'],
      )!,
    );
  }

  @override
  $MedicineRegistryMetaTable createAlias(String alias) {
    return $MedicineRegistryMetaTable(attachedDatabase, alias);
  }
}

class MedicineRegistryMetaRow extends DataClass
    implements Insertable<MedicineRegistryMetaRow> {
  final int id;
  final String sourceName;
  final DateTime importedAt;
  final int entryCount;
  const MedicineRegistryMetaRow({
    required this.id,
    required this.sourceName,
    required this.importedAt,
    required this.entryCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_name'] = Variable<String>(sourceName);
    map['imported_at'] = Variable<DateTime>(importedAt);
    map['entry_count'] = Variable<int>(entryCount);
    return map;
  }

  MedicineRegistryMetaCompanion toCompanion(bool nullToAbsent) {
    return MedicineRegistryMetaCompanion(
      id: Value(id),
      sourceName: Value(sourceName),
      importedAt: Value(importedAt),
      entryCount: Value(entryCount),
    );
  }

  factory MedicineRegistryMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicineRegistryMetaRow(
      id: serializer.fromJson<int>(json['id']),
      sourceName: serializer.fromJson<String>(json['sourceName']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
      entryCount: serializer.fromJson<int>(json['entryCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceName': serializer.toJson<String>(sourceName),
      'importedAt': serializer.toJson<DateTime>(importedAt),
      'entryCount': serializer.toJson<int>(entryCount),
    };
  }

  MedicineRegistryMetaRow copyWith({
    int? id,
    String? sourceName,
    DateTime? importedAt,
    int? entryCount,
  }) => MedicineRegistryMetaRow(
    id: id ?? this.id,
    sourceName: sourceName ?? this.sourceName,
    importedAt: importedAt ?? this.importedAt,
    entryCount: entryCount ?? this.entryCount,
  );
  MedicineRegistryMetaRow copyWithCompanion(
    MedicineRegistryMetaCompanion data,
  ) {
    return MedicineRegistryMetaRow(
      id: data.id.present ? data.id.value : this.id,
      sourceName: data.sourceName.present
          ? data.sourceName.value
          : this.sourceName,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      entryCount: data.entryCount.present
          ? data.entryCount.value
          : this.entryCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicineRegistryMetaRow(')
          ..write('id: $id, ')
          ..write('sourceName: $sourceName, ')
          ..write('importedAt: $importedAt, ')
          ..write('entryCount: $entryCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceName, importedAt, entryCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicineRegistryMetaRow &&
          other.id == this.id &&
          other.sourceName == this.sourceName &&
          other.importedAt == this.importedAt &&
          other.entryCount == this.entryCount);
}

class MedicineRegistryMetaCompanion
    extends UpdateCompanion<MedicineRegistryMetaRow> {
  final Value<int> id;
  final Value<String> sourceName;
  final Value<DateTime> importedAt;
  final Value<int> entryCount;
  const MedicineRegistryMetaCompanion({
    this.id = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.entryCount = const Value.absent(),
  });
  MedicineRegistryMetaCompanion.insert({
    this.id = const Value.absent(),
    required String sourceName,
    required DateTime importedAt,
    required int entryCount,
  }) : sourceName = Value(sourceName),
       importedAt = Value(importedAt),
       entryCount = Value(entryCount);
  static Insertable<MedicineRegistryMetaRow> custom({
    Expression<int>? id,
    Expression<String>? sourceName,
    Expression<DateTime>? importedAt,
    Expression<int>? entryCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceName != null) 'source_name': sourceName,
      if (importedAt != null) 'imported_at': importedAt,
      if (entryCount != null) 'entry_count': entryCount,
    });
  }

  MedicineRegistryMetaCompanion copyWith({
    Value<int>? id,
    Value<String>? sourceName,
    Value<DateTime>? importedAt,
    Value<int>? entryCount,
  }) {
    return MedicineRegistryMetaCompanion(
      id: id ?? this.id,
      sourceName: sourceName ?? this.sourceName,
      importedAt: importedAt ?? this.importedAt,
      entryCount: entryCount ?? this.entryCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (entryCount.present) {
      map['entry_count'] = Variable<int>(entryCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicineRegistryMetaCompanion(')
          ..write('id: $id, ')
          ..write('sourceName: $sourceName, ')
          ..write('importedAt: $importedAt, ')
          ..write('entryCount: $entryCount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MedicinesTable medicines = $MedicinesTable(this);
  late final $DoseTimesTable doseTimes = $DoseTimesTable(this);
  late final $DoseLogTable doseLog = $DoseLogTable(this);
  late final $SupplyTransactionsTable supplyTransactions =
      $SupplyTransactionsTable(this);
  late final $SettingsRowsTable settingsRows = $SettingsRowsTable(this);
  late final $NotifOffRowsTable notifOffRows = $NotifOffRowsTable(this);
  late final $MedicineRegistryEntriesTable medicineRegistryEntries =
      $MedicineRegistryEntriesTable(this);
  late final $MedicineRegistryMetaTable medicineRegistryMeta =
      $MedicineRegistryMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    medicines,
    doseTimes,
    doseLog,
    supplyTransactions,
    settingsRows,
    notifOffRows,
    medicineRegistryEntries,
    medicineRegistryMeta,
  ];
}

typedef $$MedicinesTableCreateCompanionBuilder =
    MedicinesCompanion Function({
      required String id,
      required String name,
      required String dose,
      required bool withFood,
      required String kind,
      required int c1,
      Value<int?> c2,
      required int soft,
      required int cap,
      Value<int> rowid,
    });
typedef $$MedicinesTableUpdateCompanionBuilder =
    MedicinesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> dose,
      Value<bool> withFood,
      Value<String> kind,
      Value<int> c1,
      Value<int?> c2,
      Value<int> soft,
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
                Value<bool> withFood = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> c1 = const Value.absent(),
                Value<int?> c2 = const Value.absent(),
                Value<int> soft = const Value.absent(),
                Value<int> cap = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MedicinesCompanion(
                id: id,
                name: name,
                dose: dose,
                withFood: withFood,
                kind: kind,
                c1: c1,
                c2: c2,
                soft: soft,
                cap: cap,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String dose,
                required bool withFood,
                required String kind,
                required int c1,
                Value<int?> c2 = const Value.absent(),
                required int soft,
                required int cap,
                Value<int> rowid = const Value.absent(),
              }) => MedicinesCompanion.insert(
                id: id,
                name: name,
                dose: dose,
                withFood: withFood,
                kind: kind,
                c1: c1,
                c2: c2,
                soft: soft,
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
typedef $$DoseTimesTableCreateCompanionBuilder =
    DoseTimesCompanion Function({
      required String medId,
      required String id,
      required String time,
      required String period,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$DoseTimesTableUpdateCompanionBuilder =
    DoseTimesCompanion Function({
      Value<String> medId,
      Value<String> id,
      Value<String> time,
      Value<String> period,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$DoseTimesTableFilterComposer
    extends Composer<_$AppDatabase, $DoseTimesTable> {
  $$DoseTimesTableFilterComposer({
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

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DoseTimesTableOrderingComposer
    extends Composer<_$AppDatabase, $DoseTimesTable> {
  $$DoseTimesTableOrderingComposer({
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

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DoseTimesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoseTimesTable> {
  $$DoseTimesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get medId =>
      $composableBuilder(column: $table.medId, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$DoseTimesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DoseTimesTable,
          DoseTimeRow,
          $$DoseTimesTableFilterComposer,
          $$DoseTimesTableOrderingComposer,
          $$DoseTimesTableAnnotationComposer,
          $$DoseTimesTableCreateCompanionBuilder,
          $$DoseTimesTableUpdateCompanionBuilder,
          (
            DoseTimeRow,
            BaseReferences<_$AppDatabase, $DoseTimesTable, DoseTimeRow>,
          ),
          DoseTimeRow,
          PrefetchHooks Function()
        > {
  $$DoseTimesTableTableManager(_$AppDatabase db, $DoseTimesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoseTimesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoseTimesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoseTimesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> medId = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> time = const Value.absent(),
                Value<String> period = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseTimesCompanion(
                medId: medId,
                id: id,
                time: time,
                period: period,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String medId,
                required String id,
                required String time,
                required String period,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseTimesCompanion.insert(
                medId: medId,
                id: id,
                time: time,
                period: period,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DoseTimesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DoseTimesTable,
      DoseTimeRow,
      $$DoseTimesTableFilterComposer,
      $$DoseTimesTableOrderingComposer,
      $$DoseTimesTableAnnotationComposer,
      $$DoseTimesTableCreateCompanionBuilder,
      $$DoseTimesTableUpdateCompanionBuilder,
      (
        DoseTimeRow,
        BaseReferences<_$AppDatabase, $DoseTimesTable, DoseTimeRow>,
      ),
      DoseTimeRow,
      PrefetchHooks Function()
    >;
typedef $$DoseLogTableCreateCompanionBuilder =
    DoseLogCompanion Function({
      required String iso,
      required String medId,
      Value<String> doseTimeId,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$DoseLogTableUpdateCompanionBuilder =
    DoseLogCompanion Function({
      Value<String> iso,
      Value<String> medId,
      Value<String> doseTimeId,
      Value<String> status,
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

  ColumnFilters<String> get doseTimeId => $composableBuilder(
    column: $table.doseTimeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
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

  ColumnOrderings<String> get doseTimeId => $composableBuilder(
    column: $table.doseTimeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
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

  GeneratedColumn<String> get doseTimeId => $composableBuilder(
    column: $table.doseTimeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
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
                Value<String> doseTimeId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseLogCompanion(
                iso: iso,
                medId: medId,
                doseTimeId: doseTimeId,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String iso,
                required String medId,
                Value<String> doseTimeId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseLogCompanion.insert(
                iso: iso,
                medId: medId,
                doseTimeId: doseTimeId,
                status: status,
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
typedef $$SupplyTransactionsTableCreateCompanionBuilder =
    SupplyTransactionsCompanion Function({
      Value<int> id,
      required String medId,
      required int delta,
      required String kind,
      required DateTime createdAt,
      Value<String?> iso,
      Value<String?> doseTimeId,
    });
typedef $$SupplyTransactionsTableUpdateCompanionBuilder =
    SupplyTransactionsCompanion Function({
      Value<int> id,
      Value<String> medId,
      Value<int> delta,
      Value<String> kind,
      Value<DateTime> createdAt,
      Value<String?> iso,
      Value<String?> doseTimeId,
    });

class $$SupplyTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $SupplyTransactionsTable> {
  $$SupplyTransactionsTableFilterComposer({
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

  ColumnFilters<String> get medId => $composableBuilder(
    column: $table.medId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get delta => $composableBuilder(
    column: $table.delta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iso => $composableBuilder(
    column: $table.iso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doseTimeId => $composableBuilder(
    column: $table.doseTimeId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SupplyTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplyTransactionsTable> {
  $$SupplyTransactionsTableOrderingComposer({
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

  ColumnOrderings<String> get medId => $composableBuilder(
    column: $table.medId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get delta => $composableBuilder(
    column: $table.delta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iso => $composableBuilder(
    column: $table.iso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doseTimeId => $composableBuilder(
    column: $table.doseTimeId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SupplyTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplyTransactionsTable> {
  $$SupplyTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medId =>
      $composableBuilder(column: $table.medId, builder: (column) => column);

  GeneratedColumn<int> get delta =>
      $composableBuilder(column: $table.delta, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get iso =>
      $composableBuilder(column: $table.iso, builder: (column) => column);

  GeneratedColumn<String> get doseTimeId => $composableBuilder(
    column: $table.doseTimeId,
    builder: (column) => column,
  );
}

class $$SupplyTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplyTransactionsTable,
          SupplyTransactionRow,
          $$SupplyTransactionsTableFilterComposer,
          $$SupplyTransactionsTableOrderingComposer,
          $$SupplyTransactionsTableAnnotationComposer,
          $$SupplyTransactionsTableCreateCompanionBuilder,
          $$SupplyTransactionsTableUpdateCompanionBuilder,
          (
            SupplyTransactionRow,
            BaseReferences<
              _$AppDatabase,
              $SupplyTransactionsTable,
              SupplyTransactionRow
            >,
          ),
          SupplyTransactionRow,
          PrefetchHooks Function()
        > {
  $$SupplyTransactionsTableTableManager(
    _$AppDatabase db,
    $SupplyTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplyTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SupplyTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SupplyTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> medId = const Value.absent(),
                Value<int> delta = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> iso = const Value.absent(),
                Value<String?> doseTimeId = const Value.absent(),
              }) => SupplyTransactionsCompanion(
                id: id,
                medId: medId,
                delta: delta,
                kind: kind,
                createdAt: createdAt,
                iso: iso,
                doseTimeId: doseTimeId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String medId,
                required int delta,
                required String kind,
                required DateTime createdAt,
                Value<String?> iso = const Value.absent(),
                Value<String?> doseTimeId = const Value.absent(),
              }) => SupplyTransactionsCompanion.insert(
                id: id,
                medId: medId,
                delta: delta,
                kind: kind,
                createdAt: createdAt,
                iso: iso,
                doseTimeId: doseTimeId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SupplyTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplyTransactionsTable,
      SupplyTransactionRow,
      $$SupplyTransactionsTableFilterComposer,
      $$SupplyTransactionsTableOrderingComposer,
      $$SupplyTransactionsTableAnnotationComposer,
      $$SupplyTransactionsTableCreateCompanionBuilder,
      $$SupplyTransactionsTableUpdateCompanionBuilder,
      (
        SupplyTransactionRow,
        BaseReferences<
          _$AppDatabase,
          $SupplyTransactionsTable,
          SupplyTransactionRow
        >,
      ),
      SupplyTransactionRow,
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
typedef $$MedicineRegistryEntriesTableCreateCompanionBuilder =
    MedicineRegistryEntriesCompanion Function({
      Value<int> id,
      required String name,
      required String genericName,
      required String form,
      required String searchText,
    });
typedef $$MedicineRegistryEntriesTableUpdateCompanionBuilder =
    MedicineRegistryEntriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> genericName,
      Value<String> form,
      Value<String> searchText,
    });

class $$MedicineRegistryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MedicineRegistryEntriesTable> {
  $$MedicineRegistryEntriesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genericName => $composableBuilder(
    column: $table.genericName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MedicineRegistryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicineRegistryEntriesTable> {
  $$MedicineRegistryEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genericName => $composableBuilder(
    column: $table.genericName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MedicineRegistryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicineRegistryEntriesTable> {
  $$MedicineRegistryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get genericName => $composableBuilder(
    column: $table.genericName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  GeneratedColumn<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => column,
  );
}

class $$MedicineRegistryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedicineRegistryEntriesTable,
          MedicineRegistryRow,
          $$MedicineRegistryEntriesTableFilterComposer,
          $$MedicineRegistryEntriesTableOrderingComposer,
          $$MedicineRegistryEntriesTableAnnotationComposer,
          $$MedicineRegistryEntriesTableCreateCompanionBuilder,
          $$MedicineRegistryEntriesTableUpdateCompanionBuilder,
          (
            MedicineRegistryRow,
            BaseReferences<
              _$AppDatabase,
              $MedicineRegistryEntriesTable,
              MedicineRegistryRow
            >,
          ),
          MedicineRegistryRow,
          PrefetchHooks Function()
        > {
  $$MedicineRegistryEntriesTableTableManager(
    _$AppDatabase db,
    $MedicineRegistryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicineRegistryEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MedicineRegistryEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MedicineRegistryEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> genericName = const Value.absent(),
                Value<String> form = const Value.absent(),
                Value<String> searchText = const Value.absent(),
              }) => MedicineRegistryEntriesCompanion(
                id: id,
                name: name,
                genericName: genericName,
                form: form,
                searchText: searchText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String genericName,
                required String form,
                required String searchText,
              }) => MedicineRegistryEntriesCompanion.insert(
                id: id,
                name: name,
                genericName: genericName,
                form: form,
                searchText: searchText,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MedicineRegistryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedicineRegistryEntriesTable,
      MedicineRegistryRow,
      $$MedicineRegistryEntriesTableFilterComposer,
      $$MedicineRegistryEntriesTableOrderingComposer,
      $$MedicineRegistryEntriesTableAnnotationComposer,
      $$MedicineRegistryEntriesTableCreateCompanionBuilder,
      $$MedicineRegistryEntriesTableUpdateCompanionBuilder,
      (
        MedicineRegistryRow,
        BaseReferences<
          _$AppDatabase,
          $MedicineRegistryEntriesTable,
          MedicineRegistryRow
        >,
      ),
      MedicineRegistryRow,
      PrefetchHooks Function()
    >;
typedef $$MedicineRegistryMetaTableCreateCompanionBuilder =
    MedicineRegistryMetaCompanion Function({
      Value<int> id,
      required String sourceName,
      required DateTime importedAt,
      required int entryCount,
    });
typedef $$MedicineRegistryMetaTableUpdateCompanionBuilder =
    MedicineRegistryMetaCompanion Function({
      Value<int> id,
      Value<String> sourceName,
      Value<DateTime> importedAt,
      Value<int> entryCount,
    });

class $$MedicineRegistryMetaTableFilterComposer
    extends Composer<_$AppDatabase, $MedicineRegistryMetaTable> {
  $$MedicineRegistryMetaTableFilterComposer({
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

  ColumnFilters<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entryCount => $composableBuilder(
    column: $table.entryCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MedicineRegistryMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicineRegistryMetaTable> {
  $$MedicineRegistryMetaTableOrderingComposer({
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

  ColumnOrderings<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entryCount => $composableBuilder(
    column: $table.entryCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MedicineRegistryMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicineRegistryMetaTable> {
  $$MedicineRegistryMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entryCount => $composableBuilder(
    column: $table.entryCount,
    builder: (column) => column,
  );
}

class $$MedicineRegistryMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedicineRegistryMetaTable,
          MedicineRegistryMetaRow,
          $$MedicineRegistryMetaTableFilterComposer,
          $$MedicineRegistryMetaTableOrderingComposer,
          $$MedicineRegistryMetaTableAnnotationComposer,
          $$MedicineRegistryMetaTableCreateCompanionBuilder,
          $$MedicineRegistryMetaTableUpdateCompanionBuilder,
          (
            MedicineRegistryMetaRow,
            BaseReferences<
              _$AppDatabase,
              $MedicineRegistryMetaTable,
              MedicineRegistryMetaRow
            >,
          ),
          MedicineRegistryMetaRow,
          PrefetchHooks Function()
        > {
  $$MedicineRegistryMetaTableTableManager(
    _$AppDatabase db,
    $MedicineRegistryMetaTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicineRegistryMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicineRegistryMetaTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MedicineRegistryMetaTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sourceName = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<int> entryCount = const Value.absent(),
              }) => MedicineRegistryMetaCompanion(
                id: id,
                sourceName: sourceName,
                importedAt: importedAt,
                entryCount: entryCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sourceName,
                required DateTime importedAt,
                required int entryCount,
              }) => MedicineRegistryMetaCompanion.insert(
                id: id,
                sourceName: sourceName,
                importedAt: importedAt,
                entryCount: entryCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MedicineRegistryMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedicineRegistryMetaTable,
      MedicineRegistryMetaRow,
      $$MedicineRegistryMetaTableFilterComposer,
      $$MedicineRegistryMetaTableOrderingComposer,
      $$MedicineRegistryMetaTableAnnotationComposer,
      $$MedicineRegistryMetaTableCreateCompanionBuilder,
      $$MedicineRegistryMetaTableUpdateCompanionBuilder,
      (
        MedicineRegistryMetaRow,
        BaseReferences<
          _$AppDatabase,
          $MedicineRegistryMetaTable,
          MedicineRegistryMetaRow
        >,
      ),
      MedicineRegistryMetaRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MedicinesTableTableManager get medicines =>
      $$MedicinesTableTableManager(_db, _db.medicines);
  $$DoseTimesTableTableManager get doseTimes =>
      $$DoseTimesTableTableManager(_db, _db.doseTimes);
  $$DoseLogTableTableManager get doseLog =>
      $$DoseLogTableTableManager(_db, _db.doseLog);
  $$SupplyTransactionsTableTableManager get supplyTransactions =>
      $$SupplyTransactionsTableTableManager(_db, _db.supplyTransactions);
  $$SettingsRowsTableTableManager get settingsRows =>
      $$SettingsRowsTableTableManager(_db, _db.settingsRows);
  $$NotifOffRowsTableTableManager get notifOffRows =>
      $$NotifOffRowsTableTableManager(_db, _db.notifOffRows);
  $$MedicineRegistryEntriesTableTableManager get medicineRegistryEntries =>
      $$MedicineRegistryEntriesTableTableManager(
        _db,
        _db.medicineRegistryEntries,
      );
  $$MedicineRegistryMetaTableTableManager get medicineRegistryMeta =>
      $$MedicineRegistryMetaTableTableManager(_db, _db.medicineRegistryMeta);
}
