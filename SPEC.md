# Pillnote — Medicine Reminder · Flutter Implementation Spec

Flutter implementation of the **Pillnote** medicine-reminder app, recreated
pixel-faithfully from the Claude Design handoff
(`medicine-reminder-app-design/project/Medicine Reminder.dc.html`).

**Version:** 0.1.0
**Status:** In development

> This spec is the source of truth for the build and is updated as work
> progresses. See §11 Changelog.

---

## 0. Dart rules (project-wide)

- Never use the null-assertion operator (`!`).
- Never use `dynamic` — be explicit.
- Trailing commas in all widget constructors; prefer `const`.
- One public widget per file; feature-first folders.
- Keep business logic out of widgets — all state lives in Riverpod.
- `ConsumerStatefulWidget` only for widget-lifecycle concerns
  (controllers, focus nodes, animation controllers).
- **Models are Freezed** (`@freezed`) with `json_serializable` for any
  DTO / persisted shape; enums stay plain enums.
- **Repositories return `Either<AppException, T>`** (fpdart). No
  try/catch in notifiers — fold the `Either` inside `AsyncValue.guard`.
- **Navigation is auto_route** — no imperative screen enum. Use typed
  routes; pass ids as route args (e.g. `DetailRoute(medId: …)`).
- **DI via Riverpod providers** — `databaseProvider`,
  `medicineRepositoryProvider`, `talkerProvider`; the SQLite/prefs
  handles are `overrideWith` in `main()`.
- **Log through the single Talker instance** — DB writes, errors, and
  provider transitions (`TalkerRiverpodObserver`).
- **No hardcoded user-facing strings.** All chrome text goes through
  `AppLocalizations` (see §1a); `Selectors`/`DayUtils` stay
  locale-agnostic pure functions — pass a `String locale` in, never a
  `BuildContext`, and never bake in an English string to return.
- Run `dart run build_runner build --delete-conflicting-outputs` after
  changing any Freezed / drift / auto_route / json annotation. Run
  `flutter gen-l10n` after changing an ARB file.
- Run `dart format .`, then `flutter analyze` (zero warnings), then
  `flutter test` before considering a task done.
- **Never run `git commit` or `git push` unless the user directly asks
  for it in that turn.** Finishing a feature/fix is not an implicit
  request to commit — leave the working tree as-is and let the user
  review the diff first.

---

## 1. Tech Stack

| Concern | Choice | Notes |
|---|---|---|
| Language | Dart ≥ 3.11 | null-safe, records, patterns |
| Framework | Flutter (stable) | Material 3 |
| State management | **Riverpod** (`flutter_riverpod`) | `AsyncNotifier` for loaded state |
| DI / service location | **Riverpod providers** | database, repository, Talker injected via providers + `ProviderScope` overrides |
| Routing | **auto_route** (`auto_route` + `auto_route_generator`) | code-gen typed routes; `AutoTabsScaffold` for the bottom-nav shell |
| Functional errors | **fpdart** | `Either<AppException, T>` at the repository boundary |
| Models / unions | **Freezed 3** + `json_serializable` | sealed classes for state + DTOs |
| Local DB | **drift** + **drift_flutter** (SQLite) | medicines, dose log, settings |
| Logging | **Talker** (`talker_flutter` + `talker_riverpod_logger`) | single instance via provider; Riverpod observer |
| Fonts | `google_fonts` | Bricolage Grotesque + Plus Jakarta Sans |

Code generation (`build_runner`) drives Freezed models, drift tables,
auto_route routes, and json_serializable. Generated files
(`*.g.dart`, `*.freezed.dart`, `*.gr.dart`) are committed.

## 1a. Localization (English + Ukrainian)

Standard Flutter `flutter_localizations` + ARB pipeline (`flutter
gen-l10n`, config in `l10n.yaml`), **not** a hand-rolled solution —
picked because it composes with `intl`'s CLDR plural/date data instead
of reimplementing it.

- Source of truth: `lib/l10n/app_en.arb` (English) and
  `lib/l10n/app_uk.arb` (Ukrainian). Generated output
  (`lib/l10n/gen/app_localizations*.dart`) is committed like the other
  codegen.
- **Locale resolves from the device, with a Ukrainian fallback.** No
  in-app language switcher. `MaterialApp.router` sets
  `localeListResolutionCallback: resolveLocale`
  (`lib/l10n/locale_resolution.dart`) instead of Flutter's default
  resolution: a device set to English or Ukrainian shows as-is: any
  other device language falls back to **Ukrainian**, not Flutter's
  built-in default (the first entry in `supportedLocales`, which would
  otherwise be English). Pure function, unit-tested directly in
  `test/locale_resolution_test.dart` — no widget pump needed.
- Access pattern: `context.l10n.someKey` (extension in
  `lib/l10n/l10n_extensions.dart`), not
  `AppLocalizations.of(context)` directly.
- **Plurals use ICU `{count, plural, ...}` syntax with all four
  Ukrainian categories** (`one`/`few`/`many`/`other` — Ukrainian's
  count-based noun/verb agreement doesn't collapse to English's
  one/other). Getting a category wrong reads as broken grammar, not a
  crash, so it won't show up in `flutter analyze`; verify plural
  strings against real CLDR rules, not by translating the English
  singular/plural pair.
- **Dates/weekdays/months** go through `DayUtils`, which wraps
  `package:intl`'s `DateFormat` with a `String locale` parameter — no
  hardcoded month/weekday name tables. Exception: the compact
  Mon…Sun weekday glyph (`DayUtils.dowNarrow`) uses CLDR's narrow
  (`EEEEE`) format for English, but a **hardcoded 2-letter table for
  Ukrainian** — CLDR's narrow Cyrillic form collapses to a single
  ambiguous letter (Пн/Пт both → "П", Ср/Сб both → "С"), which is a
  real UX defect only visible by rendering it, not by reading the code.
- **`Period` enum and `AppException` carry no display strings.**
  `Period.label(l10n)` and `AppException.message(l10n)` are extensions
  in `l10n_extensions.dart` that take the localizations object — the
  enum/exception classes themselves stay locale-agnostic.
- `Selectors` (`lib/core/state/selectors.dart`) returns raw data
  (counts, percentages, booleans) — it does **not** format English
  sentences. Widgets format text via `context.l10n` at the point of
  display. This was a refactor partway through adding Ukrainian: the
  original `DoseProgress.title`/`.subtitle`,
  `HistorySummary.subtitle`, and `RefillItem.countLabel` getters baked
  in hardcoded English and had no way to accept a `BuildContext`.
- User-entered free text (medicine `name`, `dose`, `time` fields) is
  **not** translated — it's user data, not app chrome.

There is **no network layer** (no Dio/Retrofit) — Pillnote is local-only.

### Target platforms
iOS, Android (single portrait phone layout — the design is phone-only).

---

## 2. Project Structure

```
lib/
  main.dart              # bootstrap: open DB, build Talker, ProviderScope overrides
  app.dart               # MaterialApp.router + theme
  core/
    theme/               # app_colors / app_text_styles / app_theme
    error/
      app_exception.dart # @freezed sealed AppException union
    logging/
      talker.dart        # talkerProvider (single instance)
    db/
      app_database.dart  # @DriftDatabase — Medicines / DoseLog / SettingsRow
    models/              # @freezed: medicine, app_settings, add_draft
      period.dart, pill_kind.dart   # plain enums
    data/
      medicine_repository.dart  # Either<AppException,T> over drift
    state/
      data_state.dart    # @freezed DataState (meds, taken, settings, notifOff)
      data_notifier.dart # AsyncNotifier<DataState> — mutations via repo
      error_notifier.dart # Notifier<AppException?> — surfaces failed writes (see §7a)
      ui_providers.dart  # selectedDayProvider, calendarMonthProvider
      selectors.dart     # pure derivations for widgets
    router/
      app_router.dart    # @AutoRouterConfig
      guards.dart        # (none needed for v1)
    util/
      day_utils.dart
    widgets/             # shared: pill_shape, error_view
  features/
    home/     home_page.dart (@RoutePage) + widgets/
    calendar/ calendar_page.dart + widgets/
    add/      add_medicine_page.dart
    detail/   medicine_detail_page.dart
    done/     done_page.dart
    history/  history_page.dart
    refills/  refills_page.dart
    reminders/reminders_page.dart
    settings/ settings_page.dart
    shell/    dashboard_page.dart (AutoTabsScaffold), bottom_nav_bar.dart,
              delete_dialog.dart
```

---

## 3. Design Tokens

### Colors
| Token | Hex | Use |
|---|---|---|
| primary | `#5566D6` | brand, active, CTAs |
| appBg | `#EDEAF3` | outer background |
| screenBg | `#FCFBFE` | screen background |
| ink | `#28253D` | primary text |
| ink2 | `#52507A` | secondary icon/text |
| muted | `#807CA0` | labels |
| muted2 | `#A6A2C0` | subtext |
| muted3 | `#B6B2CC` | chevrons |
| surface | `#F4F3FB` | inset fields/cards |
| surface2 | `#F0EEF8` | icon buttons |
| surfaceIndigo | `#E7E8FB` | accent chips |
| card | `#FFFFFF` | elevated cards |
| danger | `#D9533A` | delete |
| success | `#3E9C73` | ok pills |
| successDot | `#5BAE8A` | detail week done |

### Period accents
| Period | accent | bg |
|---|---|---|
| morning | `#D69A5A` | `#FBF0DF` |
| afternoon | `#5AA0D6` | `#E2F0F8` |
| evening | `#A77FD0` | `#F1ECF9` |

