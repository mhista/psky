# PSKY (ahiaa_web)

Brief: PSKY is a Flutter web-first application (also works on mobile) that
provides a multi-feature platform built with modular feature folders,
dependency-injection, and a combination of `flutter_bloc` + `Get` utilities.

Key goals of this README:
- Explain the high-level architecture and important directories.
- Provide exact commands for common developer workflows (run, build, codegen).
- Call out project-specific conventions (DI, routing, codegen, timezone handling).

---

**Quick start (Windows PowerShell)**

1. Install Flutter and ensure `flutter` is on your PATH.
2. From the project root:

```powershell
flutter pub get
# Generate DI and serializable code when changing models/annotations
flutter pub run build_runner build --delete-conflicting-outputs
# Run for web (Chrome)
flutter run -d chrome
# Or run the web build
flutter build web
```

---

**High-level architecture**

- Entry: `lib/main.dart` — initializes DI (`configureDependencies()`), storage
	(`GetStorage.init()`), timezone data, and bootstraps the app via `App()`.
- App shell: `lib/app.dart` — returns `ShadcnApp.router` and wires the
	`routerConfig` provided by `getIt<AppRouter>().router`. Themes come from
	`lib/core/utils/theme/theme.dart` (used as `TAppTheme.lightTheme`).
- Feature folders: `lib/features/*` — each feature contains its own
	presentation, domain (entities/use-cases), and data layer where applicable.
- Core: `lib/core/` — DI containers (`core/injectable`), routing helpers
	(`core/routes/`), shared widgets, utilities, and constants.
- State management: `flutter_bloc` is used (see `lib/bloc_providers.dart`) and
	`Get`/`GetStorage` is used in some places for local storage and simple state.
- Dependency injection: `get_it` + `injectable`. Generated code requires
	`build_runner` and `injectable_generator` to be run after changes.

---

**Important files & directories (referenced in code)**

- `pubspec.yaml` — dependency list and asset/font declarations (Urbanist font).
- `lib/main.dart` — app bootstrap, timezone setup (uses `timezone` package).
- `lib/app.dart` — app shell, router, responsive breakpoints, and localization
	delegates (e.g., `FlutterQuillLocalizations.delegate`).
- `lib/firebase_options.dart` — generated Firebase config (web platform values).
- `lib/core/injectable/` — DI registration and `configureDependencies()`.
- `lib/core/routes/` — router and route definitions (AppRouter used via `getIt`).
- `lib/features/` — feature modules (authentication, dashboard, practice_exam,
	etc.). Follow the existing folder layout when adding new features.

---

**Code generation & common maintenance tasks**

- Run codegen after changing annotated classes (injectable, json_serializable,
	freezed):

```powershell
flutter pub run build_runner build --delete-conflicting-outputs
```

- If you need continuous codegen during development:

