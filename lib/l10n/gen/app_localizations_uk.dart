// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Pillpal';

  @override
  String get retry => 'Повторити';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get ok => 'Гаразд';

  @override
  String get periodMorning => 'Ранок';

  @override
  String get periodAfternoon => 'День';

  @override
  String get periodEvening => 'Вечір';

  @override
  String get foodWithFood => 'з їжею';

  @override
  String get foodEmptyStomach => 'натщесерце';

  @override
  String get foodWithFoodShort => 'З їжею';

  @override
  String get foodEmptyStomachShort => 'Натщесерце';

  @override
  String get foodWithFoodButton => 'З їжею';

  @override
  String get foodEmptyStomachButton => 'Натщесерце';

  @override
  String get kindCapsule => 'капсула';

  @override
  String get kindTablet => 'таблетка';

  @override
  String get kindCapsulesPlural => 'капсули';

  @override
  String get kindTabletsPlural => 'таблетки';

  @override
  String medicineDoseAndFood(String dose, String food) {
    return '$dose · $food';
  }

  @override
  String get homeAllDosesTaken => 'Усі ліки прийнято';

  @override
  String homeDosesLeftToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Залишилось $count прийому сьогодні',
      many: 'Залишилось $count прийомів сьогодні',
      few: 'Залишилось $count прийоми сьогодні',
      one: 'Залишився $count прийом сьогодні',
    );
    return '$_temp0';
  }

  @override
  String get homeTapToSeeHistory => 'Натисніть, щоб переглянути історію';

  @override
  String homePercentComplete(int pct) {
    return 'Виконано $pct%';
  }

  @override
  String get homeEmptyTitle => 'Ще немає ліків.\nНатисніть +, щоб додати.';

  @override
  String get navHistory => 'Історія';

  @override
  String get navRefills => 'Поповнення';

  @override
  String get navReminders => 'Нагадування';

  @override
  String get navSettings => 'Налаштування';

  @override
  String get navCalendar => 'Календар';

  @override
  String calendarReminderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Заплановано $count нагадування',
      many: 'Заплановано $count нагадувань',
      few: 'Заплановано $count нагадування',
      one: 'Заплановано $count нагадування',
    );
    return '$_temp0';
  }

  @override
  String get calendarOpenThisDay => 'Відкрити цей день';

  @override
  String calendarDateHeading(String weekday, String date) {
    return '$weekday, $date';
  }

  @override
  String get addTitle => 'Додати ліки';

  @override
  String get addPhoto => 'додати фото';

  @override
  String get addMedicineNameLabel => 'НАЗВА ЛІКІВ';

  @override
  String get addMedicineNameHint => 'напр. Амоксицилін';

  @override
  String get registryNoResults => 'У реєстрі нічого не знайдено';

  @override
  String get registrySearchFailed => 'Не вдалося виконати пошук у реєстрі';

  @override
  String get addDoseLabel => 'ДОЗА';

  @override
  String get addDoseHint => '500 мг';

  @override
  String get addTimeLabel => 'ЧАС';

  @override
  String get addTimeHint => '08:00';

  @override
  String get addTimeOfDayLabel => 'ЧАС ДОБИ';

  @override
  String get addAnotherTime => 'Додати ще один час';

  @override
  String get addFoodLabel => 'ЇЖА';

  @override
  String get addSaveButton => 'Зберегти ліки';

  @override
  String get detailNext => 'НАСТУПНИЙ';

  @override
  String get detailFood => 'ЇЖА';

  @override
  String get detailLeft => 'ЗАЛИШИЛОСЬ';

  @override
  String get detailLast7Days => 'ОСТАННІ 7 ДНІВ';

  @override
  String get detailTodaysDoses => 'ПРИЙОМИ СЬОГОДНІ';

  @override
  String get detailMarkAsTaken => 'Позначити як прийнято';

  @override
  String get detailTakenToday => 'Прийнято сьогодні ✓';

  @override
  String detailDoseAndKind(String dose, String kind) {
    return '$dose, $kind';
  }

  @override
  String get deleteSheetTitle => 'Видалити нагадування?';

  @override
  String deleteSheetBody(String name) {
    return '«$name» та його розклад буде видалено. Цю дію не можна скасувати.';
  }

  @override
  String get doneAllDone => 'Усе зроблено!';

  @override
  String doneBody(String date) {
    return 'Усі ліки прийнято за $date.\nПродовжуйте серію!';
  }

  @override
  String get doneDosesLabel => 'прийомів';

  @override
  String get doneStreakLabel => 'днів поспіль';

  @override
  String get doneViewTomorrow => 'Переглянути завтра';

  @override
  String get doneBackToToday => 'Повернутись до сьогодні';

  @override
  String get historyTitle => 'Історія';

  @override
  String get historyAdherence7Day => 'Дотримання за 7 днів';

  @override
  String historyAdherencePct(int pct) {
    return '$pct%';
  }

  @override
  String get historyExcellent => 'Чудово — так тримати';

  @override
  String get historyRoomToImprove => 'Є куди рости';

  @override
  String get historyDosesTaken => 'Прийнято ліків';

  @override
  String historyDaysOfSeven(int count) {
    return '$count / 7 днів';
  }

  @override
  String get historyCurrentStreak => 'Поточна серія';

  @override
  String historyStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count днів',
      few: '$count дні',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String get historyBestTime => 'Найкращий час';

  @override
  String get refillsTitle => 'Поповнення';

  @override
  String refillsMedicineIsLow(String name) {
    return '$name закінчується';
  }

  @override
  String get refillsAllHealthy => 'Усіх ліків достатньо';

  @override
  String get refillsRunningLow => 'Запас закінчується — замовте незабаром';

  @override
  String refillsCapsulesLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Залишилось $count капсули',
      many: 'Залишилось $count капсул',
      few: 'Залишилось $count капсули',
      one: 'Залишилась $count капсула',
    );
    return '$_temp0';
  }

  @override
  String refillsTabletsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Залишилось $count таблетки',
      many: 'Залишилось $count таблеток',
      few: 'Залишилось $count таблетки',
      one: 'Залишилась $count таблетка',
    );
    return '$_temp0';
  }

  @override
  String get refillsOrder => 'Замовити';

  @override
  String get remindersTitle => 'Нагадування';

  @override
  String remindersToday(String date) {
    return 'Сьогодні · $date';
  }

  @override
  String remindersTimeAndDetail(String time, String detail) {
    return '$time · $detail';
  }

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String settingsActiveMedicines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count активного препарату',
      many: '$count активних препаратів',
      few: '$count активні препарати',
      one: '$count активний препарат',
    );
    return '$_temp0';
  }

  @override
  String get settingsPreferences => 'ПЕРЕВАГИ';

  @override
  String get settingsReminderSound => 'Звук нагадування';

  @override
  String get settingsVibration => 'Вібрація';

  @override
  String get settingsRefillAlerts => 'Сповіщення про поповнення';

  @override
  String get settingsMore => 'ІНШЕ';

  @override
  String get settingsHistoryAndAdherence => 'Історія та дотримання';

  @override
  String get settingsLanguage => 'МОВА';

  @override
  String get settingsLanguageSystem => 'Системна';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageUkrainian => 'Українська';

  @override
  String get settingsMedicineRegistry => 'РЕЄСТР ЛІКІВ';

  @override
  String get registryTitle => 'Зареєстровані ліки';

  @override
  String get registryPreparing => 'Підготовка списку ліків…';

  @override
  String registryEntryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count препарату',
      many: '$count препаратів',
      few: '$count препарати',
      one: '$count препарат',
    );
    return '$_temp0';
  }

  @override
  String get registryImportButton => 'Імпорт CSV';

  @override
  String registryImportSuccess(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Імпортовано $count препарату',
      many: 'Імпортовано $count препаратів',
      few: 'Імпортовано $count препарати',
      one: 'Імпортовано $count препарат',
    );
    return '$_temp0';
  }

  @override
  String get registryImportFailed => 'Не вдалося імпортувати цей файл';

  @override
  String get registryImportInvalidFile =>
      'Цей CSV-файл не є підтримуваним реєстром ліків.';

  @override
  String errorNotFound(String id) {
    return 'Не знайдено: $id';
  }

  @override
  String errorUnknown(String error) {
    return 'Щось пішло не так: $error';
  }
}
