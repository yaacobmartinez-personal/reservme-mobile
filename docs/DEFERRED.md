# Deferred — things to address before launch

Running list of everything knowingly left undone, with the phase that should
pick it up. Reviewed at the start of each phase, and again before release.

## Open

| # | Item | Phase |
|---|---|---|
| D2 | **Onboarding photos.** The five images live as canvas assets only; the app needs them in `assets/photos/` (court, owner, studio, padel, qr). They are AI-generated placeholders — replace with licensed or real venue photography before store submission. | 3b (builds the screens that use them) |
| D5 | **Venue avatar inverts in dark mode** (light mint square, dark letter) because it uses `pineInk` as a fill. Give it a fixed strong fill, or use the venue logo once uploads exist. | 3c (the real avatar is a logo) |

## Closed

- **D1 fonts** — Fraunces, Instrument Sans and JetBrains Mono variable TTFs are bundled in `assets/fonts/` with their OFL licences. `typography.dart` pins the axes per style (Fraunces ships defaulting to weight 900 with `WONK` on, so every serif style sets wght 400, SOFT 0, WONK 0 and tracks `opsz` to the font size). Resize a display style with `AppType.displayAt(size)`, never `copyWith(fontSize:)`, or the optical size goes stale.
- **D3 demo sign-in** — removed in Phase 2. The Account screen's "Venue staff" group now offers only the real login, and `AuthController` has no dev shortcut. Fake mode instead shows the seeded accounts as one-tap chips on the login screen itself (`FakeAccountsHint`), so the demo path goes through the same code as a real sign-in.
- **D4 `SegmentedButton` tint** — fixed in Phase 1 with a `segmentedButtonTheme` on `AppTheme`.
- **D8 venue read cache** — Today in Phase 2, Calendar in Phase 3 (`venue_cache` table behind `LocalStore.readVenueCache` / `saveVenueCache`, wiped on sign-out). The Calendar keys per date (`calendar:<date>`), so yesterday's grid is never served for today. Customers is deliberately **not** cached: at the counter you want the truth, and the screen has a good empty state.
- **D15 move a booking** — the calendar's move sheet does it, and the engine refuses a move onto a taken slot rather than forcing it.

## Carry into later phases

| # | Item | Phase |
|---|---|---|
| D6 | Real repositories for every contract row, against a mocked `HttpClientAdapter`; flip `Feature` flags as the backend ships. | 4 |
| D7 | Deep-link **handler** (parser is done): `app_links` wiring, Android intent filters, iOS entitlements, and the well-known files hosted by the marketing site. | 4 |
| D9 | App icon and splash — `assets/brand/` is empty, so both are still the Flutter defaults. | 4 |
| D10 | Store listing, screenshots, data-safety answers, signing keystore. | 4 |
| D11 | **Account deletion** is a store requirement now that sign-up is in-app (contract #34). | 3c |
| D12 | Platform admin console — still undecided whether it moves into the app or stays web/CLI. **Decision needed.** | — |
| D13 | Backend plan: none of the 34 endpoints exist. The app ships demoable in fake mode; `real` mode does nothing until they land. | separate plan |
| D16 | **The calendar's time fields are typed, not picked.** New booking, move and block take "HH:MM" and "YYYY-MM-DD" as text. It validates, but a real date and time picker is the right control. | 3c (polish pass) |
| D17 | **Sessions are read-only on the calendar.** Tapping open play explains itself rather than offering create/cancel (`session-actions.ts`), which is parked for v1.1 with memberships and promos. | v1.1 |
| D14 | **Password reset finishes on the web.** `POST /mobile/auth/forgot-password` sends the email and the app says "check your email"; the in-app code entry (contract #26) is not built, so a staff member with no web access cannot actually reset. | 3b (with the signup/verify screens, which share the code field) |

## Product questions open

- **Turnstile replacement** for public booking abuse: the contract proposes IP + venue + device rate limits and idempotency keys; confirm with the backend plan.
- **Payments** are out of scope for v1 (pay-at-venue), so the `payment` table stays unused and the booking form says "Pay at the venue".
- Memberships, promo codes, loyalty, integrations and CSV export exist on the web but are not in the app — confirm they stay out for v1 given the web dashboard is being parked.