```powershell
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

**Running & debugging**

- Web (Chrome): `flutter run -d chrome`
- Web (production build): `flutter build web`
- Mobile (Android/iOS): connect device/emulator and `flutter run`
- To run tests: `flutter test` (there is a widget test at `test/widget_test.dart`).

Notes:
- The app uses `usePathUrlStrategy()` for clean web URLs (set in `main.dart`).
- Timezone initialization for web is handled in `main.dart` by using
	`timezone/data/latest.dart` and setting location to `Africa/Lagos`.

---

**Firebase**

- The project includes `lib/firebase_options.dart` (FlutterFire CLI generated)
	and uses `DefaultFirebaseOptions.currentPlatform` to initialize Firebase for
	web. If you regenerate Firebase config, re-run the FlutterFire CLI and
	update this file.

---

**Conventions & patterns specific to this project**

- Feature-first layout: each feature under `lib/features/<feature>` may have
	`presentation`, `data`, and `domain` subfolders. Follow existing naming.
- Dependency injection: use `@Injectable()` annotations and call
	`configureDependencies()` from `main.dart`. Use `getIt<T>()` to access
	injected instances (see `lib/app.dart` for `AppRouter`).
- Routing: `getIt<AppRouter>().router` is provided to the app shell — prefer
	central router definitions in `lib/core/routes/`.
- Coding style: project already uses `flutter_lints` and `custom_lint`. Keep
	changes focused and run `flutter analyze` before PRs.

---

**Common pitfalls & troubleshooting**

- If you add or change injectable bindings and get runtime DI errors, regenerate
	code via `build_runner` and restart the app.
- If web routing behaves oddly, make sure `usePathUrlStrategy()` is active
	(it's already set for web in `main.dart`).
- If Firebase throws UnsupportedError on non-web platforms, the `firebase_options`
	file currently contains only `web` config — run the FlutterFire CLI to add
	mobile platform configs.

---

**CI / GitHub Actions**

This project benefits from a CI pipeline that runs codegen, analysis, tests,
and builds the web artifact. Below is a recommended GitHub Actions workflow that
you can place in `.github/workflows/flutter-ci.yml`.

- Caching: we cache `~/.pub-cache` and the build outputs for faster runs.
- Codegen: runs `build_runner` to ensure generated DI and serializable code is
	up-to-date (required for `injectable` and `json_serializable` changes).
- Tests & analysis: runs `flutter analyze` and `flutter test`.
- Build: produces a web release artifact via `flutter build web`.
- Optional deploy: the workflow includes an optional Firebase Hosting deploy
	step. To enable it, set the `FIREBASE_TOKEN` secret in the repository (see
	instructions below).

Example workflow (`.github/workflows/flutter-ci.yml`):

```yaml
name: Flutter CI

on:
	push:
		branches: [ main ]
	pull_request:
		branches: [ main ]

jobs:
	build:
		runs-on: ubuntu-latest
		steps:
			- uses: actions/checkout@v4

			- name: Set up Flutter
				uses: subosito/flutter-action@v2
				with:
					flutter-version: 'stable'

			- name: Cache pub
				uses: actions/cache@v4
				with:
					path: |
						~/.pub-cache
						~/.pub-cache/global
					key: ${{ runner.os }}-pub-${{ hashFiles('**/pubspec.yaml') }}

			- name: Install dependencies
				run: flutter pub get

			- name: Generate code (build_runner)
				run: flutter pub run build_runner build --delete-conflicting-outputs

			- name: Static analysis
				run: flutter analyze

			- name: Run tests
				run: flutter test --machine

			- name: Build web
				run: flutter build web --release

			# Optional: Deploy to Firebase Hosting when FIREBASE_TOKEN is set
			- name: Deploy to Firebase Hosting
				if: ${{ secrets.FIREBASE_TOKEN != '' }}
				env:
					FIREBASE_TOKEN: ${{ secrets.FIREBASE_TOKEN }}
				run: |
					npm install -g firebase-tools
					firebase deploy --only hosting --token "$FIREBASE_TOKEN"
```

How to create a `FIREBASE_TOKEN` (local steps, Windows PowerShell):

```powershell
# Install Firebase tools locally if needed
npm install -g firebase-tools
# Login and generate a CI token
firebase login:ci
# The command prints a token; copy it and add to GitHub Secrets
```

Add the token in GitHub repository settings → Secrets → Actions as
`FIREBASE_TOKEN`.

Notes & tips:
- If your repo has long-running codegen or heavy build steps, consider using
	`actions/cache` for the `.dart_tool` and `build` directories as well.
- For secure deployment to Firebase using a service account, you can use the
	`FirebaseExtended/action-hosting-deploy` action with a GitHub secret that
	contains a GCP service account key (JSON). The above example uses the
	simpler `FIREBASE_TOKEN` approach.
- If you prefer deploying to GitHub Pages, use `peaceiris/actions-gh-pages` to
	publish the `build/web` directory.


If you'd like, I can also:
- Generate a developer onboarding checklist with exact commands for Windows
	PowerShell and CI snippets for GitHub Actions.
- Produce a short contributor guide describing branch naming, testing, and PR
	checks used by this project.

Please tell me which of those you'd like next, or give feedback to refine this
README.
