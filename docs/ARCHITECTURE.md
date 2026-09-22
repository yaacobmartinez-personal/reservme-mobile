# Architecture

Short orientation for the Flutter app. The phased plan is in the approved plan
file (see README); the API is in [API-CONTRACT.md](API-CONTRACT.md); the
design is the canvas linked from the README.

## One app, two modes

- **Customer** (`/c/*`, default, public): find a venue by code / QR / link,
  see its spaces and availability, book, keep bookings on the phone. There is
  no customer account anywhere — a booking's manage token is the capability,
  stored in the device wallet.
- **Venue** (`/v/*`): staff sign in. Today (run sheet), Calendar, Customers,
  More (waitlist, spaces, settings, team, billing, insights, account). The
  app is the venue's only surface after launch; the web dashboard is parked.
- **Onboarding** (`/onboarding/*`): Welcome → sign up → verify → create venue
  → first space → hours → policy → live. Steps after sign-up need a session.

Both shells are `StatefulShellRoute.indexedStack` in
`lib/core/router/app_router.dart`; redirect rules are the pure
`computeRedirect` in `guards.dart`. `AppModeController` remembers which
shell was last used; a venue login lands in the venue shell.

## Layers

```
presentation/   widgets only; reads controllers, never Dio or drift
application/    @riverpod controllers (state machines, AsyncValue)
domain/         models (freezed) + abstract repositories
data/           RealXRepository(ApiClient) and FakeXRepository(FakeStore)
```

Feature folders live under `lib/features/{auth, shell, settings, customer/*,
venue/*, onboarding}`; cross-cutting code under `lib/core`. One
`*_providers.dart` per feature group wires repositories:

```dart
@Riverpod(keepAlive: true)
TodayRepository todayRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
  ApiMode.real => RealTodayRepository(ref.watch(apiClientProvider)),
  ApiMode.fake => FakeTodayRepository(ref.watch(fakeStoreProvider), ...),
};
```

## `API_MODE`

`--dart-define=API_MODE=fake|real` (default `fake`). Fakes share one
`FakeStore` (`lib/core/fake`), an in-memory copy of the server's tables seeded
by `seed.dart` — two venues (Katipunan Courts in Asia/Manila, Studio Norte in
Europe/Madrid so DST is always exercised), spaces, hours, peak pricing, open
play sessions, ~60 bookings including today's run sheet, customers, waitlist,
a suspended venue. Fakes enforce the same rules as the server: the no-overlap
constraint, notice and horizon, session capacity, cancellation policy.

In `real` mode, `Feature` gates (`lib/core/config/feature_availability.dart`)
hide UI for endpoints the backend has not shipped. Every flag is off today.

## Design system in code

The design canvas's Foundations/Atoms/Molecules map onto:

| Canvas | Code |
|---|---|
| Colour (light + dark) | `core/theme/palette.dart` — `AppPalette.light/dark`, read via `context.palette` |
| Venue theme swatches | `core/theme/venue_accent.dart` — `VenueAccent(theme:)` re-tints a subtree |
| Typography | `core/theme/typography.dart` — `AppType.displayL`, `body`, `reference`, … |
| Space, radii, motion | `core/theme/spacing.dart`, `motion.dart` |
| Chips | `core/theme/status_chip.dart` |
| Buttons | Material `FilledButton` / `OutlinedButton` / `TextButton`, themed in `app_theme.dart` |
| Cards, KPI tile, eyebrow, sticky footer, big header, round icon button | `core/ui/primitives.dart` |
| Banners | `core/ui/app_banner.dart` |
| Kind placeholder (no space photo) | `core/ui/kind_placeholder.dart` |
| Bottom nav | `core/ui/app_bottom_nav.dart` |
| Empty state, skeleton, error banner, async view | `core/widgets/*`, `core/ui/skeleton.dart` |

Dark mode follows the OS with a manual override (Account / More →
Appearance). No screen carries a theme-specific colour.

Fonts: Fraunces (display), Instrument Sans (body) and JetBrains Mono
(references) are named in `typography.dart`; drop the variable TTFs into
`assets/fonts/` and uncomment the `fonts:` block in `pubspec.yaml`.

## Time and money

All instants are UTC. Rendering uses the **venue's** IANA zone through
`core/time/app_time.dart` (`formatWhen`, `localDate`, `fromLocal`, DST-safe
`addDays`), never the device's. Money is integer centavos formatted by
`core/money/money.dart` (`₱1,250`, `₱5.6k`).

## Network

`ApiClient` (`core/network/api_client.dart`): Dio with the bearer token read
lazily, an `Idempotency-Key` on booking POSTs, cold-start retries for a
sleeping server, and every failure mapped to `ApiError(status, message,
fieldErrors, reason)`; `status == 0` is unreachable. A 401 outside the login
path signs the app out through `UnauthorizedEvents`. Riverpod's retry policy
only retries transport failures.

## Session and storage

- `SecureStore` (flutter_secure_storage): token, cached user, cached venue
  list. Every read is wrapped; a broken store reads as signed out.
- `Prefs` (SharedPreferencesAsync): app mode, selected venue, recent venues,
  appearance, remembered booking contact.
- `BootData.load` reads all of it once in `main()` and is injected through
  `bootDataProvider`, so there is no splash screen.
- Drift (Phase 1+): the customer wallet and the venue read cache.

## Fake-mode demo

Account → "Demo: sign in as the venue owner" establishes a session for the
seeded owner (`owner@reservme.test`) without the login screen, so the venue
shell can be exercised before the auth flow ships. It is compiled out of real
mode.
