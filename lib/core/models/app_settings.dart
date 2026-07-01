import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

/// Preference toggles shown on the Settings screen.
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(true) bool sound,
    @Default(false) bool vibrate,
    @Default(true) bool refill,

    /// User-chosen language override ("en" / "uk"), or null to follow the
    /// device locale.
    String? localeOverride,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
