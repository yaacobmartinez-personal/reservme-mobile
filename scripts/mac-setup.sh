#!/usr/bin/env bash
# First run on a Mac: check the tools docs/MAC-SETUP.md §1 installs, then do
# the first build so CocoaPods and the workspace exist. Safe to run again.
set -euo pipefail

cd "$(dirname "$0")/.."
want_flutter="3.47"
fail=0

check() {
  if command -v "$1" >/dev/null 2>&1; then
    printf '  ok   %s\n' "$2"
  else
    printf '  MISSING  %s — %s\n' "$2" "$3"
    fail=1
  fi
}

echo "Tools"
check xcodebuild "Xcode" "install from the App Store, then: sudo xcode-select -s /Applications/Xcode.app/Contents/Developer"
check pod "CocoaPods" "brew install cocoapods"
check flutter "Flutter" "see docs/MAC-SETUP.md §1"
[ "$fail" -eq 0 ] || { echo; echo "Install what is missing, then run this again."; exit 1; }

have_flutter="$(flutter --version 2>/dev/null | head -1 | awk '{print $2}')"
case "$have_flutter" in
  "$want_flutter"*) echo "  ok   Flutter $have_flutter" ;;
  *) echo "  WARN Flutter $have_flutter — the project is built with $want_flutter.x; CI pins 3.47.4." ;;
esac

echo
echo "Packages"
flutter pub get

echo
echo "First build (simulator, fake data) — creates ios/Podfile and runs pod install"
flutter build ios --simulator --debug --dart-define=API_MODE=fake

cat <<'NEXT'

Done. Next:
  open -a Simulator
  flutter run --dart-define=API_MODE=fake        # offline demo world
  flutter run --dart-define-from-file=release.json   # the live server

For a real iPhone, set your team in Xcode first (docs/MAC-SETUP.md §4):
  open ios/Runner.xcworkspace
NEXT