### Typography
- **Bricolage Grotesque** — headings/numbers (w500–w800).
- **Plus Jakarta Sans** — body/labels (w400–w800).
Sizes taken per-widget from the prototype (e.g. date 22/w800 Bricolage,
med name 14/w700 Jakarta, section label 13/w700 Bricolage).

### Card shadow
`0 4px 14px -5px rgba(60,55,90,.12)` → approximated with `BoxShadow`.

### App icon

The launcher icon on both platforms is the same brand mark as the
splash screens: a white circle holding the two-tone capsule
(`PillShape` / `ic_splash_pill.xml`) on an `AppColors.primary`
background, replacing the default `flutter create` template icon
(previously the generic Flutter mascot on both platforms).

Neither platform's icon pipeline accepts a single vector source across
the board — iOS's asset catalog is PNG-only, and even Android's
vector-capable adaptive icon (API 26+) still needs flat raster PNGs as
a fallback for older devices — so a master 1024×1024 PNG was rendered
once with CoreGraphics (`swift` script using `CGContext`, matching the
splash's exact geometry: circle radius 320, capsule 480×96 rotated
-28°) and downscaled per platform with `sips`, rather than reaching
for a third-party asset-generation package for a one-off image.

- **iOS** (`ios/Runner/Assets.xcassets/AppIcon.appiconset/`): all 15
  sizes listed in `Contents.json` (20–1024px) generated from the
  master PNG; verified each has no alpha channel (a flat, fully
  opaque background is required for the App Store).
- **Android legacy** (`mipmap-mdpi/hdpi/xhdpi/xxhdpi/xxxhdpi/ic_launcher.png`,
  48–192px): same master PNG downscaled, for pre-API-26 devices that
  don't understand adaptive icons.
- **Android adaptive icon** (API 26+): pure vector, no raster needed —
  `mipmap-anydpi-v26/ic_launcher.xml` composites a
  `@color/splashBackground` background with
  `drawable/ic_launcher_foreground.xml` (the same circle+capsule mark,
  re-derived at a 108dp viewport with content kept inside the 66dp
  safe-zone circle so it survives every launcher's mask shape —
  circle, squircle, rounded square).

---

## 4. Data Model

Plain enums: `Period {morning,afternoon,evening}` (label/accent/bg
metadata), `PillKind {capsule,round}`.

Freezed models (`@freezed`, with `json_serializable`):

```
@freezed DoseTime   { id, time, period }               // one scheduled slot
@freezed Medicine   { id, name, dose, List<DoseTime> times, withFood, kind,
                      c1, int? c2, soft, supply, cap }  // colors as ARGB ints
@freezed AppSettings{ bool sound, vibrate, refill, String? localeOverride }
@freezed DraftTime  { time, period }                    // one editable slot
@freezed AddDraft   { name, dose, List<DraftTime> times, withFood }
@freezed DataState  { List<Medicine> meds, Map<String,bool> taken,
                      AppSettings settings, Map<String,bool> notifOff }
```

A medicine can be scheduled **several times a day** — `Medicine.times` is a
non-empty, ordered list of `DoseTime`, each with its own display time and
`Period`. The Add form lets the user add/remove time slots freely (min 1);
empty slots are dropped on save.

`taken` is keyed `"iso|medId|doseTimeId"` — each dose slot is tracked and
toggled independently, so a 3x/day medicine contributes 3 separate,
independently-completable entries per day. `Selectors._occurrences`
flattens `DataState` into `DoseOccurrence { med, doseTime }` pairs; every
selector that used to count/group by medicine (progress, day agenda,
history, streak, calendar reminder count) now counts/groups by occurrence
instead. `DataState.allTaken(iso)` is true only when every slot of every
medicine is taken. Widgets show a slot's time next to the medicine name
whenever `med.times.length > 1`, to disambiguate multiple rows for the same
medicine (Home tiles, Detail's "today's doses" list, Reminders subtitle).

`DataState` is loaded asynchronously from the repository and exposed via
`AsyncNotifier<DataState>` (`dataProvider`). UI-only state lives in
dedicated small providers: `selectedDayProvider` (ISO string) and
`calendarMonthProvider` (year/month). The detail target and add form are
passed as **route args** (auto_route), not global state; the delete dialog
is a route/dialog, not a state flag.

The production database starts with no medicines and no dose history. Only
the default settings row is created. Prototype medicines and historical logs
exist exclusively as explicit fixtures under `test/support/`.

### Notifier actions (`dataProvider`)
`toggleTaken(iso,medId,doseTimeId) → bool` (returns whether the day just
completed, so the caller can route to Done), `addMed(draft)`,
`deleteMed(id)`, `toggleSetting(key)`, `toggleNotif(id)`. Each writes
through the repository, logs via Talker, and updates `DataState`.

### Derived (selectors, computed outside widgets)
periods-for-day (as dose occurrences), week strip (Mon–Sun), progress %
(occurrence-based), calendar cells, day agenda by time (occurrence-based),
7-day adherence + current streak (occurrence-based), refills %,
`medDosesForDay`/`nextDoseLabel` for the Detail screen's per-slot toggle
rows.

---

## 5. Navigation (auto_route)

`AppRouter` (`@AutoRouterConfig`) with `MaterialApp.router`.

- `SplashRoute` is the actual `initial: true` route (see §6) — it
  replaces itself with `DashboardRoute` once bootstrapping finishes, so
  it never sits in the back stack.
- `DashboardRoute` wraps the four bottom-nav tabs in an
  `AutoTabsScaffold`: **Home**, **Calendar**, **Refills**, **Settings**,
  with the floating center **+** FAB pushing `AddRoute`.
- Pushed full-screen routes (no bottom nav): `AddRoute`,
  `DetailRoute(medId)`, `DoneRoute`, `HistoryRoute`, `NotificationsRoute`,
  `TransactionsRoute`.
- The "all doses taken" celebration: after `toggleTaken` reports the day
  just completed, the calling widget `router.push(const DoneRoute())`.
- Delete confirmation is shown via `showModalBottomSheet` /
  `DeleteDialog` from the detail page.
- Status-bar tint is set per-page with `AnnotatedRegion` (indigo on
  detail/done/splash).

---

## 6. Screens

0. **Splash** (`lib/features/splash/splash_page.dart`) — the app's
   `initial: true` route. Full-bleed `AppColors.primary` background
   (styled after `DonePage`'s "moment" screens), a white-on-white pop-in
   badge holding a two-tone capsule (`PillShape`), the app name, a
   tagline, and three wave-pulsing dots — all staggered off one
   `AnimationController` via `Interval`-based `CurvedAnimation`s, plus a
   separate looping controller for a subtle breathing scale on the badge.
   In parallel it awaits `dataProvider.future` and
   `medicineRegistryProvider.future` (each wrapped in its own try/catch
   so a failure doesn't strand the splash — the destination screen shows
   its own `ErrorView`) alongside a 1400ms minimum-display timer, then
   `context.router.replace(const DashboardRoute())`. The minimum timer
   exists so the animation always plays out even when the DB responds
   instantly on a warm launch; it doesn't block on anything beyond that.

   **Native pre-engine splash (Android).** Dart's `SplashPage` only
   exists once the Flutter engine has drawn its first frame — before
   that, Android's own process-start splash was showing the unmodified
   `flutter create` template (default Flutter mascot icon on black),
   since nothing had ever branded it. `android/app/src/main/res/values*/
   styles.xml`'s `LaunchTheme` now extends `Theme.SplashScreen` (from
   `androidx.core:core-splashscreen`, added in
   `android/app/build.gradle.kts` so the same theme name resolves
   consistently pre- and post-API-31) with
   `windowSplashScreenBackground` = `@color/splashBackground` and
   `windowSplashScreenAnimatedIcon` = `@drawable/ic_splash_pill` — a
   hand-written vector mirroring `PillShape`'s two-tone capsule on a
   white circle, so the native splash and Dart's `SplashPage` show the
   *same* mark. `MainActivity.onCreate` calls `installSplashScreen()`
   before `super.onCreate()`, which is required for the compat path on
   pre-31 devices. `launch_background.xml` (both density variants) was
   also repointed from white/`colorBackground` to `@color/splashBackground`
   so there's no white flash in the gap between the system splash
   dismissing and Flutter's first frame.

   **Native pre-engine splash (iOS).** Same problem, different
   mechanism: `ios/Runner/Base.lproj/LaunchScreen.storyboard` was still
   the unmodified `flutter create` template — a plain white background
   behind an invisible 1×1 transparent placeholder image
   (`Assets.xcassets/LaunchImage.imageset`). Its `backgroundColor` is
   now `AppColors.primary` (0.3333, 0.4, 0.8392 sRGB = `0xFF5566D6`),
   and `Info.plist` sets `UIStatusBarStyle` to
   `UIStatusBarStyleLightContent` so the status bar stays readable
   against it. The placeholder image itself was left alone (still
   invisible, harmless) rather than adding real icon artwork —
   storyboards can't host a hand-written vector the way Android's
   `VectorDrawable` can, and generating raster assets was judged
   disproportionate to the actual complaint (a white flash, not a
   wrong icon).
1. **Home** — day header + prev/next, notifications & calendar buttons,
   week strip, progress ring card (→ history), dose-occurrence list grouped
   by period (a medicine with several daily doses appears once per slot,
   each independently trackable), tap the check circle → dose action
   sheet (see §6a), tap tile → detail.
2. **Calendar** — month grid with today/selected/dots, day agenda (one row
   per dose occurrence), "Open this day" CTA.
3. **Add medicine** — photo placeholder, name/dose/pills fields (pills =
   how many you have now; becomes both `supply` and `cap`, since a newly
   added medicine starts full), a repeatable list of time + time-of-day
   slots ("+ Add another time" / remove per row, minimum 1) so a medicine
   can be scheduled several times a day, food choice, Save. NAME and
   PILLS are marked required (`*`); Save is disabled (greyed, no shadow,
   `onTap: null`) until both are filled in with a valid pill count
   (≥ 1), with a hint line above the button explaining why.
4. **Detail** — indigo header, next/food/left stat cards (NEXT shows the
   earliest untaken slot today, "+N" suffixed when there's more than one),
   last-7-days row (a day counts as done only once every slot is taken),
   a "today's doses" list with one independent dose-status button per slot
   (opens the same dose action sheet as Home), delete.
5. **Done** — celebration (pop check + confetti dots), doses/streak stats,
   view-tomorrow / back-to-today.
6. **History** — 7-day adherence card, bar chart, summary rows, a
   "View transactions" nav row → **Transactions**.
7. **Refills** — low-supply alert, per-med supply bars + a tappable
   order/OK button that opens a "Refill {name}?" sheet (pre-filled with
   the current pack size) and sets both `supply` and `cap` to the entered
   count.
8. **Reminders** — per-med reminder switches. Switching a medicine's
   reminder off excludes it from today's active dose-tracking surfaces
   (see §6a) — it disappears from the Home list, Calendar agenda, and
   the "doses left today" count, and can no longer block the "all
   doses taken" celebration. It still exists everywhere else: Detail,
   Refills, and History's adherence stats are unaffected, and it
   reappears the moment the reminder is switched back on.
9. **Settings** — profile, preference switches, navigation rows.
10. **Transactions** — the `SupplyTransactions` ledger, newest first, as
    a filterable list (see §6a). A medicine dropdown ("All medicines" +
    one entry per medicine) and a 4-way interval segmented control
    (All time / 7 days / 30 days / 90 days) narrow the list; each row
    shows the medicine name, a kind label + icon, the timestamp, and
    the signed pill delta (green for positive, ink for negative).
    Reached only from History, per the feature request.

---

## 6a. Dose states and the supply ledger

Every scheduled dose has three possible states — `DoseStatus`
(`lib/core/models/dose_status.dart`): **pending** (not touched — the
default), **taken**, and **rejected** (deliberately skipped, e.g. the
user chose not to take it). Absence from `DataState.doseStatus` means
pending; a `DoseLog` row only exists once a dose has been touched.

Tapping a dose's check control (Home tile or Detail's toggle button)
always opens the shared **dose action sheet**
(`lib/core/widgets/dose_action_sheet.dart`) rather than mutating state
directly:
- **pending** → "Mark as taken" / "Mark as rejected" / Cancel.
- **taken** / **rejected** → "Undo" (reverts to pending) / Cancel.

`DataNotifier` exposes `markTaken`, `markRejected`, and `revertDose`
(`lib/core/state/data_notifier.dart`) — there is no direct
"set status" mutation from the UI. `markTaken` also consumes one pill;
`revertDose` credits it back if the dose had been taken. `markRejected`
never touches supply — nothing was consumed.

**Supply transactions.** A medicine's current pill count is **not
stored** — `Medicines` has no `supply` column. It's derived at read
time by summing every row logged in `SupplyTransactions`
(`lib/core/db/app_database.dart`), the sole source of truth:
- `initial` — the starting stock entered on Add.
- `refill` — from the Refills sheet; `delta` is the signed difference
  between the entered total and the current (derived) supply, so
  entering a *lower* total than the current supply logs a **negative**
  delta — this doubles as the error-correction path (no separate
  "correct" action; see `MedicineRepository.refillMedicine`).
- `take` (-1) / `revertTake` (+1) — from `markTaken` / `revertDose`,
  tied back to the triggering dose via nullable `iso`/`doseTimeId`
  columns, logged by `MedicineRepository._logSupplyTransaction`.

`MedicineRepository.loadAll` computes every medicine's supply in one
pass (`_supplyTotals`: load all `SupplyTransactions` rows, fold by
`medId`) and `_toMedicine` clamps the sum to `0..cap` before it ever
reaches the domain `Medicine.supply` field — the ledger itself is
never clamped or rewritten, only the derived display value is.
`refillMedicine` needs the current balance for a single medicine to
compute its delta; `_currentSupply(medId)` does that same fold scoped
to one `medId`. `deleteMedicine` clears a medicine's rows along with
its other data.

**Reading the ledger.** `MedicineRepository.loadTransactions()` returns
every `SupplyTransactionRow`, newest first (`ORDER BY createdAt DESC`);
filtering by medicine and by date range happens client-side in
`Selectors.transactions` rather than as query params — the ledger stays
small enough for a personal app that loading it in full and filtering
in memory is simpler than threading filter state into SQL.
`transactionsProvider` (`lib/core/state/providers.dart`) is a
`FutureProvider.autoDispose` that watches `dataProvider` so it reloads
after every mutation that touches supply; `transactionFilterProvider`
holds the screen's own UI-only filter state (`medId`, a
`TransactionInterval` enum — `all` / `last7Days` / `last30Days` /
`last90Days`). See §6 for the screen itself.

