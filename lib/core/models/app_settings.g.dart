// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => _AppSettings(
  sound: json['sound'] as bool? ?? true,
  vibrate: json['vibrate'] as bool? ?? false,
  refill: json['refill'] as bool? ?? true,
);

Map<String, dynamic> _$AppSettingsToJson(_AppSettings instance) =>
    <String, dynamic>{
      'sound': instance.sound,
      'vibrate': instance.vibrate,
      'refill': instance.refill,
    };
