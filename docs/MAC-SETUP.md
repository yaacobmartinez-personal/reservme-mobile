# Building the iOS app on a Mac

The Android side is developed on Windows; iOS needs a Mac with Xcode. This is
the one-time setup plus the per-session routine. Nothing here changes the
code — the iOS project is already configured (bundle id `pro.reservme.app`,
iOS 15.0 minimum, the `reservme://` URL scheme, and an associated-domains
entitlements file).

> **There is no backend.** Every `Feature` flag is `false`, so a `real` build
> signs in nowhere and browses nothing. Use `--dart-define=API_MODE=fake` for
> everything here: it is a complete offline world with two venues, four
> courts, a studio on Madrid time, sixty-odd bookings and demo staff accounts.

## 1. One-time: tools

```bash
# Xcode from the App Store (≈ 15 GB; 16.x or newer), then:
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
xcodebuild -version

# CocoaPods (Flutter's iOS plugins are wired through it)
brew install cocoapods        # or: sudo gem install cocoapods
pod --version

# Flutter — same channel and version as the Windows machine (3.47.x stable)
git clone -b stable https://github.com/flutter/flutter.git ~/dev/flutter
echo 'export PATH="$HOME/dev/flutter/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
flutter --version
flutter config --no-analytics
flutter doctor            # Xcode + CocoaPods must be green; Android/Chrome can stay red
```

If `flutter doctor` complains about the iOS simulator, open Xcode once and
install the iOS platform when it asks (Settings → Platforms).

## 2. One-time: Apple account in Xcode

Xcode → Settings → Accounts → **+** → sign in with your Apple ID. This creates
a **Personal Team**, which is enough for everything here except §7: the
simulator without limits, and your own iPhone over USB with builds that expire
after 7 days (just run again).

**Use the Apple ID that will later hold the Developer Program membership.**
Building `pro.reservme.app` under a Personal Team ties that bundle id to the
Apple ID; joining the Program with the same ID upgrades cleanly. If the paid
account will be a different one, set the bundle id to `pro.reservme.app.dev`
in Xcode for the free phase and do not commit it.

## 3. Clone and open

```bash
git clone https://github.com/yaacobmartinez-personal/reservme-mobile.git ~/dev/reservme
cd ~/dev/reservme
flutter pub get
open -a Simulator
flutter run --dart-define=API_MODE=fake
```

The first run creates `ios/Podfile` and `Runner.xcworkspace` and runs
`pod install` itself — there is nothing to do by hand. If it stops on
"requires a development team", do §4 and run again.

For anything in Xcode, open the **workspace** — never the project — or the
pods will not resolve:

```bash
open ios/Runner.xcworkspace
```

## 4. One-time: signing in Xcode

Select **Runner** (project) → **Runner** (target) → **Signing & Capabilities**:

- **Automatically manage signing** ✓, **Team** = your team. Xcode creates the
  App ID `pro.reservme.app` and a development profile.
- Do the same for the `RunnerTests` target if Xcode nags about it.

**With a Personal Team, stop here.** Associated Domains is paid-only and Xcode
refuses to build if it is present:

- Do **not** attach `Runner/Runner.entitlements`. `reservme://…` links still
  open the app; `https://reservme.pro/…` opens Safari until the membership
  exists.

**With a Developer Program team**, also set Build Settings → "Code Signing
Entitlements" → `Runner/Runner.entitlements` for all configurations. That turns
on **Associated Domains** for Universal Links. They still open Safari until the
marketing site serves `/.well-known/apple-app-site-association` from the apex
(docs/RELEASE.md) — the app cannot serve it, because it does not own that host.

## 5. Run

Simulator (no camera, so the QR scanner cannot be tried; the venue-code field
next to it does the same job):

```bash
open -a Simulator
flutter run --dart-define=API_MODE=fake
```

Fake mode is the one to use. The login screen offers the seeded accounts as
one-tap chips: an owner of every venue, an admin, and a front-desk member
whose refusals are worth seeing.

Real iPhone (camera works — the actual scanner):

```bash
flutter devices                              # find the phone's id
flutter run -d <device-id> --dart-define=API_MODE=fake
```

First run on a phone: unlock it, tap Trust, and on iOS 16+ turn on Settings →
Privacy & Security → **Developer Mode** (the phone reboots). If iOS says the
developer is untrusted: Settings → General → VPN & Device Management → trust
your Apple ID. Personal Team builds stop launching after 7 days;
`flutter run` again re-signs.

**A real device is what D18 needs.** The Android emulator on the Windows
machine cannot render any Flutter app under that host's memory pressure, so
nothing has been walked on hardware yet. If you have an iPhone here, walking
O0 → O7 and the venue desk on it closes the oldest open item in the project.

## 6. Per session

```bash
git pull
flutter pub get
flutter run --dart-define=API_MODE=fake   # re-runs pod install when plugins changed
```

Codegen output (`*.g.dart`, `*.freezed.dart`) is committed, so `build_runner`
is not needed just to run. If you edit a `@riverpod` / `@freezed` file on the
Mac: `dart run build_runner build`.

## 7. Release build and TestFlight — needs the Developer Program

```bash
flutter build ipa --dart-define-from-file=release.json
```

This produces `build/ios/ipa/reservme.ipa` and an `.xcarchive`. Upload with
Xcode → Window → Organizer → Distribute App, or Transporter. Before the first
upload:

- App Store Connect → create the app with bundle id `pro.reservme.app`.
- Associated Domains attached (§4).
- Store copy and screenshots: docs/STORE-LISTING.md.

Note `release.json` sets `API_MODE=real`, which today is an app that can do
nothing. There is no point submitting until the backend exists (D13).

## Remote

`https://github.com/yaacobmartinez-personal/reservme-mobile` (private).
Developed on Windows, pushed to `main`; the Mac pulls from there. Cloning over
HTTPS needs a GitHub personal access token or `gh auth login` on the Mac; SSH
works if the Mac's key is on the account.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `CocoaPods not installed` / `pod: command not found` | `brew install cocoapods`, restart the terminal |
| Pod install fails on deployment target | `ios/Podfile`: uncomment `platform :ios, '15.0'` |
| "Signing for Runner requires a development team" | §4 |
| Build fails mentioning "Associated Domains" on a Personal Team | Remove the entitlements file from Build Settings — §4 |
| The app stops launching after a week | Personal Team build expired; `flutter run` again |
| App installs but the camera is black on the simulator | Expected; use the venue-code field or a real phone |
| A `https://reservme.pro/…` link opens Safari instead of the app | The AASA file is not hosted yet; `reservme://…` links work |
| Build error mentioning `Flutter.h` not found | You opened `Runner.xcodeproj`; open `Runner.xcworkspace` |
| Stale pods after upgrading plugins | `cd ios && pod deintegrate && pod install` |
| Signed in, but every venue screen is empty | You built with `API_MODE=real`; there is no backend yet |
