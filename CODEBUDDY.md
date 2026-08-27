# CODEBUDDY.md This file provides guidance to CodeBuddy when working with code in this repository.

This repository (`flutter_empty`) is an empty Flutter app template with commonly used dependencies already initialized, intended as a fast starting point for business development. Flutter is managed via **FVM** (pinned to Flutter 3.38.5, Dart SDK `^3.10.4`, see `.fvmrc`).

## Commands

All commands must be run with `fvm` so the pinned Flutter version is used. Never call bare `flutter`.

- **Get dependencies**: `fvm flutter pub get`
- **Run the app**: `fvm flutter run` (add `-d <deviceId>` to target a specific device)
- **Analyze / lint**: `fvm flutter analyze` (uses `analysis_options.yaml`, which includes `package:flutter_lints/flutter.yaml`)
- **Run all tests**: `fvm flutter test`
- **Run a single test file**: `fvm flutter test test/models/demo_test.dart`
- **Run tests matching a name**: `fvm flutter test --plain-name "Demo"`
- **Generate JSON models** from `jsons/` into `lib/models/`: `fvm dart run json_to_model`
- **Run codegen** for `retrofit` / `mobx` (`.g.dart` files): `fvm dart run build_runner build --delete-conflicting-outputs` (use `watch` to auto-rebuild)
- **Build release APK**: `fvm flutter build apk --release`
- **Build iOS**: `fvm flutter build ios --release`
- **Check dependency updates**: `fvm flutter pub outdated`

## Architecture

This is a **Cupertino-styled** app (`CupertinoApp` in `lib/main.dart`, not MaterialApp). It uses iOS-style navigation and `CupertinoTextThemeData`. The structure is intentionally lean and split into a few top-level concerns under `lib/`.

### Entry point and navigation

- `lib/main.dart` defines `MyApp` (root `CupertinoApp`) plus a global `routes` map: `/` maps to `Application` and `main` maps to `Homepage`. Navigation is done by **name-based routing** via the `ContextExtension.pushPageString` extension (e.g. `context.pushPageString("main")`). `Application` is a thin StatefulWidget that immediately pushes the `main` route.
- `MyApp` exposes a static `appContext` (the root `BuildContext`) and wires `BotToast` (`botToastBuilder` + `BotToastNavigatorObserver`) and the `lifecycle` package's `defaultLifecycleObserver` as navigator observers. Localization delegates for Material/Cupertino/Widgets are registered.

### `lib/common.dart` — global constants and helpers

Central hub with app-wide values used across the app:
- `appName`, `logger` (from the `logger` package), `FutureFunction` typedef.
- Screen-dimension getters based on `MyApp.appContext` and `devicePixelRatio`: `screenWidth`, `screenHeight`, `statusBarHeight`, `navBarHeight`, `statusAndNavbarHeight`, `minScreen`.
- Platform flags `isAndroid` / `isIOS`, and `isPad` (derived from `minScreen >= 500`).

### `lib/extensions/` — idiomatic helpers (heavy reliance on extensions)

Extensions are a core design pattern here; nearly every file under `lib/` imports them.

- `context_extension.dart`: `pushPageString(name, {arguments})` for named-route push, `pop<T>({result})`, and `arguments` / `argumentObj` getters that read `ModalRoute` settings (page arguments are passed as `Object?`).
- `string_extension.dart`: `.toast` (shows a `BotToast` text toast and returns the string), `.md5` (MD5 hash via `crypto`), `.hexColor` (parses a hex string to `Color`).
- `int_extension.dart`: `.pt` / `.ptInt` for responsive scaling (scales `this` against `minScreen` and a base of 375.0 phone / 768.0 tablet), plus `.asStringTime` / `.asStringTimeSecond` for time formatting.
- `obj_extension.dart`: `.p` (debug `logger.i`), `.e` (debug `logger.e`) — handy logging shortcuts that return the object.
- `hex_color.dart`: `HexColor` class and `parse` to build `Color` from `#RRGGBB` or `#AARRGGBB` strings.
- `kotlin_func.dart`: `runCatching<T>()` — Kotlin-style try/catch returning nullable `T?`.

### `lib/models/` — JSON models with code generation

Models are **generated from JSON files** in the `jsons/` directory by running `fvm dart run json_to_model` (the `json_to_model` dev dependency). Output models land in `lib/models/`. Generated files are committed; treat them as outputs of `jsons/*.json` and regenerate rather than hand-editing unless necessary.

The JSON schema uses special syntax: keys ending in `?` mark optional fields (e.g. `"likes?": [""]`), and `"$[]demo_value"` references a sub-model file (`demo_value.json`) to produce a `List<DemoValue>`. Each generated class (`Demo`, `DemoValue`) is `@immutable` and includes `fromJson`/`toJson`, `clone`, `copyWith`, and `==`/`hashCode`. `index.dart` re-exports all models and provides `checkOptional<T>()` (using `quiver`'s `Optional`) to support nullable `copyWith` semantics.

### `lib/ui/` — screens

`lib/ui/main/homePage.dart` shows the pattern for pages: a `StatefulWidget` returning a `CupertinoPageScaffold` with a `CupertinoNavigationBar`, using `IntExtension.pt` for responsive sizing and `AnyImageView` for image assets (SVG/network/etc. with shimmer loading). Add new screens under `lib/ui/` and register them in the `routes` map.

## Conventions and constraints (from README)

- Keep the current code style; do not modify third-party library sources.
- To upgrade a dependency, upgrade the upstream library first.
- Focus on business code only; do not touch scaffolding.
- Mind memory management — avoid leaks.
- Add comments to generated classes, methods, and procedures; do not delete existing comments.
- Network issues are handled by humans, not code workarounds.
- Always use `fvm` for Flutter/Dart tooling.
