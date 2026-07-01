import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Pillpal'**
  String get appTitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @periodMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get periodMorning;

  /// No description provided for @periodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get periodAfternoon;

  /// No description provided for @periodEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get periodEvening;

  /// No description provided for @foodWithFood.
  ///
  /// In en, this message translates to:
  /// **'with food'**
  String get foodWithFood;

  /// No description provided for @foodEmptyStomach.
  ///
  /// In en, this message translates to:
  /// **'empty stomach'**
  String get foodEmptyStomach;

  /// No description provided for @foodWithFoodShort.
  ///
  /// In en, this message translates to:
  /// **'With'**
  String get foodWithFoodShort;

  /// No description provided for @foodEmptyStomachShort.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get foodEmptyStomachShort;

  /// No description provided for @foodWithFoodButton.
  ///
  /// In en, this message translates to:
  /// **'With food'**
  String get foodWithFoodButton;

  /// No description provided for @foodEmptyStomachButton.
  ///
  /// In en, this message translates to:
  /// **'Empty stomach'**
  String get foodEmptyStomachButton;

  /// No description provided for @kindCapsule.
  ///
  /// In en, this message translates to:
  /// **'capsule'**
  String get kindCapsule;

  /// No description provided for @kindTablet.
  ///
  /// In en, this message translates to:
  /// **'tablet'**
  String get kindTablet;

  /// No description provided for @kindCapsulesPlural.
  ///
  /// In en, this message translates to:
  /// **'capsules'**
  String get kindCapsulesPlural;

  /// No description provided for @kindTabletsPlural.
  ///
  /// In en, this message translates to:
  /// **'tablets'**
  String get kindTabletsPlural;

  /// No description provided for @medicineDoseAndFood.
  ///
  /// In en, this message translates to:
  /// **'{dose} · {food}'**
  String medicineDoseAndFood(String dose, String food);

  /// No description provided for @homeAllDosesTaken.
  ///
  /// In en, this message translates to:
  /// **'All doses taken'**
  String get homeAllDosesTaken;

  /// No description provided for @homeDosesLeftToday.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} dose left today} other{{count} doses left today}}'**
  String homeDosesLeftToday(int count);

  /// No description provided for @homeTapToSeeHistory.
  ///
  /// In en, this message translates to:
  /// **'Tap to see your history'**
  String get homeTapToSeeHistory;

  /// No description provided for @homePercentComplete.
  ///
  /// In en, this message translates to:
  /// **'{pct}% complete'**
  String homePercentComplete(int pct);

  /// No description provided for @homeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No medicines yet.\nTap + to add one.'**
  String get homeEmptyTitle;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navRefills.
  ///
  /// In en, this message translates to:
  /// **'Refills'**
  String get navRefills;

  /// No description provided for @navReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get navReminders;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get navCalendar;

  /// No description provided for @calendarReminderCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} reminder scheduled} other{{count} reminders scheduled}}'**
  String calendarReminderCount(int count);

  /// No description provided for @calendarOpenThisDay.
  ///
  /// In en, this message translates to:
  /// **'Open this day'**
  String get calendarOpenThisDay;

  /// No description provided for @calendarDateHeading.
  ///
  /// In en, this message translates to:
  /// **'{weekday}, {date}'**
  String calendarDateHeading(String weekday, String date);

  /// No description provided for @addTitle.
  ///
  /// In en, this message translates to:
  /// **'Add medicine'**
  String get addTitle;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'add photo'**
  String get addPhoto;

  /// No description provided for @addMedicineNameLabel.
  ///
  /// In en, this message translates to:
  /// **'MEDICINE NAME'**
  String get addMedicineNameLabel;

  /// No description provided for @addMedicineNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Amoxicillin'**
  String get addMedicineNameHint;

  /// No description provided for @registryNoResults.
  ///
  /// In en, this message translates to:
  /// **'No registry matches'**
  String get registryNoResults;

  /// No description provided for @registrySearchFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t search the medicine registry'**
  String get registrySearchFailed;

  /// No description provided for @addDoseLabel.
  ///
  /// In en, this message translates to:
  /// **'DOSE'**
  String get addDoseLabel;

  /// No description provided for @addDoseHint.
  ///
  /// In en, this message translates to:
  /// **'500 mg'**
  String get addDoseHint;

  /// No description provided for @addTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get addTimeLabel;

  /// No description provided for @addTimeHint.
  ///
  /// In en, this message translates to:
  /// **'8:00 AM'**
  String get addTimeHint;

  /// No description provided for @addTimeOfDayLabel.
  ///
  /// In en, this message translates to:
  /// **'TIME OF DAY'**
  String get addTimeOfDayLabel;

  /// No description provided for @addFoodLabel.
  ///
  /// In en, this message translates to:
  /// **'FOOD'**
  String get addFoodLabel;

  /// No description provided for @addSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save medicine'**
  String get addSaveButton;

  /// No description provided for @detailNext.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get detailNext;

  /// No description provided for @detailFood.
  ///
  /// In en, this message translates to:
  /// **'FOOD'**
  String get detailFood;

  /// No description provided for @detailLeft.
  ///
  /// In en, this message translates to:
  /// **'LEFT'**
  String get detailLeft;

  /// No description provided for @detailLast7Days.
  ///
  /// In en, this message translates to:
  /// **'LAST 7 DAYS'**
  String get detailLast7Days;

  /// No description provided for @detailMarkAsTaken.
  ///
  /// In en, this message translates to:
  /// **'Mark as taken'**
  String get detailMarkAsTaken;

  /// No description provided for @detailTakenToday.
  ///
  /// In en, this message translates to:
  /// **'Taken today ✓'**
  String get detailTakenToday;

  /// No description provided for @detailDoseAndKind.
  ///
  /// In en, this message translates to:
  /// **'{dose} {kind}'**
  String detailDoseAndKind(String dose, String kind);

  /// No description provided for @deleteSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete reminder?'**
  String get deleteSheetTitle;

  /// No description provided for @deleteSheetBody.
  ///
  /// In en, this message translates to:
  /// **'{name} and its schedule will be removed. This can’t be undone.'**
  String deleteSheetBody(String name);

  /// No description provided for @doneAllDone.
  ///
  /// In en, this message translates to:
  /// **'All done!'**
  String get doneAllDone;

  /// No description provided for @doneBody.
  ///
  /// In en, this message translates to:
  /// **'Every medicine taken for {date}.\nKeep that streak going.'**
  String doneBody(String date);

  /// No description provided for @doneDosesLabel.
  ///
  /// In en, this message translates to:
  /// **'doses'**
  String get doneDosesLabel;

  /// No description provided for @doneStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get doneStreakLabel;

  /// No description provided for @doneViewTomorrow.
  ///
  /// In en, this message translates to:
  /// **'View tomorrow'**
  String get doneViewTomorrow;

  /// No description provided for @doneBackToToday.
  ///
  /// In en, this message translates to:
  /// **'Back to today'**
  String get doneBackToToday;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @historyAdherence7Day.
  ///
  /// In en, this message translates to:
  /// **'7-day adherence'**
  String get historyAdherence7Day;

  /// No description provided for @historyAdherencePct.
  ///
  /// In en, this message translates to:
  /// **'{pct}%'**
  String historyAdherencePct(int pct);

  /// No description provided for @historyExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent — keep it up'**
  String get historyExcellent;

  /// No description provided for @historyRoomToImprove.
  ///
  /// In en, this message translates to:
  /// **'Room to improve'**
  String get historyRoomToImprove;

  /// No description provided for @historyDosesTaken.
  ///
  /// In en, this message translates to:
  /// **'Doses taken'**
  String get historyDosesTaken;

  /// No description provided for @historyDaysOfSeven.
  ///
  /// In en, this message translates to:
  /// **'{count} / 7 days'**
  String historyDaysOfSeven(int count);

  /// No description provided for @historyCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get historyCurrentStreak;

  /// No description provided for @historyStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day} other{{count} days}}'**
  String historyStreakDays(int count);

  /// No description provided for @historyBestTime.
  ///
  /// In en, this message translates to:
  /// **'Best time'**
  String get historyBestTime;

  /// No description provided for @refillsTitle.
  ///
  /// In en, this message translates to:
  /// **'Refills'**
  String get refillsTitle;

  /// No description provided for @refillsMedicineIsLow.
  ///
  /// In en, this message translates to:
  /// **'{name} is low'**
  String refillsMedicineIsLow(String name);

  /// No description provided for @refillsAllHealthy.
  ///
  /// In en, this message translates to:
  /// **'All supplies healthy'**
  String get refillsAllHealthy;

  /// No description provided for @refillsRunningLow.
  ///
  /// In en, this message translates to:
  /// **'Running low — order soon'**
  String get refillsRunningLow;

  /// No description provided for @refillsCapsulesLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} capsule left} other{{count} capsules left}}'**
  String refillsCapsulesLeft(int count);

  /// No description provided for @refillsTabletsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} tablet left} other{{count} tablets left}}'**
  String refillsTabletsLeft(int count);

  /// No description provided for @refillsOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get refillsOrder;

  /// No description provided for @remindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get remindersTitle;

  /// No description provided for @remindersToday.
  ///
  /// In en, this message translates to:
  /// **'Today · {date}'**
  String remindersToday(String date);

  /// No description provided for @remindersTimeAndDetail.
  ///
  /// In en, this message translates to:
  /// **'{time} · {detail}'**
  String remindersTimeAndDetail(String time, String detail);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsActiveMedicines.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} active medicine} other{{count} active medicines}}'**
  String settingsActiveMedicines(int count);

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get settingsPreferences;

  /// No description provided for @settingsReminderSound.
  ///
  /// In en, this message translates to:
  /// **'Reminder sound'**
  String get settingsReminderSound;

  /// No description provided for @settingsVibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get settingsVibration;

  /// No description provided for @settingsRefillAlerts.
  ///
  /// In en, this message translates to:
  /// **'Refill alerts'**
  String get settingsRefillAlerts;

  /// No description provided for @settingsMore.
  ///
  /// In en, this message translates to:
  /// **'MORE'**
  String get settingsMore;

  /// No description provided for @settingsHistoryAndAdherence.
  ///
  /// In en, this message translates to:
  /// **'History & adherence'**
  String get settingsHistoryAndAdherence;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageUkrainian.
  ///
  /// In en, this message translates to:
  /// **'Українська'**
  String get settingsLanguageUkrainian;

  /// No description provided for @settingsMedicineRegistry.
  ///
  /// In en, this message translates to:
  /// **'MEDICINE REGISTRY'**
  String get settingsMedicineRegistry;

  /// No description provided for @registryTitle.
  ///
  /// In en, this message translates to:
  /// **'Registered medicines'**
  String get registryTitle;

  /// No description provided for @registryPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing medicine list…'**
  String get registryPreparing;

  /// No description provided for @registryEntryCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} medicine} other{{count} medicines}}'**
  String registryEntryCount(int count);

  /// No description provided for @registryImportButton.
  ///
  /// In en, this message translates to:
  /// **'Import CSV'**
  String get registryImportButton;

  /// No description provided for @registryImportSuccess.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} medicine imported} other{{count} medicines imported}}'**
  String registryImportSuccess(int count);

  /// No description provided for @registryImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t import this file'**
  String get registryImportFailed;

  /// No description provided for @registryImportInvalidFile.
  ///
  /// In en, this message translates to:
  /// **'This isn’t a supported medicine registry CSV.'**
  String get registryImportInvalidFile;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found: {id}'**
  String errorNotFound(String id);

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong: {error}'**
  String errorUnknown(String error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
