// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pillpal';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get ok => 'OK';

  @override
  String get periodMorning => 'Morning';

  @override
  String get periodAfternoon => 'Afternoon';

  @override
  String get periodEvening => 'Evening';

  @override
  String get foodWithFood => 'with food';

  @override
  String get foodEmptyStomach => 'empty stomach';

  @override
  String get foodWithFoodShort => 'With';

  @override
  String get foodEmptyStomachShort => 'Empty';

  @override
  String get foodWithFoodButton => 'With food';

  @override
  String get foodEmptyStomachButton => 'Empty stomach';

  @override
  String get kindCapsule => 'capsule';

  @override
  String get kindTablet => 'tablet';

  @override
  String get kindCapsulesPlural => 'capsules';

  @override
  String get kindTabletsPlural => 'tablets';

  @override
  String medicineDoseAndFood(String dose, String food) {
    return '$dose · $food';
  }

  @override
  String get homeAllDosesTaken => 'All doses taken';

  @override
  String homeDosesLeftToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count doses left today',
      one: '$count dose left today',
    );
    return '$_temp0';
  }

  @override
  String get homeTapToSeeHistory => 'Tap to see your history';

  @override
  String homePercentComplete(int pct) {
    return '$pct% complete';
  }

  @override
  String get homeEmptyTitle => 'No medicines yet.\nTap + to add one.';

  @override
  String get navHistory => 'History';

  @override
  String get navRefills => 'Refills';

  @override
  String get navReminders => 'Reminders';

  @override
  String get navSettings => 'Settings';

  @override
  String get navCalendar => 'Calendar';

  @override
  String calendarReminderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reminders scheduled',
      one: '$count reminder scheduled',
    );
    return '$_temp0';
  }

  @override
  String get calendarOpenThisDay => 'Open this day';

  @override
  String calendarDateHeading(String weekday, String date) {
    return '$weekday, $date';
  }

  @override
  String get addTitle => 'Add medicine';

  @override
  String get addPhoto => 'add photo';

  @override
  String get addMedicineNameLabel => 'MEDICINE NAME';

  @override
  String get addMedicineNameHint => 'e.g. Amoxicillin';

  @override
  String get addDoseLabel => 'DOSE';

  @override
  String get addDoseHint => '500 mg';

  @override
  String get addTimeLabel => 'TIME';

  @override
  String get addTimeHint => '8:00 AM';

  @override
  String get addTimeOfDayLabel => 'TIME OF DAY';

  @override
  String get addFoodLabel => 'FOOD';

  @override
  String get addSaveButton => 'Save medicine';

  @override
  String get detailNext => 'NEXT';

  @override
  String get detailFood => 'FOOD';

  @override
  String get detailLeft => 'LEFT';

  @override
  String get detailLast7Days => 'LAST 7 DAYS';

  @override
  String get detailMarkAsTaken => 'Mark as taken';

  @override
  String get detailTakenToday => 'Taken today ✓';

  @override
  String detailDoseAndKind(String dose, String kind) {
    return '$dose $kind';
  }

  @override
  String get deleteSheetTitle => 'Delete reminder?';

  @override
  String deleteSheetBody(String name) {
    return '$name and its schedule will be removed. This can’t be undone.';
  }

  @override
  String get doneAllDone => 'All done!';

  @override
  String doneBody(String date) {
    return 'Every medicine taken for $date.\nKeep that streak going.';
  }

  @override
  String get doneDosesLabel => 'doses';

  @override
  String get doneStreakLabel => 'day streak';

  @override
  String get doneViewTomorrow => 'View tomorrow';

  @override
  String get doneBackToToday => 'Back to today';

  @override
  String get historyTitle => 'History';

  @override
  String get historyAdherence7Day => '7-day adherence';

  @override
  String historyAdherencePct(int pct) {
    return '$pct%';
  }

  @override
  String get historyExcellent => 'Excellent — keep it up';

  @override
  String get historyRoomToImprove => 'Room to improve';

  @override
  String get historyDosesTaken => 'Doses taken';

  @override
  String historyDaysOfSeven(int count) {
    return '$count / 7 days';
  }

  @override
  String get historyCurrentStreak => 'Current streak';

  @override
  String historyStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String get historyBestTime => 'Best time';

  @override
  String get refillsTitle => 'Refills';

  @override
  String refillsMedicineIsLow(String name) {
    return '$name is low';
  }

  @override
  String get refillsAllHealthy => 'All supplies healthy';

  @override
  String get refillsRunningLow => 'Running low — order soon';

  @override
  String refillsCapsulesLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count capsules left',
      one: '$count capsule left',
    );
    return '$_temp0';
  }

  @override
  String refillsTabletsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tablets left',
      one: '$count tablet left',
    );
    return '$_temp0';
  }

  @override
  String get refillsOrder => 'Order';

  @override
  String get remindersTitle => 'Reminders';

  @override
  String remindersToday(String date) {
    return 'Today · $date';
  }

  @override
  String remindersTimeAndDetail(String time, String detail) {
    return '$time · $detail';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String settingsActiveMedicines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count active medicines',
      one: '$count active medicine',
    );
    return '$_temp0';
  }

  @override
  String get settingsPreferences => 'PREFERENCES';

  @override
  String get settingsReminderSound => 'Reminder sound';

  @override
  String get settingsVibration => 'Vibration';

  @override
  String get settingsRefillAlerts => 'Refill alerts';

  @override
  String get settingsMore => 'MORE';

  @override
  String get settingsHistoryAndAdherence => 'History & adherence';

  @override
  String get settingsLanguage => 'LANGUAGE';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageUkrainian => 'Українська';

  @override
  String errorNotFound(String id) {
    return 'Not found: $id';
  }

  @override
  String errorUnknown(String error) {
    return 'Something went wrong: $error';
  }
}
