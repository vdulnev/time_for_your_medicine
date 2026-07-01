# Pillpal — Medicine Reminder · Flutter Implementation Spec

Flutter implementation of the **Pillpal** medicine-reminder app, recreated
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

There is **no network layer** (no Dio/Retrofit) — Pillpal is local-only.

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

- `DashboardRoute` wraps the four bottom-nav tabs in an
  `AutoTabsScaffold`: **Home**, **Calendar**, **Refills**, **Settings**,
  with the floating center **+** FAB pushing `AddRoute`.
- Pushed full-screen routes (no bottom nav): `AddRoute`,
  `DetailRoute(medId)`, `DoneRoute`, `HistoryRoute`, `NotificationsRoute`.
- The "all doses taken" celebration: after `toggleTaken` reports the day
  just completed, the calling widget `router.push(const DoneRoute())`.
- Delete confirmation is shown via `showModalBottomSheet` /
  `DeleteDialog` from the detail page.
- Status-bar tint is set per-page with `AnnotatedRegion` (indigo on
  detail/done).

---

## 6. Screens

1. **Home** — day header + prev/next, notifications & calendar buttons,
   week strip, progress ring card (→ history), dose-occurrence list grouped
   by period (a medicine with several daily doses appears once per slot,
   each independently toggleable), tap-to-toggle check, tap tile → detail.
2. **Calendar** — month grid with today/selected/dots, day agenda (one row
   per dose occurrence), "Open this day" CTA.
3. **Add medicine** — photo placeholder, name/dose fields, a repeatable
   list of time + time-of-day slots ("+ Add another time" / remove per
   row, minimum 1) so a medicine can be scheduled several times a day,
   food choice, Save.
4. **Detail** — indigo header, next/food/left stat cards (NEXT shows the
   earliest untaken slot today, "+N" suffixed when there's more than one),
   last-7-days row (a day counts as done only once every slot is taken),
   a "today's doses" list with one independent taken toggle per slot,
   delete.
5. **Done** — celebration (pop check + confetti dots), doses/streak stats,
   view-tomorrow / back-to-today.
6. **History** — 7-day adherence card, bar chart, summary rows.
7. **Refills** — low-supply alert, per-med supply bars + order button.
8. **Reminders** — per-med reminder switches.
9. **Settings** — profile, preference switches, navigation rows.

---

## 7. Persistence (drift)

`AppDatabase` (`@DriftDatabase`, SQLite via `drift_flutter`):

| Table | Columns |
|---|---|
| `Medicines` | id (PK text), name, dose, withFood, kind, c1, c2 (nullable), soft, supply, cap |
| `DoseTimes` | medId (text), id (text), time, period, sortOrder — PK (medId, id) |
| `DoseLog` | iso (text), medId (text), doseTimeId (text), taken (bool) — PK (iso, medId, doseTimeId) |
| `SettingsRows` | id (PK, single row = 0), sound, vibrate, refill, localeOverride (nullable text) |
| `NotifOffRows` | medId (PK text) — presence means reminder disabled |
| `MedicineRegistryEntries` / `MedicineRegistryMeta` | imported medicine-name lookup data (search, CSV import) |

`schemaVersion = 5`. Migrations are **append-only** — never edit a past
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

---

## 7a. Error handling

- `AppException` — `@freezed` sealed union:
  `databaseFailure(message)`, `notFound(id)`, `unknown(error)`.
- Repositories catch drift/SQLite errors and map to `Left(AppException)`.
- `dataProvider` folds the `Either` inside `AsyncValue.guard`; failures
  surface as `AsyncValue.error` and render via a shared `ErrorView`.
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
