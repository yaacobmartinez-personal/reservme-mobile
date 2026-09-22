# Deferred — things to address before launch

Running list of everything knowingly left undone, with the phase that should
pick it up. **Reviewed at the start of Phase 3** (and again before release).

## Must fix before Phase 3

| # | Item | Why it was deferred | Where |
|---|---|---|---|
| D1 | **Bundle the fonts.** Fraunces, Instrument Sans and JetBrains Mono variable TTFs (OFL, Google Fonts) into `assets/fonts/`, then uncomment the `fonts:` block in `pubspec.yaml`. The app currently falls back to the platform faces, so nothing looks like the design canvas. | Needed a download decision | `pubspec.yaml`, `lib/core/theme/typography.dart` |
| D2 | **Onboarding photos.** The five images live as canvas assets only; the app needs them in `assets/photos/` (court, owner, studio, padel, qr). They are AI-generated placeholders — replace with licensed or real venue photography before store submission. | Phase 3b builds the screens that use them | `assets/photos/`, canvas row "Onboarding" |
| D3 | **Remove the fake-mode demo sign-in** from the Account screen once the real login lands. | Needed a way into the venue shell before Phase 2 | `features/customer/account/presentation/account_screen.dart`, `AuthController.devSignInAsDemo` |
| D5 | **Venue avatar inverts in dark mode** (light mint square, dark letter) because it uses `pineInk` as a fill. Give it a fixed strong fill, or use the venue logo once uploads exist. | Cosmetic; the real avatar is a logo in Phase 3c | `venue_picker_screen.dart`, `more_screen.dart` |

## Closed

- **D4 `SegmentedButton` tint** — fixed in Phase 1 with a `segmentedButtonTheme` on `AppTheme`.

## Carry into later phases

| # | Item | Phase |
|---|---|---|
| D6 | Real repositories for every contract row, against a mocked `HttpClientAdapter`; flip `Feature` flags as the backend ships. | 4 |
| D7 | Deep-link **handler** (parser is done): `app_links` wiring, Android intent filters, iOS entitlements, and the well-known files hosted by the marketing site. | 4 |
| D8 | Venue read cache (drift) for Today / Calendar / Customers with the stale banner. | 2–3 |
| D9 | App icon and splash — `assets/brand/` is empty, so both are still the Flutter defaults. | 4 |
| D10 | Store listing, screenshots, data-safety answers, signing keystore. | 4 |
| D11 | **Account deletion** is a store requirement now that sign-up is in-app (contract #34). | 3c |
| D12 | Platform admin console — still undecided whether it moves into the app or stays web/CLI. **Decision needed.** | — |
| D13 | Backend plan: none of the 34 endpoints exist. The app ships demoable in fake mode; `real` mode does nothing until they land. | separate plan |

## Product questions open

- **Turnstile replacement** for public booking abuse: the contract proposes IP + venue + device rate limits and idempotency keys; confirm with the backend plan.
- **Payments** are out of scope for v1 (pay-at-venue), so the `payment` table stays unused and the booking form says "Pay at the venue".
- Memberships, promo codes, loyalty, integrations and CSV export exist on the web but are not in the app — confirm they stay out for v1 given the web dashboard is being parked.
