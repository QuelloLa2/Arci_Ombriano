# AGENTS.md — Arci Ombriano

## Project

- **Type:** Flutter app (single-package)
- **Package name:** `arci_ombriano`
- **Dart SDK:** `^3.10.4`
- **Locale:** `it_IT` only

## Commands

| Action | Command |
|---|---|
| Install deps | `flutter pub get` |
| Run app | `flutter run` |
| Run on web | `flutter run -d chrome` |
| Run on Android | `flutter run -d android` |
| Lint/analyze | `flutter analyze` |
| Run all tests | `flutter test` |
| Run single test | `flutter test test/widget_test.dart` |
| Format | `dart format .` |

## Architecture

All state lives in `MyHomePage` (`lib/main.dart`). Three bottom-nav pages receive data via props:

- **Calendar** (`lib/Calendar/calendar_page.dart`) — uses `table_calendar` package
- **Events** (`lib/Event/event_page.dart`) — list + detail, admin can CRUD
- **Settings** (`lib/Setting/setting_page.dart`) — user info, logout

### Directory ownership

- `lib/API/` — HTTP calls (dio + http), no auth token in URL; token passed via headers
- `lib/Account/` — signin / signup screens
- `lib/Admin/` — admin-only event creation/editing widgets
- `lib/Utils/` — shared models (`User`, `Event`, `Role`) and `storage` (flutter_secure_storage wrapper)
- `lib/Appbar/` — custom top bar
- `assets/Images/` — image assets
- `assets/Fonts/` — Poppins (400, 500, 600, 700)

### Auth flow

Token, user_id, user_name, is_admin stored via `flutter_secure_storage` (keyed strings). App checks these on launch; if missing, shows `SigninPage`. On login success, events are fetched from the API.

## Testing

- Single test file `test/widget_test.dart` is the Flutter default (counter smoke test) and is **stale** — the app has no counter. Update or replace before relying on test results.
- No integration tests or mocks exist. API calls hit real endpoints.

## Gotchas

- `main()` calls `initializeDateFormatting('it_IT', null)` — required for `table_calendar` Italian locale
- `pubspec.lock` is gitignored; always run `flutter pub get` after cloning
- No CI configured; no pre-commit hooks