**Reminder-off exclusion.** `DataState.notifOff` (toggled from the
Reminders screen, §6) doesn't just drive that screen's switches — a
medicine with its reminder off is excluded from every surface built on
`Selectors._activeOccurrences` (Home's `periods`, `progress` — which
also feeds Calendar's reminder count and the Done screen's total — and
Calendar's `dayAgenda`), and `DataState.allTaken` (the Done-celebration
trigger and `Selectors.streak`) skips it the same way. This is a live
filter on the *current* reminder setting, not a per-day historical
one — toggling a reminder affects today's (and any future) trigger,
but doesn't rewrite what already happened. Two things deliberately
still see every medicine regardless of its reminder setting:
`Selectors._occurrences` (used only by `history()`, so 7-day adherence
numbers don't change retroactively when a reminder is toggled) and
everything on Detail/Refills, which read `med.times` / `data.meds`
directly rather than going through the occurrence helpers — a
medicine stays fully manageable there even while muted.

---

## 7. Persistence (drift)

`AppDatabase` (`@DriftDatabase`, SQLite via `drift_flutter`):

| Table | Columns |
|---|---|
| `Medicines` | id (PK text), name, dose, withFood, kind, c1, c2 (nullable), soft, cap. **No `supply` column** — the current pill count is derived from `SupplyTransactions`, never stored (see §6a). |
| `DoseTimes` | medId (text), id (text), time, period, sortOrder — PK (medId, id) |
| `DoseLog` | iso (text), medId (text), doseTimeId (text), status (text, `DoseStatus` name) — PK (iso, medId, doseTimeId). A row only exists once a dose is touched; absence means pending. |
| `SupplyTransactions` | id (PK autoincrement), medId, delta (signed int), kind ('initial'/'refill'/'take'/'revertTake'), createdAt, iso (nullable), doseTimeId (nullable) — append-only ledger, sole source of truth for pill counts, see §6a |
| `SettingsRows` | id (PK, single row = 0), sound, vibrate, refill, localeOverride (nullable text) |
| `NotifOffRows` | medId (PK text) — presence means reminder disabled |
| `MedicineRegistryEntries` / `MedicineRegistryMeta` | imported medicine-name lookup data (search, CSV import) |

`schemaVersion = 8`. Migrations are **append-only** — never edit a past
migration; add a new one and bump the version. On first open the database
starts empty (see §4). The `MedicineRepository` is the only thing that
talks to drift and returns `Either<AppException, T>`.

- **v1 → v2**: added `SettingsRows.localeOverride` (nullable text).
- **v2 → v3**: added `MedicineRegistryEntries` / `MedicineRegistryMeta`.
- **v3 → v4**: deleted leftover legacy demo-medicine rows (`m1`–`m4`) from
  `DoseLog` / `NotifOffRows` / `Medicines`.
- **v4 → v5** (multi-dose-per-day): `Medicines.time`/`.period` moved to the
  new `DoseTimes` table (one row per scheduled slot); `DoseLog` gained
  `doseTimeId` and its primary key grew from `(iso, medId)` to
  `(iso, medId, doseTimeId)`. Migration reads each medicine's old
  `time`/`period` via raw SQL (`customSelect`) before the columns are
  dropped, inserts one `DoseTimes` row per medicine (id `t1`), backfills
  `DoseLog.doseTimeId` to match, then drops the two old columns
  (`ALTER TABLE ... DROP COLUMN`, requires the SQLite bundled by
  `sqlite3_flutter_libs`, which supports it). Verified against a **real**
  v4 database — built by running the actual pre-migration code from a
  `git worktree` checkout, not hand-rolled DDL — confirming data survives
  the upgrade and the old columns are actually gone afterward.
- **v5 → v6** (tri-state doses + supply ledger, see §6a): creates
  `SupplyTransactions`; adds `DoseLog.status` (default `'pending'`),
  backfills it from the old `taken` boolean (`taken = 1` → `'taken'`),
  deletes rows where `taken = 0` (they carry no information under the
  new "absence == pending" convention), then drops `DoseLog.taken`.
  Seeds the ledger with each medicine's current `supply` as an
  `'initial'` transaction, so every medicine has a consistent opening
  balance regardless of how it got there pre-migration.
- **v6 → v7**: drops `Medicines.supply`. By this point every write path
  already kept the column and the ledger in lockstep (the v6 migration
  seeded a matching opening balance, and `addMedicine`/`refillMedicine`/
  `recordTake`/`recordRevertTake` all logged a transaction alongside
  the column write), so this is a pure `ALTER TABLE ... DROP COLUMN`
  with no backfill needed — nothing changes for the user, the column
  was already redundant.
- **v7 → v8** (critical data-loss fix): rebuilds `DoseLog` because its
  physical PRIMARY KEY was never actually `(iso, medId, doseTimeId)` on
  any real device — the v4 → v5 migration added `doseTimeId` via
  `m.addColumn`, which adds a column but **cannot change a table's
  PRIMARY KEY**. Every device that had ever upgraded through v5 stayed
  physically keyed on just `(iso, medId)`. `MedicineRepository.setDoseStatus`'s
  `insertOnConflictUpdate` targets the *Dart-declared* key, and SQLite
  rejects an `ON CONFLICT` target that doesn't match any real
  constraint — so on every such device, marking a dose taken or
  rejected threw inside `MedicineRepository._guard`, which caught and
  logged the error but never surfaced it (the notifier doesn't inspect
  the returned `Either`). The optimistic in-memory state looked
  correct until the next app restart reloaded from the untouched
  table, silently reverting every dose back to pending. Fixed by
  renaming the old table, recreating `dose_log` from the current Dart
  definition (correct 3-column key), copying rows across, and dropping
  the renamed original — safe because the old 2-column key means there
  was at most one legacy row per `(iso, medId)`, so re-keying to the
  finer-grained triple can never collide.

`kToday` (`lib/core/db/app_database.dart`) is the app's single notion of
"today" — a `DateTime get` at local midnight, backed by `package:clock`.
Production never overrides it, so it always reflects the real device date.
Tests that assert against fixture data anchored to a specific day (the
design's original Tuesday, June 30, 2026) pin it via
`withFixedToday(() async { ... })` (`test/support/fixed_clock.dart`), which
wraps the test body in `withClock(Clock.fixed(...))` — a `Zone`-scoped
override, so nothing in production code needs to know it exists.

---

## 7a. Error handling

- `AppException` — `@freezed` sealed union:
  `databaseFailure(message)`, `notFound(id)`, `invalidRegistryFile(message)`,
  `unknown(error)`.
- Repositories catch drift/SQLite errors and map to `Left(AppException)`.
- **Load failures** (`dataProvider`'s own `build()`): folds the `Either`
  directly — `Left` rethrows, so the whole screen falls into
  `AsyncValue.error` and renders via a shared `ErrorView`. Appropriate
  when the app has no data to show at all.
- **Write failures** (every mutation method on `DataNotifier` —
  `markTaken`, `markRejected`, `revertDose`, `addMedicine`,
  `refillMedicine`, `deleteMedicine`, `toggleSetting`,
  `setLocaleOverride`, `toggleNotif`): each applies its optimistic UI
  update first, then awaits the repository call and passes the
  returned `Either` through `_reportIfFailed`. A `Left` calls
  `ref.read(errorNotifierProvider.notifier).report(failure)`
  (`lib/core/state/error_notifier.dart` — a bare
  `Notifier<AppException?>`); a `Right` is a no-op. This exists because
  a write failure here previously had **no** failure path at all: the
  `Either` was simply discarded, so a thrown exception was caught and
  logged by `MedicineRepository._guard` and then vanished — this is
  exactly how the v7→v8 `DoseLog` primary-key bug (§7) went unnoticed
  for as long as it did. `_PillnoteAppState.build()`
  (`lib/app.dart`) calls `ref.listen<AppException?>(errorNotifierProvider, ...)`
  and, on a non-null value, shows a `SnackBar` via a
  `GlobalKey<ScaffoldMessengerState>` passed to
  `MaterialApp.router(scaffoldMessengerKey: ...)`, using
  `AppExceptionL10n.message(l10n)` for the text — then immediately
  calls `.clear()` so the same failure can't re-fire on the next
  rebuild. The `l10n` there comes from `AppLocalizations.of(messenger.context)`
  (the `ScaffoldMessengerState`'s own context), not the `context`
  argument to `build()` — that outer context sits *above*
  `MaterialApp.router` and has no `Localizations` ancestor yet on the
  first build, while the messenger's context is guaranteed to be a
  `MaterialApp.router` descendant once mounted.
- Whether a failed write should also roll back its optimistic UI
  update is a separate, unresolved question — right now it doesn't:
  the snackbar tells the user something went wrong, but the UI still
  shows the (unpersisted) new state until the next full reload
  resyncs it from the database.
- `main()` installs `FlutterError.onError` and
  `PlatformDispatcher.instance.onError` → Talker.

## 7b. Logging (Talker)

- Single `Talker` created in `main()`, injected via `talkerProvider`.
- `TalkerRiverpodObserver` on the root `ProviderScope` logs provider
  transitions.
- Repository logs DB reads/writes and maps errors through
  `talker.handle`.

---

## 8. Testing

- Widget smoke test: app boots to an empty Home with no demo medicines.
- Toggle test: checking the last remaining dose routes to Done.
- Add test: saving a named medicine appends a tile.
- Migration test (`test/dose_log_migration_test.dart`): every other
  test opens a brand-new `NativeDatabase.memory()`, which always
  builds tables from the *current* Dart schema via `onCreate` — never
  through a real `onUpgrade` chain. That blind spot is exactly how the
  v7→v8 `DoseLog` primary-key bug (see §7) went undetected, so this
  test hand-builds a temp-file database matching a real migrated
  device's on-disk schema (verified against a live simulator via the
  `sqlite3` CLI before fixing it), runs it through `AppDatabase`'s
  actual migration strategy, and asserts the repaired table accepts
  the writes the broken one rejected. When adding a migration that
  changes a primary key or any other constraint SQLite can't alter
  in-place, add a fixture here rather than trusting the rest of the
  suite to catch it — it won't.
- Error-snackbar test (`test/error_snackbar_test.dart`): closes the
  in-memory database mid-test (`await db.close()`) to force the next
  `DataNotifier` write to throw, then asserts a `SnackBar` appears —
  the regression test for §7a's write-failure surfacing. Verified it
  actually catches a regression, not just a tautology, by temporarily
  deleting the `ref.listen` block in `app.dart` and confirming the
  test fails.

---

## 9. Build & Run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
flutter analyze     # zero warnings
flutter test
dart format .
```

---

## 10. Implementation Phases

1. Scaffold — deps, tokens, models, empty shell. ✅
2. State — data layer, providers, seed, persistence. ✅ (superseded by 3a)
3. Home + shell + bottom nav (core toggle→done loop). ✅
3a. **Architecture migration** — Freezed models, drift DB +
   `MedicineRepository` (`Either<AppException,T>`), Talker logging,
   auto_route navigation (`AutoTabsRouter`), `AsyncNotifier` data
   state. Rebuild Home on the new stack. ✅
   (other pages are `PlaceholderBody` stubs)
4. Calendar, Add, Detail, Delete dialog. ✅
5. History, Refills, Reminders, Settings. ✅
6. Polish — animations, analyze/test clean, smoke tests. ✅
7. Localization — English + Ukrainian via `flutter_localizations`/ARB. ✅

**Out of scope (v1):** real OS notifications
(`flutter_local_notifications`) — Reminders screen toggles state only.
Tracked as a future phase.

---

## 11. Changelog

- **0.1.0 (in progress)** — Project spec rewritten from scratch for the
  Pillpal medicine-reminder app (previous SPEC was an unrelated JRiver
  Remote template).
  - Phases 1–3 complete: dependencies (`flutter_riverpod`, `google_fonts`,
    `shared_preferences`), design-token theme, models, state layer
    (`AppController` + persistence + seed), pure `Selectors`, app shell
    with state-driven navigation + bottom nav + FAB + delete dialog, and
    the **Home** screen (header, week strip, progress ring, grouped
    medicine tiles with tap-to-toggle → auto "Done" transition).
  - `flutter analyze` clean; Home smoke test green.
  - **Phase 3a — architecture migration** (per updated tech directives):
    - Models → **Freezed 3** + `json_serializable` (`Medicine`,
      `AppSettings`, `AddDraft`, `DataState`); `AppException` sealed
      union.
    - Persistence → **drift** (`AppDatabase`: Medicines / DoseLog /
      SettingsRows / NotifOffRows), originally seeded on first open. Replaced
      `shared_preferences`.
    - `MedicineRepository` returns **`Either<AppException,T>`** (fpdart)
      and logs through **Talker**; folded inside `AsyncNotifier`.
    - Navigation → **auto_route** (`AutoTabsRouter` dashboard shell with
      four tabs + FAB; pushed routes for add/detail/done/history/
      reminders). Removed the `AppScreen` enum + `AnimatedSwitcher` shell.
    - DI via Riverpod providers (`databaseProvider`,
      `medicineRepositoryProvider`, `talkerProvider`,
      `TalkerRiverpodObserver`).
    - `build_runner` generated code committed; `flutter analyze` clean;
      smoke test green (drift in-memory).
  - Remaining pages render a `PlaceholderBody` stub.
  - **Phase 4 — Calendar, Add, Detail, Delete:**
    - **Calendar** page: month grid (today/selected/dots), tap-to-select
      day, per-day agenda, "Open this day" → Home tab.
    - **Add medicine** page: dashed photo placeholder, name/dose/time
      fields, period + food segmented controls, page-scoped
      `addFormProvider` (auto-dispose), Save → `dataProvider.addMedicine`.
    - **Detail** page: indigo header, next/food/left stat cards,
      last-7-days dot row, mark-taken toggle (→ Done when day completes),
      delete → `showDeleteSheet` → `dataProvider.deleteMedicine`.
    - Delete confirmation as a modal bottom sheet.
    - Added data-layer tests (repository add/delete/seed + toggle→done);
      5 tests green, `flutter analyze` clean.
  - **Phase 5 — History, Refills, Reminders, Settings:**
    - **History**: indigo 7-day adherence card, `AdherenceBars` chart
      (full/partial/empty coloring), summary rows (doses taken, streak,
      best time).
    - **Refills**: low-supply alert banner, per-med `RefillTile` (supply
      progress bar + Order/OK button), driven by `Selectors.refills`.
    - **Reminders**: per-medicine `ReminderTile` with a shared
      `ToggleSwitch`, wired to `dataProvider.toggleNotif`.
    - **Settings**: profile card, preference toggles (sound/vibrate/
      refill via `dataProvider.toggleSetting`), and nav rows to
      History/Refills/Reminders.
    - All four screens read from `dataProvider`/`Selectors`; no
      screen-local business logic.
    - Added `test/navigation_test.dart` (bottom-nav tab switching +
      Home → Detail flow). 7 tests total, all green;
      `flutter analyze` clean.
  - **Phase 6 — Polish & live verification:**
    - Ran the app live on iOS Simulator (iPhone 17 Pro) and walked every
      screen. Caught and fixed a real gap: the **Done celebration
      screen** had been left as a `PlaceholderBody` stub through
      phases 3–5 — the toggle→done routing worked, but the destination
      screen was never built. Implemented it: pop-in checkmark
      (`PopCheck`, scale/opacity via `TweenAnimationBuilder` +
      `Curves.easeOutBack`, mirroring the prototype's `pop` keyframes),
      four scattered `ConfettiDot`s, doses/streak stat chips, "View
      tomorrow" (advances the day, pops to Home) and "Back to today".
    - Added `test/done_screen_test.dart` — drives real checkbox taps
      (via a `ValueKey('toggle-<medId>')` added to `MedicineTile`'s
      check button) to reach the Done screen and assert its content.
      This is the regression test that would have caught the gap
      above; relying on `toggleTaken` returning `true` alone was not
      enough since it never verified the destination screen rendered.
    - Verified visually on-device: Home, Detail, Delete sheet, Add
      medicine (full add flow including keyboard input), Calendar,
      Refills, Settings (toggle + persistence), Reminders (toggle),
      History, and Done — all match the design closely. No overflow
      or layout errors in the `flutter run` log.
    - 8 tests green, `flutter analyze` clean, `dart format .` clean.
  - **Phase 7 — Localization (English + Ukrainian):**
    - Added `flutter_localizations`/`intl`, `l10n.yaml`, and
      `lib/l10n/app_en.arb` / `app_uk.arb` covering every screen's
      chrome text with ICU plurals (all four Ukrainian categories —
      `one`/`few`/`many`/`other`).
    - Locale auto-resolves from the device; no manual switcher.
    - Refactored `Selectors` to stop returning pre-formatted English
      sentences (`DoseProgress.title/.subtitle`,
      `HistorySummary.subtitle`, `RefillItem.countLabel` removed) —
      it now returns raw counts/booleans and widgets format via
      `context.l10n`. `Period` and `AppException` display text moved
      to `l10n_extensions.dart` (`.label(l10n)` / `.message(l10n)`),
      keeping the model/exception classes locale-agnostic.
    - `DayUtils` rewritten on top of `intl`'s `DateFormat(locale)` —
      no more hardcoded English month/weekday tables. `Selectors`
      functions that surface weekday glyphs now take a `String
      locale` parameter (never a `BuildContext`).
    - Removed the now-dead `PlaceholderBody` widget (all 9 screens
      were implemented by Phase 6, so it had no remaining callers).
    - Found and fixed a real defect during live-device QA (not caught
      by `flutter analyze` or widget tests): CLDR's narrow
      single-letter weekday format collapses in Ukrainian (Пн and Пт
      both render "П"; Ср and Сб both render "С"). `dowNarrow` now
      uses a hardcoded 2-letter Ukrainian table
      (Пн/Вт/Ср/Чт/Пт/Сб/Нд) instead of `DateFormat('EEEEE', 'uk')`
      for that locale.
    - Added `test/localization_test.dart` — pumps the app under a
      forced `Locale('uk')` and asserts real Cyrillic text renders
      (not just that the ARB compiled), plus a plural-category
      regression check (3 doses → "few" → "прийоми").
    - Visually verified on-device (temporary `locale:` override,
      reverted before commit) across Home, Add, Calendar, Refills,
      Settings, and Detail — no text overflow despite Ukrainian
      strings running longer than English.
    - 10 tests green, `flutter analyze` clean, `dart format .` clean.
  - **Ukrainian fallback default:** device set to English/Ukrainian
    still shows that language; any other device language now falls
    back to Ukrainian instead of Flutter's default English fallback.
    Extracted `resolveLocale` as a standalone pure function
    (`lib/l10n/locale_resolution.dart`) wired via
    `localeListResolutionCallback`, with 6 unit tests covering the
    match/fallback/null/empty-list/multi-preference cases directly
    (no widget pump required). 16 tests green.
  - **In-app language override:** Settings → LANGUAGE (System /
    English / Українська segmented control) lets the user force a
    language regardless of device locale, overriding
    `resolveLocale`.
    - Persisted as `AppSettings.localeOverride` (nullable — null =
      "System"). Drift schema bumped to **v2**
      (`SettingsRows.localeOverride`, nullable text column) with an
      append-only `onUpgrade` migration (`m.addColumn`), per the
      project's "never edit a past migration" rule.
    - `PillpalApp` converted to `ConsumerStatefulWidget`; watches
      `dataProvider`'s settings and passes `locale:
      Locale(override)` to `MaterialApp.router` when set (which
      takes priority over `localeListResolutionCallback`), or `null`
      to fall through to automatic device resolution.
    - Language option labels show each language's own native name
      (`English`, `Українська`) untranslated — standard picker UX so
      users can find their language even if they can't read the
      current UI language; only "System" is translated.
    - Tests: repository round-trip for save/load/explicit-null
      (`data_layer_test.dart`), and an end-to-end widget test
      (`settings_language_test.dart`) that pumps the real
      `PillpalApp`, taps "Українська" in Settings, asserts the
      **entire app** re-localizes live with no restart and no
      manual `locale:` override in the test, confirms the choice is
      persisted to the DB, then taps "System" and confirms it
      reverts. This is the test that actually proves the feature
      works end-to-end, not just that the code compiles.
    - Skipped a hand-rolled v1→v2 raw-SQL migration test — no v1
      database exists in the wild yet (app never shipped), and
      hand-crafting DDL to match drift's internal column-generation
      conventions risks being a worse test than no test. The
      persistence test above exercises the resulting v2 schema
      fully; if this app ships a real v1 release before this
      migration lands, add a `drift_dev` pinned-schema migration
      test at that point.
    - Verified live on-device: language switch is instant and
      app-wide (Home, not just Settings), persists across
      navigation, and cleanly reverts via "System". 18 tests green,
      `flutter analyze` clean, `dart format .` clean.
  - **Medicine registry search and CSV updates:**
    - Imported `reestr.csv` into a generated, compressed database seed
      containing 14,931 unique trade-name/generic-name/form records. The
      source CSV is not a Flutter asset; on first registry use the seed is
      expanded once into SQLite (`MedicineRegistryEntries`).
    - Add medicine now searches SQLite by trade name, international generic
      name, and dosage form. Selecting a result fills the medicine name while
      preserving manual entry and editing.
    - Settings → Medicine registry can select a replacement `.csv` file on
      iOS or Android. The parser supports the official semicolon-delimited,
      quoted, escaped, and multiline format. Replacement is transactional:
      invalid files leave the current database registry intact.
    - `tool/generate_medicine_registry_seed.dart` rebuilds the initial seed
      from a newer source file for future app releases; in-app imports update
      the installed database without an app release.
    - Added English/Ukrainian strings and parser/repository regression tests,
      including real seed import/search and invalid-file rollback coverage.
  - **Removed production demo data:** schema **v4** makes new databases empty
    and removes the exact legacy demo IDs (`m1`…`m4`) plus their dose and
    notification records from existing installations. User-created medicines
    are untouched. Prototype records now live only in test fixtures.
- **Multi-dose-per-day medicines.** A medicine can now be scheduled several
  times a day (e.g. morning + afternoon + evening), each slot tracked and
  toggled independently.
  - **Data model:** new `DoseTime { id, time, period }` model;
    `Medicine.time`/`.period` replaced by `Medicine.times: List<DoseTime>`
    (non-empty). `AddDraft.time`/`.period` replaced by
    `AddDraft.times: List<DraftTime>`. `taken` keys grew from
    `"iso|medId"` to `"iso|medId|doseTimeId"`; added `DataState.allTaken`.
  - **Schema v4 → v5:** see §7 — new `DoseTimes` table, `DoseLog` gained
    `doseTimeId` (now part of its primary key), `Medicines.time`/`.period`
    dropped. Migration verified against a real v4 database (built from the
    actual old code via a `git worktree` checkout of the pre-migration
    commit), confirming data survives the upgrade.
  - **Selectors reworked around occurrences, not medicines:** added
    `DoseOccurrence { med, doseTime }` and a private `_occurrences(data)`
    flattener; `periods`, `progress`, `dayAgenda`, `history`, `streak` now
    count/group dose slots instead of medicines, so a 3x/day medicine
    correctly contributes 3 to the day's total instead of 1. Added
    `medDosesForDay` and `nextDoseLabel` for the Detail screen.
  - **Add medicine form:** the single time/period row became a repeatable
    list (`_TimeSlotCard`) with a "+ Add another time" action and a
    per-row remove button (kept to a minimum of one slot); each row uses
    an uncontrolled `TextFormField(initialValue:...)` keyed by index
    rather than a persistent `TextEditingController`, since the row count
    changes dynamically. Slots left blank are dropped on save rather than
    silently defaulting to a time the user never chose.
  - **Home / Detail / Reminders:** `MedicineTile` now renders one row per
    `DoseOccurrence` (so a multi-dose medicine appears once per period
    it's scheduled in) and shows the slot's time next to the name only
    when the medicine has more than one slot, to disambiguate its rows.
    Detail's single "mark as taken" button became a per-slot list, and its
    NEXT stat shows the earliest untaken slot with a "+N" suffix when
    there's more than one. Reminders' subtitle joins all of a medicine's
    times (the mute toggle itself stays per-medicine, not per-slot — the
    app has no real OS notification scheduling to make a finer-grained
    toggle meaningful yet).
  - **Bug caught only via live device testing:** `DonePage` and
    `calendar_page`'s "N reminders scheduled" line still read
    `data.meds.length` after the selector rework, so completing a 3-dose
    day showed "2/2 doses" (medicine count) instead of "3/3" (dose-slot
    count) on the celebration screen. Neither `flutter analyze` nor the
    existing widget tests caught this, since none of them asserted the
    Done screen's stat *values* for a multi-dose fixture — only that the
    screen renders. Fixed both to use `Selectors.progress(data, iso).total`.
  - Tests: `data_layer_test.dart` gained a repository-level round-trip for
    a 3x/day medicine (persists three `DoseTimes`, toggles one slot
    without affecting the others). `done_screen_test.dart` and
    `test/support/seed_test_data.dart` updated for the new schema.
  - Verified live on-device: added a medicine with two slots (morning +
    evening), confirmed it renders as two independent rows on Home in
    their respective period sections, toggling one leaves the other
    untouched, Detail lists both with their own toggle, Reminders and
    Calendar show both times, and completing every slot across every
    medicine correctly triggers the Done celebration with the right
    total. 24 tests green, `flutter analyze` clean, `dart format .` clean.
  - **Follow-up bug, caught by the user (not by the automated tests
    above):** picking a time-of-day for each slot (Morning, then Evening)
    without ever typing into either TIME field saved only one slot,
    always Morning. `DataNotifier.addMedicine` was filtering out any slot
    whose `time` text was blank, and only fell back to a default when
    *every* slot was blank — collapsing multiple period selections down
    to a single hardcoded `8:00 AM` slot and silently discarding the rest.
    Fixed by keeping every slot the user added (never dropping one just
    because its time field is empty) and defaulting a blank slot's time
    to a per-period value (`Period.morning → '8:00 AM'`, `.afternoon →
    '1:00 PM'`, `.evening → '9:00 PM'`) instead. Added a regression test
    reproducing the exact repro (two slots, no typed text, Morning +
    Evening) asserting both are persisted with distinct times; re-verified
    live on-device. 25 tests green.
- **`kToday` now tracks the real device date.** Since the original design
  handoff, `kToday` was a hardcoded `DateTime(2026, 6, 30)` the whole app
  was anchored to (calendar "today" marker, week strip, history's "last 7
  days", streak calculation) — flagged by the user after noticing the app
  still showed June 30 as "today" a day later, on July 1.
  - `kToday` became a `DateTime get` computed from `clock.now()`
    (`package:clock`, added as a direct dependency), normalized to local
    midnight, instead of a fixed literal. All call sites (`ui_providers`,
    `selectors`) are unchanged syntactically — Dart getters and field
    reads look identical at the call site.
  - Five tests depend on the fixed anchor date, directly (`kToday` in
    assertions) or indirectly (`seedTestMedicines` seeds dose history
    relative to it, one test hardcodes `"June 2026"`). Rather than compute
    expected values dynamically against the real date (which would make
    test failures depend on which day the test happens to run), each is
    wrapped in `withFixedToday(() async { ... })`
    (`test/support/fixed_clock.dart`), pinning `kToday` to the original
    Tuesday, June 30, 2026 for that test only via `package:clock`'s
    `Zone`-scoped `withClock`. Production code is never wrapped, so it
    always sees the real date.
  - Verified live on-device: Home now shows "Wednesday, July 1" and the
    Calendar shows "July 2026" with today correctly highlighted, instead
    of being stuck on the old anchor date. 25 tests green, `flutter
    analyze` clean, `dart format .` clean.
- **Set pill count on add, and refill from the Refills screen.** Neither
  was previously possible — every new medicine was silently hardcoded to
  `supply: 30, cap: 30`, and the Refills screen's order/OK button was
  decorative (no `onTap`).
  - `AddDraft` gained a `supply` field (free text, like `dose`/`name`) and
    the Add form gained a PILLS field next to DOSE. `DataNotifier
    .addMedicine` parses it via `_parseSupply` (falls back to 30 for
    blank/invalid input, never 0) and sets **both** `supply` and `cap` to
    that value — a freshly added medicine is, by definition, full.
  - New `MedicineRepository.setSupply(medId, supply, cap)` (a drift
    `UPDATE`, the model's first) and `DataNotifier.refillMedicine(medId,
    newSupply)`, which sets `supply` **and** `cap` to the new count
    together — a refill resets the "full pack" size too, since the next
    pack purchased may not match the original.
  - `RefillTile` (`lib/features/refills/widgets/refill_tile.dart`)
    became a `ConsumerWidget`; its order/OK button now opens
    `showRefillSheet` (`refill_sheet.dart`, mirrors `delete_sheet.dart`'s
    pattern) — a bottom sheet pre-filled with the medicine's current
    `cap`, digits-only input, Cancel/Refill — and calls
    `refillMedicine` with the result. Tappable in both the low-supply
    ("Order") and healthy ("OK") states, so a count can be corrected
    proactively, not just when it's already low.
  - Tests: `data_layer_test.dart` covers a custom pill count persisting
    through `addMedicine`, invalid input falling back to a default, and
    `refillMedicine` updating supply/cap together. Verified live: added a
    medicine with 60 pills (confirmed on Detail's LEFT stat and the
    Refills list), then refilled another medicine from 30 to 90 pills via
    the sheet and confirmed the list updated live. 27 tests green,
    `flutter analyze` clean, `dart format .` clean.
  - **Follow-up bug, caught by the user:** clearing the refill sheet's
    pill-count field looked like it "auto-filled with the previous
    value." Root cause: the `TextField` set a `hintText` ("30") but never
    a `hintStyle`, so with no theme-level `InputDecorationTheme` override
    either, Flutter fell back to rendering the hint in the *same* dark,
    bold style as real input (`AppText.bricolage`'s default `ink`
    color/`w800` weight) — an empty field showing its hint was visually
    indistinguishable from a committed value. The underlying logic was
    always correct (`_confirm()` already treated empty/unparseable input
    as invalid and returned `null`); this was a pure styling bug. Fixed
    by giving the hint an explicit muted style
    (`AppText.bricolage(color: AppColors.muted2)`), matching the
    convention every other hinted field in the app already follows (e.g.
    `_Field` in `add_medicine_page.dart`). Verified live by clearing the
    field character-by-character with zoomed screenshots at each step,
    confirming the hint now renders visibly lighter/greyer than real
    input, and that confirming on an empty field is still correctly a
    no-op. 27 tests green, `flutter analyze` clean, `dart format .`
    clean.
  - **Tri-state doses + supply transaction ledger** (see §6a): doses
    gained a third state — `DoseStatus.pending` / `.taken` / `.rejected`
    — and every change to a medicine's pill count (initial stock,
    refills/corrections, a dose being taken, a taken dose being
    reverted) is now logged as an immutable row in a new
    `SupplyTransactions` table, alongside the running `Medicines.supply`
    total.
    - Tapping a dose's check control now opens a confirmation sheet
      (`dose_action_sheet.dart`) instead of toggling directly — pending
      doses offer "Mark as taken" / "Mark as rejected", touched doses
      offer "Undo". `DataNotifier.markTaken`/`markRejected`/`revertDose`
      replace the old `toggleTaken`.
    - Marking a dose taken now consumes one pill (previously taking a
      dose never touched supply); reverting a taken dose credits it
      back. Rejecting a dose never touches supply. Supply is clamped to
      `0..cap`.
    - The Refill sheet is unchanged UX-wise (still asks for a new
      total), but now doubles as the "correct an error" path: entering
      a total lower than the current supply logs a negative-delta
      transaction.
    - DB: `schemaVersion` 5 → 6. `DoseLog.taken` (bool) replaced by
      `DoseLog.status` (text); new `SupplyTransactions` table.
      Migration backfills status from the old boolean, drops
      rows/columns per the new "absence == pending" convention, and
      seeds one `'initial'` ledger transaction per medicine from its
      current supply.
    - Tests: `data_layer_test.dart` covers `markTaken` consuming a pill,
      `revertDose` crediting it back, `markRejected` leaving supply
      untouched, and `refillMedicine` logging a negative delta on a
      downward correction; `done_screen_test.dart` updated for the new
      confirm-in-sheet flow. 30 tests green, `flutter analyze` clean,
      `dart format .` clean. Verified live on the iOS Simulator: opened
      the sheet from Home and Detail, marked a dose taken (supply
      59→60→59 across mark/undo/mark), marked a dose rejected (supply
      unchanged, red ✕ shown on Home and Detail), and confirmed the
      Refills list reflects the final state — all against the real,
      already-migrated on-device database (not a fresh install), and
      with the confirmation sheet's initial three-button layout fixed
      for a RenderFlex overflow found during that same test run.
  - **`addMedicine` no longer defaults an unparseable PILLS field to
    30.** A blank or invalid pill count is now a validation failure
    like an empty name — `DataNotifier.addMedicine` returns early and
    nothing is saved, rather than silently inventing a 30-pill starting
    supply. Test updated: `Metoprolol` with `supply: 'not a number'` now
    asserts the medicine was never added, instead of asserting a
    fallback `supply > 0`.
  - **`markTaken` refuses to mark a dose taken when the medicine has
    fewer than 1 pill left.** `DataNotifier.markTaken` now looks up the
    medicine and no-ops (returns `false`) if `supply < 1`, on top of the
    existing already-taken guard. The dose action sheet mirrors this in
    the UI: `showDoseActionSheet` takes a `canTake` flag (wired from
    `med.supply >= 1` at both call sites, Home and Detail) and hides the
    "Mark as taken" button when out of stock, swapping the body copy for
    `doseSheetOutOfStock` ("No pills left — refill before marking this
    dose taken.") so the remaining "Mark as rejected"/"Cancel" options
    aren't presented as if taking were still possible. Test added:
    `markTaken is a no-op when supply is 0`. 31 tests green, `flutter
    analyze` clean, `dart format .` clean. Verified live: added a
    2-dose-slot medicine with 1 pill, marked the first dose taken
    (supply → 0), then tapped the second dose's check — the sheet showed
    the out-of-stock message with no "Mark as taken" button, only
    "Mark as rejected" and "Cancel".
  - **Add medicine: Save button disabled until name + pills are valid.**
    `_AddMedicinePageState._canSave` mirrors the exact validation
    `DataNotifier.addMedicine` already applies (non-empty name, pill
    count parses to ≥ 1) and drives the Save button's `onTap`
    (`null` when invalid — no silent no-op tap anymore), background
    color (`AppColors.muted3` vs `primary`), and shadow (dropped when
    disabled). MEDICINE NAME and PILLS labels gained a small red `*`
    (`_FieldLabel(..., isRequired: true)`) and a hint line
    (`addSaveRequirementsHint`, en/uk) appears above the button while
    it's disabled: "Enter a medicine name and at least 1 pill to
    save." `flutter analyze` clean, `dart format .` clean, 31 tests
    green (no test change needed — behavior wasn't previously covered
    by a widget test). Verified live: opened Add with both fields
    empty (button greyed, hint visible, both labels starred); typed a
    name only (still greyed); typed "5" into PILLS (button turned
    blue with its shadow immediately, hint disappeared) — confirmed
    reactive on every keystroke via the existing `addFormProvider`
    watch, not just on save-attempt.
  - **`Medicines.supply` dropped — pill count is now purely derived
    from the ledger.** Previously the column and `SupplyTransactions`
    were kept in lockstep by every write path (belt-and-suspenders);
    now there's exactly one source of truth. DB: `schemaVersion` 6 → 7,
    `ALTER TABLE medicines DROP COLUMN supply` (no backfill — the
    ledger was already consistent, see §7). Repository:
    `MedicineRepository._supplyTotals()` (batch, used by `loadAll`) and
    `_currentSupply(medId)` (single medicine, used by `refillMedicine`
    to compute its delta) both fold `SupplyTransactions.delta` in
    Dart rather than a SQL aggregate; `_toMedicine` clamps the summed
    total to `0..cap` only when building the domain `Medicine` — the
    ledger rows themselves are never rewritten or clamped.
    `_adjustSupply` (renamed `_logSupplyTransaction`) no longer reads
    or writes `Medicines` at all — it's a single ledger insert.
    `_toCompanion`/`addMedicine`'s DB write no longer sets `supply`
    (the domain `Medicine.supply` field is unchanged; only its
    *storage* moved). `DataNotifier` and every UI/selector were
    untouched — they only ever read the in-memory `Medicine.supply`
    field, never the DB column directly. Tests:
    `test/support/seed_test_data.dart` now seeds an `'initial'`
    `SupplyTransactions` row per medicine instead of a `supply:` value
    on the `MedicinesCompanion`; no assertions changed since the
    computed values are identical to what was previously stored — 31
    tests green with zero test-logic changes beyond the seed helper.
    `flutter analyze` clean, `dart format .` clean. Verified live
    against the real, already-v6 on-device database: app launched
    without error (confirming the drop-column migration ran cleanly),
    Refills screen showed the same pill counts as before the change
    (Zinc 60, others matching), and marking a dose taken still
    correctly decremented the displayed count (60 → 59) purely via the
    new ledger-sum code path.
  - **Follow-up bug, caught by the user:** after marking a dose taken,
    tapping a medicine's Refills button still showed the old (unchanged)
    pill count in the sheet, not the just-decremented one. Root cause:
    `_RefillSheetState._controller` in `refill_sheet.dart` pre-filled
    from `widget.med.cap` (the fixed full-pack size, which a `take`
    never touches) instead of `widget.med.supply` (the current
    remaining count, which does). This predates the ledger refactor —
    it only became visible once marking a dose taken started actually
    changing supply. Fixed by pre-filling from `.supply` instead of
    `.cap`, matching the sheet's own prompt ("How many pills do you
    have now?"). `flutter analyze` clean, `dart format .` clean, 31
    tests green (no existing test covered this pre-fill value).
    Verified live: marked Zinc taken (60 → 59 on the Refills row),
    opened its refill sheet, and confirmed the field now shows "59"
    instead of the stale "60".
  - **Critical fix, caught by the user: dose taken/rejected status
    never actually persisted across an app restart.** Reported as
    "application doesnt save reminder status after restart." Root
    cause (see §7's v7→v8 note and §8's migration-test note for full
    detail): `DoseLog`'s physical PRIMARY KEY was silently stuck at the
    pre-v5 `(iso, medId)` on every real device, because the v4→v5
    migration added `doseTimeId` via `m.addColumn` — which cannot
    change a PRIMARY KEY. `setDoseStatus`'s `insertOnConflictUpdate`
    targets the Dart-declared 3-column key, which SQLite rejects when
    it doesn't match a real constraint, so every "mark taken"/"mark
    rejected" write threw inside `_guard`, was logged and swallowed,
    and never reached disk — while the optimistic in-memory UI state
    looked correct until the next restart reloaded from the untouched
    table. This was completely invisible to the test suite, which only
    ever exercises fresh in-memory databases (always built via
    `onCreate` from the *current* schema, never through a real
    `onUpgrade` chain). `schemaVersion` 7 → 8; new migration renames
    the old table, recreates `dose_log` from the current definition,
    copies rows across, drops the renamed original.
    - Confirmed root cause by direct inspection: queried the live
      simulator's on-disk `pillpal.sqlite` via the `sqlite3` CLI and
      found `PRIMARY KEY ("iso", "med_id")` — missing `dose_time_id`
      entirely — despite the Dart table having declared the 3-column
      key since v5.
    - Added `test/dose_log_migration_test.dart`, which hand-builds a
      temp-file database replicating that exact broken schema, runs it
      through `AppDatabase`'s real migration strategy, and asserts two
      independent dose slots on the same day both survive
      `insertOnConflictUpdate` without colliding or throwing. Verified
      the test actually catches the regression (not a tautology) by
      temporarily reverting the fix and re-running it — it failed with
      the exact production error, `SqliteException: ON CONFLICT clause
      does not match any PRIMARY KEY or UNIQUE constraint`.
    - Added `sqlite3` as an explicit `dev_dependency` (was only
      transitive via drift) since the new test imports it directly to
      construct the fixture.
    - 32 tests green, `flutter analyze` clean, `dart format .` clean.
    - Verified live against the actual broken on-device database (not
      a fresh install): relaunched the app, confirmed
      `PRAGMA user_version` went 7 → 8 and `dose_log`'s schema now
      reads `PRIMARY KEY ("iso", "med_id", "dose_time_id")`; marked a
      dose taken and confirmed the row landed on disk via direct
      `sqlite3` query (previously would have silently failed); then
      did a **true restart** — `xcrun simctl terminate` +
      `xcrun simctl launch` on the already-installed binary, not a
      `flutter run` rebuild — and confirmed the taken status survived,
      where before the fix it reverted to pending every time.
  - **Follow-up hardening, requested by the user: surface write
    failures via an error snackbar instead of swallowing them.** Every
    `DataNotifier` mutation method (`markTaken`, `markRejected`,
    `revertDose`, `addMedicine`, `refillMedicine`, `deleteMedicine`,
    `toggleSetting`, `setLocaleOverride`, `toggleNotif`) now passes the
    `Either` its repository call returns through a new
    `_reportIfFailed` helper; on `Left`, it reports the `AppException`
    into a new `errorNotifierProvider`
    (`lib/core/state/error_notifier.dart`, a bare
    `Notifier<AppException?>`). `_PillpalAppState.build()`
    (`lib/app.dart`) listens on that provider and shows a `SnackBar`
    via a `GlobalKey<ScaffoldMessengerState>` using
    `AppExceptionL10n.message(l10n)` for the text, then clears the
    provider so the same failure can't re-fire. See §7a for the full
    design (including why the snackbar's `l10n` comes from the
    `ScaffoldMessengerState`'s own context rather than `build()`'s
    `context` argument, and the still-open question of whether a
    failed write should also roll back its optimistic UI update — it
    currently doesn't).
    - Added `test/error_snackbar_test.dart`: forces a real write
      failure by closing the in-memory DB mid-test, then asserts a
      `SnackBar` renders. Verified it's not a tautology by temporarily
      deleting the `ref.listen` block and confirming the test then
      fails — restored immediately after.
    - 33 tests green, `flutter analyze` clean, `dart format .` clean.
    - Verified live: relaunched the app, confirmed the happy path is
      unaffected (marking a dose taken shows no snackbar, works
      exactly as before) — a live forced-failure repro on-device was
      not attempted since it would require destructively corrupting
      the app's real database file mid-session; the widget test
      already exercises the real `PillpalApp` widget tree end to end
      (real providers, real `SnackBar`, real repository write) and was
      confirmed to fail without the fix, which was judged sufficient.
  - **Transactions screen** (§6, §6a): a filterable read view over the
    supply ledger, reached from History. Added
    `MedicineRepository.loadTransactions()`, `transactionsProvider` /
    `transactionFilterProvider`, `Selectors.transactions` (joins ledger
    rows with medicine names, applies the medicine/interval filter),
    `TransactionsPage` + `TransactionTile` / `TransactionFilterBar`
    widgets, and a `TransactionsRoute`.
    - Repository test: `loadTransactions` returns the ledger newest
      first (pinned to two distinct `Clock.fixed` timestamps so the
      ordering assertion isn't relying on two same-millisecond writes).
    - Widget test (`test/transactions_page_test.dart`): navigates
      Settings → History → Transactions and asserts every seeded
      medicine's initial-stock row renders; a second test selects a
      medicine from the filter dropdown and asserts the list narrows
      to just that medicine's rows.
    - 36 tests green, `flutter analyze` clean, `dart format .` clean.
    - Verified live on the simulator against the real on-device
      database (not a fresh seed): the ledger rendered real
      take/revert/initial-stock history with correct icons, labels,
      and signed deltas; the medicine dropdown and interval segmented
      control both updated the list live; back-navigation to History
      worked cleanly; no overflow or exceptions in the run log.
  - **Reminder toggle now actually excludes a medicine from today's
    tracking** (§6, §6a), per user feedback that the switch previously
    did nothing observable. `DataState.allTaken` and a new
    `Selectors._activeOccurrences` helper both filter by
    `reminderOn(medId)`; `periods`, `progress`, and `dayAgenda` were
    switched to the active variant, so a reminder-off medicine
    disappears from the Home list, the "doses left today" count,
    Calendar's agenda/reminder count, and can't block the Done
    celebration. `history()` deliberately keeps using the unfiltered
    `_occurrences`, and Detail/Refills read `med.times`/`data.meds`
    directly, so none of those change — the medicine stays fully
    manageable, just muted from active reminders.
    - Added `test/reminder_off_test.dart` (pure `Selectors`/`DataState`
      unit tests: `periods`, `progress`, `dayAgenda`, and `allTaken`
      all exclude a reminder-off medicine; `refills` doesn't) and
      `test/reminder_toggle_test.dart` (end-to-end: toggling a
      medicine's reminder off in the running app hides it from Home,
      toggling it back on restores it).
    - 43 tests green, `flutter analyze` clean, `dart format .` clean.
    - Verified live on the simulator against the real on-device data:
      turning off "Zinc"'s reminder dropped it from the Home list and
      the doses-left count (9 → 8) immediately; turning it back on
      restored both; no overflow or exceptions in the run log.
  - **Animated splash screen** (§5, §6): `SplashPage` is now the app's
    `initial` route, replacing `DashboardRoute` as the very first thing
    shown. A staggered pop-in/fade/slide sequence (brand badge → title →
    tagline → loading dots) plays over `AppColors.primary`, styled to
    match `DonePage`'s existing "moment" screens; it hands off to the
    dashboard once `dataProvider` and `medicineRegistryProvider` have
    both settled (success or failure — each load is wrapped so a
    failure doesn't strand the splash) and a 1400ms minimum has
    elapsed, via `context.router.replace`.
    - Added `test/splash_test.dart`: asserts the splash's title/tagline
      render on the very first frame and Home hasn't rendered yet, then
      asserts the reverse after `pumpAndSettle`.
    - 44 tests green, `flutter analyze` clean, `dart format .` clean.
    - Verified live on the simulator, including a true kill + relaunch
      of the installed binary (`xcrun simctl terminate` +
      `simctl launch`, not just `flutter run`'s first attach): the
      badge, title, tagline, and pulsing dots all rendered correctly on
      the primary background with white status-bar icons, and it handed
      off cleanly to Home; no overflow or exceptions in the run log.
  - **Branded the Android native pre-engine splash** (§6), after a user
    screenshot showed the unmodified `flutter create` template — the
    default Flutter mascot icon on a black background — appearing
    before Dart's own `SplashPage` ever got a chance to render on
    Android 12+. Added `androidx.core:core-splashscreen`, a hand-written
    `ic_splash_pill.xml` vector (mirrors `PillShape`'s capsule), and
    reworked `LaunchTheme` (both `values/` and `values-night/`) to
    extend `Theme.SplashScreen` with the app's brand color/icon;
    `MainActivity.onCreate` now calls `installSplashScreen()` for the
    pre-31 compat path; `launch_background.xml` was repointed from
    white to the same brand color to close the gap before Flutter's
    first frame.
    - `flutter build apk --debug` succeeds; `flutter analyze`/
      `flutter test` unaffected (44 tests green) since this is
      Android-only native configuration, no Dart changes.
    - Verified live: created a throwaway AVD from an already-cached
      `android-37.0/google_apis_playstore_ps16k` system image (API 37,
      well past the Android 12/API 31 threshold for the new Splash
      Screen API), ran the app, and captured the launch sequence via
      `adb exec-out screencap` (the emulator's raw QEMU window isn't
      addressable through the usual screenshot tooling). Multiple
      frames during a forced cold start
      (`am force-stop` + `am start`) showed the branded indigo
      background with the two-tone capsule icon — not the old mascot —
      before handing off to Home.
  - **Branded the iOS native pre-engine splash too** (§6), after the
    user pointed out a white screen preceded the Dart splash there as
    well — same root cause as Android, different mechanism (a
    still-default `LaunchScreen.storyboard`). Changed its
    `backgroundColor` from white to `AppColors.primary` and added
    `UIStatusBarStyle: UIStatusBarStyleLightContent` to `Info.plist` so
    the status bar reads against the new dark background. Left the
    storyboard's placeholder image alone (kept invisible) rather than
    adding raster icon artwork — out of proportion to a "white flash"
    complaint, unlike Android where the wrong *icon* was actually
    showing.
    - No Dart changes; `flutter analyze`/`flutter test` unaffected (44
      tests green).
    - Verified live: force-relaunched the app on the iOS Simulator
      (`xcrun simctl terminate` + `launch`) while capturing rapid
      `xcrun simctl io screenshot` frames — every captured frame showed
      the indigo background (never white), transitioning cleanly into
      Dart's `SplashPage` entrance animation with white status-bar
      icons throughout (aside from a brief few-frame black-icon flicker
      during the native-to-Flutter handoff, which is a pre-existing
      Flutter/iOS quirk unrelated to this change — it happened against
      white before too, just wasn't visible).
  - **Replaced the default Flutter template app icon on both
    platforms** (§3, "App icon") with the brand mark used by the
    splash screens. Generated a master 1024×1024 PNG via a CoreGraphics
    (`swift`) script and derived every platform-specific size with
    `sips`, rather than pulling in an icon-generation package for a
    one-off image; Android's API 26+ adaptive icon uses a pure vector
    foreground instead (no raster needed there).
    - `flutter build apk --debug` and
      `flutter build ios --debug --simulator --no-codesign` both
      succeed; no Dart changes, so `flutter analyze`/`flutter test` are
      unaffected (44 tests green).
    - Verified live on both platforms: installed the freshly built iOS
      app onto the Simulator and confirmed the Springboard icon shows
      the capsule mark instead of the Flutter logo; installed the APK
      on a freshly booted Android emulator (API 37) and confirmed the
      same via the system App Info screen (the adaptive icon, masked
      to a circle by that launcher, rendered correctly).
  - **Renamed the app from Pillpal to Pillnote**, after evaluating
    naming options against the app's actual positioning (medicine
    reminder + usage/supply manager, not just an alarm) and checking
    the shortlist against existing medicine apps to avoid collisions.
    Updated every user-facing surface: `appTitle` (en/uk ARB — this
    alone updates both `SplashPage`'s title and
    `MaterialApp.router`'s `onGenerateTitle` window/task title),
    Android's `AndroidManifest.xml` `android:label`, and iOS's
    `Info.plist` `CFBundleDisplayName`/`CFBundleName`. The root widget
    was renamed `PillpalApp` → `PillnoteApp` (and
    `_PillpalAppState` → `_PillnoteAppState`) across `lib/app.dart`,
    `lib/main.dart`, and all 9 widget tests that reference it, plus
    doc-comment mentions in `app_theme.dart`/`app_colors.dart` and
    `pubspec.yaml`'s `description`.

    Deliberately **not** changed: the Dart package name
    (`time_for_your_medicine` in `pubspec.yaml`, which every file's
    `package:` import depends on) and the Android/iOS bundle
    identifiers (`com.example.time_for_your_medicine`) — both are
    internal/technical identifiers, not user-facing branding, and
    renaming either is a much larger, riskier change (thousands of
    import statements; on iOS/Android a bundle-ID change is
    effectively a new app for signing/store-listing purposes) that
    wasn't asked for. The app icon artwork itself was also left
    unchanged, by explicit choice — the capsule-in-circle mark never
    referenced "Pillpal" and works equally well under the new name.
    Old changelog entries above that mention "Pillpal" or `PillpalApp`
    describe those specific historical commits and were left as-is,
    per this file's append-only changelog convention.
    - No behavior changes; `flutter analyze`/`flutter test` green (44
      tests, all now instantiating `PillnoteApp`).
    - Verified live on both platforms that the new name appears
      correctly: the splash screen's title, the iOS Springboard label,
      and the Android launcher label all read "Pillnote".
