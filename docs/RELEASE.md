# Releasing ReservMe mobile

What has to be true before a build goes anywhere, and how to make one.

> **The backend does not exist yet.** Every `Feature` flag in
> `lib/core/config/feature_availability.dart` is `false`, so a `real` build
> today signs in nowhere and browses nothing — it refuses each gated call with
> a 501 rather than hitting a 404. Until the backend plan ships, a release
> build is for testing the shell, the icon, the splash and the deep links, not
> for the store.

## Before every release

```bash
dart run build_runner build      # generated code is committed; CI checks freshness
flutter analyze                  # must be clean
flutter test                     # must be green
```

`analyze` and `test` both pass with **stale** generated files. Only CI notices,
so run `build_runner` after your last source edit, not before it.

## Build-time configuration

Nothing secret lives in `--dart-define`. `release.json` holds the four values a
store build needs and is committed on purpose:

```json
{ "API_MODE": "real", "SERVER_URL": "…", "PUBLIC_ORIGIN": "…", "APP_ORIGIN": "…" }
```

```bash
flutter build appbundle --dart-define-from-file=release.json
```

A `fake` build is a complete, offline demo of the whole app — useful for
showing a venue what it will be like before the API exists:

```bash
flutter build apk --dart-define=API_MODE=fake
```

## Signing (Android)

`android/app/build.gradle.kts` reads `android/key.properties`, which is
gitignored. Without it, a release build falls back to the debug key so
`flutter build` still works on a machine that has no keystore — convenient, and
worth knowing, because a build that "worked" may not be signed with the upload
key.

Create the upload key once:

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Then `android/key.properties`:

```properties
storePassword=…
keyPassword=…
keyAlias=upload
storeFile=/absolute/path/to/upload-keystore.jks
```

Keep the keystore and this file out of the repo and backed up somewhere you
will still have in five years. Losing the upload key means a new app listing.

Check what a build was actually signed with:

```bash
jarsigner -verify -verbose -certs build/app/outputs/bundle/release/app-release.aab | head
```

## iOS

The Mac steps are in [MAC-SETUP.md](MAC-SETUP.md). Two things are not wired by
the files in this repo and have to be done in Xcode once:

- **Associated Domains.** `ios/Runner/Runner.entitlements` exists but is not
  attached to the target. Runner → Signing & Capabilities → + Capability →
  Associated Domains, then confirm `applinks:reservme.pro` is listed.
- **Signing team and bundle id** (`pro.reservme.app`).

## Deep links

Both platforms verify ownership of `reservme.pro` by fetching a file from the
apex — which the **marketing site** serves, not this app and not the dashboard.
Neither is hosted yet, so links currently open with a chooser instead of going
straight to the app. That is a backend/marketing task, tracked in
`docs/API-CONTRACT.md`.

- Android: `https://reservme.pro/.well-known/assetlinks.json`
- iOS: `https://reservme.pro/.well-known/apple-app-site-association`

Test a link against a build without any of that:

```bash
adb shell am start -W -a android.intent.action.VIEW \
  -d "https://reservme.pro/katipunan" pro.reservme.app
adb shell am start -W -a android.intent.action.VIEW \
  -d "reservme://katipunan/manage/tok-123" pro.reservme.app
```

The first should open the venue page, the second should import the booking
into the wallet. A link to `reservme.pro/privacy` should open a browser, not
the app.

## Icons and splash

Both are generated from `assets/brand/`. Regenerate after changing them:

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

## Store listing

`STORE-LISTING.md` holds the copy, the data-safety answers and the screenshot
list. Nothing there is filed yet.

## What is still open

`docs/DEFERRED.md` is the list. The ones that block a store submission:

- **D18** — the flow has never been walked on a device.
- **D2b** — the onboarding photos are AI-generated placeholders.
- **D13** — the backend. Without it there is nothing to release *to*.
