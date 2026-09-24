# Deferred — things to address before launch

Running list of everything knowingly left undone, with the phase that should
pick it up. Reviewed at the start of each phase, and again before release.

## Open

| # | Item | Phase |
|---|---|---|
| D18 | **Walk O1–O7 by hand on a device.** Mostly done. The emulator renders again — the cause was host memory, and the recipe is: stop the Gradle daemons (`android/gradlew --stop`), then boot with `-memory 1536`. Walked and confirmed: fresh install → O0, O1 sign-up, the venue picker, Today, More, Insights, Spaces, the space editor, Billing, Team, Your account, the reset screen, and both deep-link forms (`https://reservme.pro/<slug>` and `reservme://<slug>/manage/<token>`). **Not done:** typing through O1 → O7 end to end. Driving text entry over `adb input` puts every string into the first field once the keyboard shifts the layout, so this wants five minutes of a human's thumbs rather than more automation. The flow is covered by a fake-backed test that runs the whole sequence. | before launch |
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

## Carry into later phases

| # | Item | Phase |
|---|---|---|
| D6 | Real repositories for every contract row, against a mocked `HttpClientAdapter`; flip `Feature` flags as the backend ships. | 4 |
| D7 | Deep-link **handler** (parser is done): `app_links` wiring, Android intent filters, iOS entitlements, and the well-known files hosted by the marketing site. | 4 |
| D10 | Store listing, screenshots, data-safety answers, signing keystore. | 4 |
| D12 | Platform admin console — still undecided whether it moves into the app or stays web/CLI. **Decision needed.** | — |
| D13 | Backend plan: none of the 34 endpoints exist. The app ships demoable in fake mode; `real` mode does nothing until they land. | separate plan |
| D17 | **Sessions are read-only on the calendar.** Tapping open play explains itself rather than offering create/cancel (`session-actions.ts`), which is parked for v1.1 with memberships and promos. | v1.1 |

## Product questions open

- **Turnstile replacement** for public booking abuse: the contract proposes IP + venue + device rate limits and idempotency keys; confirm with the backend plan.
- **Payments** are out of scope for v1 (pay-at-venue), so the `payment` table stays unused and the booking form says "Pay at the venue".
- Memberships, promo codes, loyalty, integrations and CSV export exist on the web but are not in the app — confirm they stay out for v1 given the web dashboard is being parked.
