// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Medicine _$MedicineFromJson(Map<String, dynamic> json) => _Medicine(
  id: json['id'] as String,
  name: json['name'] as String,
  dose: json['dose'] as String,
  times: (json['times'] as List<dynamic>)
      .map((e) => DoseTime.fromJson(e as Map<String, dynamic>))
      .toList(),
  withFood: json['withFood'] as bool,
  kind: $enumDecode(_$PillKindEnumMap, json['kind']),
  c1: (json['c1'] as num).toInt(),
  soft: (json['soft'] as num).toInt(),
  supply: (json['supply'] as num).toInt(),
  cap: (json['cap'] as num).toInt(),
  c2: (json['c2'] as num?)?.toInt(),
);

Map<String, dynamic> _$MedicineToJson(_Medicine instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'dose': instance.dose,
  'times': instance.times,
  'withFood': instance.withFood,
  'kind': _$PillKindEnumMap[instance.kind]!,
  'c1': instance.c1,
  'soft': instance.soft,
  'supply': instance.supply,
  'cap': instance.cap,
  'c2': instance.c2,
};

const _$PillKindEnumMap = {
  PillKind.capsule: 'capsule',
  PillKind.round: 'round',
};
