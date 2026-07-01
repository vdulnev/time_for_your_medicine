// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dose_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DoseTime _$DoseTimeFromJson(Map<String, dynamic> json) => _DoseTime(
  id: json['id'] as String,
  time: json['time'] as String,
  period: $enumDecode(_$PeriodEnumMap, json['period']),
);

Map<String, dynamic> _$DoseTimeToJson(_DoseTime instance) => <String, dynamic>{
  'id': instance.id,
  'time': instance.time,
  'period': _$PeriodEnumMap[instance.period]!,
};

const _$PeriodEnumMap = {
  Period.morning: 'morning',
  Period.afternoon: 'afternoon',
  Period.evening: 'evening',
};
