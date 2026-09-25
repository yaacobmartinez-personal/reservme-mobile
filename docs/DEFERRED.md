# Deferred — things to address before launch

Running list of everything knowingly left undone, with the phase that should
pick it up. Reviewed at the start of each phase, and again before release.

## Open

| # | Item | Phase |
|---|---|---|
| D2b | **The onboarding photos are AI-generated placeholders.** They are bundled and named now, but they are not real venue photography and should not ship as-is. The Welcome hero matters most — it is the first thing an owner sees. | before store submission |

## Closed

- **D1 fonts** — Fraunces, Instrument Sans and JetBrains Mono variable TTFs are bundled in `assets/fonts/` with their OFL licences. `typography.dart` pins the axes per style (Fraunces ships defaulting to weight 900 with `WONK` on, so every serif style sets wght 400, SOFT 0, WONK 0 and tracks `opsz` to the font size). Resize a display style with `AppType.displayAt(size)`, never `copyWith(fontSize:)`, or the optical size goes stale.
- **D3 demo sign-in** — removed in Phase 2. The Account screen's "Venue staff" group now offers only the real login, and `AuthController` has no dev shortcut. Fake mode instead shows the seeded accounts as one-tap chips on the login screen itself (`FakeAccountsHint`), so the demo path goes through the same code as a real sign-in.
- **D4 `SegmentedButton` tint** — fixed in Phase 1 with a `segmentedButtonTheme` on `AppTheme`.
- **D8 venue read cache** — Today in Phase 2, Calendar in Phase 3 (`venue_cache` table behind `LocalStore.readVenueCache` / `saveVenueCache`, wiped on sign-out). The Calendar keys per date (`calendar:<date>`), so yesterday's grid is never served for today. Customers is deliberately **not** cached: at the counter you want the truth, and the screen has a good empty state.
- **D15 move a booking** — the calendar's move sheet does it, and the engine refuses a move onto a taken slot rather than forcing it.
- **D2 onboarding photos bundled** — the five images are in `assets/photos/` and named in `lib/core/ui/photos.dart`, so Phase 3b's screens have them. They are still placeholders: see **D2b** above.
- **D5 venue avatar** — one `VenueAvatar` widget now, used by the picker and More. It uses the accent pair (`pine` / `onPine`) rather than `pineInk` / `pineLine`: those two swap roles between the themes, which is exactly why the tile inverted in dark mode.
- **D9 icon and splash** — a Fraunces "R" on pine, generated into `assets/brand/` and wired through `flutter_launcher_icons` and `flutter_native_splash` (both configured in `pubspec.yaml`, with a dark variant). Regenerate with `dart run flutter_launcher_icons` and `dart run flutter_native_splash:create`.
- **D16 typed times** — `core/widgets/wall_clock_field.dart` gives the calendar sheets a real date and time picker. Both still deal in venue-local wall clock (`YYYY-MM-DD`, `HH:MM`), never instants, because that is what the server turns into a timestamp in the venue's own zone.
- **D11 account deletion** — G7 · Your account deletes the account and the notes that user wrote; bookings belong to the venue and stay with it. Refused with a 409 (`reason: sole_owner`) naming the venues that would be left ownerless, because a venue with no owner has nobody who can pay for it or hand it on and no way back short of support. Confirming means typing DELETE: it is the one action in the app with no undo.
- **D14 in-app password reset** — the forgot screen now offers "I have the code" and V3 finishes the reset in the app (contract #26). Until now a staff member with only a phone could start a reset and never finish one. The step refuses a wrong code and an address with no account with the *same* wording, so it does not undo the request step's deliberate silence about which emails exist.

- **D18 walked on a device** — O0 → O7 end to end on a fresh install, plus the venue side (picker, Today, More, Insights, Spaces, the space editor, Billing, Team, Your account, the reset screen) and both deep-link forms. Confirmed on the way: the slug check flipping from “Another venue has that address” to “Available” as the name changed, the wrong-code refusal on O2, the space name carrying into O5's heading, and the new venue landing on its own empty run sheet. The emulator failure was never the app: it was host memory. The recipe is `android/gradlew --stop`, then boot with `-memory 1536` — and for driving it, `adb input` needs the screen re-read after every keystroke, because the keyboard shifts the layout under fixed coordinates.

- **Real mode found what 305 passing tests could not.** Signing in against the live server landed a venue-less owner on O3 "Name your venue" — whose only button answers "Not available on this server yet", because creating a venue is #27 and does not exist. `computeRedirect` and `afterSignInTarget` take `canOnboard` now and send them to the picker, which grew a real empty state instead of an empty list under "Your venues". Two smaller ones from the same run: `ApiError` read the machine slug `error` as the human message, so the first real refusal rendered as "unauthorized"; and debug builds had no cleartext permission, so the `http://10.0.2.2:3000` workflow `app_config.dart` documents could not connect. The permission is in a **debug-only** manifest — release builds stay HTTPS-only.

- **A hold read as "Confirmed" on the run sheet.** Found the moment a real server put a held booking on the sheet: the chip switch had no `held` case, so it fell through to the default. A hold is unpaid and expires, and the slot frees up when it does — telling the desk it is confirmed is the one wrong answer that reads as reassuring. It says **Held** now, in amber, and beats the customer's no-show count because it describes the booking in front of you rather than the person. The seed had no hold at all, so the first version of the regression test passed by finding nothing to check; today's seed carries one now and the test asserts that first.

- **"1 visits" in the booking typeahead.** A customer with one booking read "1 visits" — the first thing a member reads about somebody standing at the counter. The codebase already spells singulars out inline for no-shows, so this now matches. The regression test asserts a hit was *found* before asserting the wording, because `findsNothing` on its own passes just as happily against an empty list.

## Carry into later phases

| # | Item | Phase |
|---|---|---|
| D6 | Real repositories for every contract row, against a mocked `HttpClientAdapter`; flip `Feature` flags as the backend ships. | 4 |
| D7 | Deep-link **handler** (parser is done): `app_links` wiring, Android intent filters, iOS entitlements, and the well-known files hosted by the marketing site. | 4 |
| D10 | Store listing, screenshots, data-safety answers, signing keystore. | 4 |
| D12 | Platform admin console — still undecided whether it moves into the app or stays web/CLI. **Decision needed.** | — |
| D13 | Backend. **Auth, onboarding, the desk and the calendar landed 2026-09-25** (rows 10–20, 24–28, 30, 34 — web repo, on Neon). O0 → O7, Today and the Calendar were all walked on a device against the real database. Live flags: `venueLogin`, `signup`, `onboarding`, `venueSettings`, `today`, `calendar`, `deleteAccount`. **Rows 21–22 (Customers) are next**, then #23 (waitlist) and #29 (pricing rules, closures) — the last of which is what keeps `spaces` shut, since one flag gates the whole repository. | separate plan |
| D17 | **Sessions are read-only on the calendar.** Tapping open play explains itself rather than offering create/cancel (`session-actions.ts`), which is parked for v1.1 with memberships and promos. | v1.1 |

## Product questions open

- **Turnstile replacement** for public booking abuse: the contract proposes IP + venue + device rate limits and idempotency keys; confirm with the backend plan.
- **Payments** are out of scope for v1 (pay-at-venue), so the `payment` table stays unused and the booking form says "Pay at the venue".
- Memberships, promo codes, loyalty, integrations and CSV export exist on the web but are not in the app — confirm they stay out for v1 given the web dashboard is being parked.
