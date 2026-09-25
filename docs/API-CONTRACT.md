# ReservMe mobile — API contract

The endpoints the app is built against. **None of them exist on the server
yet**; each one is implemented by a `Fake*Repository` in the app and gated by a
`Feature` flag (`lib/core/config/feature_availability.dart`) for `real` mode.
When the backend ships an endpoint, its row here is the spec, the `Real*`
repository already calls it, and the flag flips in one line.

The web app (`D:\Personal\reservme`) has every piece of business logic these
endpoints need; the last column names the function to reuse so the backend
work is routing, not logic.

## Conventions

- Base URL `SERVER_URL/api` (default `https://app.reservme.pro/api`). The apex
  host 404s `/api/*`, so the app never calls it.
- `/public/*` — unauthenticated, customer side. `/mobile/*` — `Authorization:
  Bearer <token>`, venue staff.
- JSON both ways. Instants are ISO-8601 UTC. Wall-clock inputs are venue-local
  `date` (`YYYY-MM-DD`) + `time` (`HH:MM`). Amounts are integer minor units
  (centavos).
- Errors: `{ error, message?, fieldErrors?: {field: msg}, reason? }`.
  400 validation · 401 bad token · 403 not a member / suspended venue (writes)
  · 404 unknown venue, booking, token · 409 conflict (`reason`: `slot_taken`,
  `session_full`, `already_<status>`, `sole_owner`, `last_owner`) · 422
  policy refusal (`reason` + `message` for the customer) · 429 rate limit.
- `X-Client: reservme-flutter/<version> (<os>)` on every request.
- `Idempotency-Key: <uuid>` on every POST that creates a booking; the server
  returns the original result for a repeat within 24 h.
- Rate limits on public writes: per IP, per venue, per device (`X-Client` +
  key) — the mobile equivalent of the web's Turnstile.

### Token

`base64url(JSON{sub, exp}).signature`, 30-day TTL, minted by `POST
/mobile/auth/login`. The app reads `exp` client-side to decide whether to send
it; the server is the authority. Any 401 outside the login path signs the app
out. Fake-mode tokens carry a `fake.` prefix and are never sent anywhere.

### Shared shapes

```
Venue           { id, slug, name, tagline?, address?, timezone, currency, theme,
                  logoUrl?, coverUrl?, minNoticeMinutes, maxHorizonDays,
                  cancellationMode: anytime|grace|never, cancellationGraceHours,
                  refundTerms?, gcashName?, suspended: bool,
                  spaces: [Space] }                            (#1: active spaces only)
Space           { id, name, slug, kind: court|room|studio|table|tour|other, capacity,
                  slotMinutes, bufferMinutes, priceCents, isActive, sortOrder, imageUrl? }
Slot            { startsAt, endsAt, label "18:00", available, reason: open|taken|closed|
                  too_soon|too_far_ahead, priceCents }          (web availability.ts)
SessionSummary  { id, title, startsAt, endsAt, label, capacity, bookedSpots, spotsLeft,
                  pricePerPersonCents }
Booking         { id?, reference, venue: {slug, name, theme, timezone, currency},
                  space: {id, name, kind}, startsAt, endsAt, whenLabel, kind,
                  partySize, amountCents, status, checkedInAt?, notes?,
                  cancellation: {canCancel, reason?}, manageToken? (public only) }
RunSheetEntry   { id, reference, spaceName, customerName?, customerPhone?, customerId?,
                  label "18:00–19:00", startsAt, endsAt, status, kind, partySize,
                  amountCents, checkedInAt?, noShowCount, firstVisit }
VenueMembership { orgId, slug, name, role: owner|admin|member, timezone, currency,
                  theme, suspended, activeSpaces }
CustomerSummary { id, name, email, phone?, visits, noShowCount, tags[], lastVisitAt? }
```

## Endpoints

| # | Method & path | Auth | Request → Response | Errors | Reuses (web) |
|---|---|---|---|---|---|
| 1 | `GET /public/venues/{slug}` | none | → `{venue: Venue}` | 404 | `getVenueBySlug`, `getVenueSpaces` |
| 2 | `GET /public/venues/{slug}/availability?space={id}&date=YYYY-MM-DD` | none | → `{date, slots: [Slot], sessions: [SessionSummary]}` | 400 outside horizon, 404 | `getDayAvailability`, `getDaySessions` |
| 3 | `POST /public/venues/{slug}/bookings` | none | `{spaceId, startsAt, endsAt, name, email, phone?, promo?}` → `201 {booking}` (with `manageToken`) | 400 fieldErrors, 403 suspended, 409 `slot_taken`, 429 | `bookSlot` pipeline |
| 4 | `POST /public/venues/{slug}/sessions/{id}/bookings` | none | `{spots, name, email, phone?}` → `201 {booking}` | 409 `session_full`, 429 | `reserveSessionSeats` |
| 5 | `GET /public/venues/{slug}/bookings/{token}` | none | → `{booking}` (works while suspended) | 404 | `getManageableBooking` |
| 6 | `POST /public/venues/{slug}/bookings/{token}/cancel` | none | → `{outcome: cancelled\|refused, reason?, booking}` | 404, 429 | `cancelBooking` (policy re-derived server-side) |
| 7 | `GET /public/venues/{slug}/bookings/{token}/reschedule-options?days=7` | none | → `{days: [{date, slots: [Slot]}]}` | 404 | `rescheduleOptions` |
| 8 | `POST /public/venues/{slug}/bookings/{token}/reschedule` | none | `{startsAt, endsAt}` → `{booking}` | 409 `slot_taken`, 422 policy | `rescheduleBooking` |
| 9 | `POST /public/venues/{slug}/waitlist` | none | `{spaceId, startsAt, endsAt, name, email, phone?}` → `{ok: true}` | 400, 429 | `joinWaitlistAction` |
| 10 | `POST /mobile/auth/login` | none | `{email, password}` → `{token, user: {id, email, name, emailVerified}}` | 401, 429 | Better Auth bearer plugin |
| 11 | `POST /mobile/auth/forgot-password` | none | `{email}` → `{ok: true}` always | 429 | reset email with a 6-digit code |
| 12 | `POST /mobile/auth/logout` | bearer | → `{ok: true}` | — | revoke session |
| 13 | `GET /mobile/me` | bearer | → `{user, venues: [VenueMembership]}` | 401 | org memberships + `venue` rows |
| 14 | `GET /mobile/venues/{slug}/today` | member | → `{date, stats: {todayCount, checkedIn, upcomingCount, activeSpaces, todayRevenueCents}, runSheet: [RunSheetEntry]}` | 403, 404 | `getRunSheet`, `getVenueStats` |
| 15 | `POST /mobile/venues/{slug}/bookings/{id}/checkin` · `/undo-checkin` · `/no-show` · `/cancel` | member | → `{booking}` | 404, 409 wrong state | `booking-actions.ts` |
| 16 | `GET /mobile/venues/{slug}/calendar?date=` | member | → `{date, spaces: [{space, items: [{kind: booking\|block\|session, …}]}], closures: []}` | 403 | calendar page query |
| 17 | `POST /mobile/venues/{slug}/bookings` | member | `{spaceId, date, time, slotCount, partySize, notes?, customerId? \| name, email, phone?}` → `201 {booking}` | 400, 409 `slot_taken` | `createManualBooking` (staff path) |
| 18 | `POST /mobile/venues/{slug}/bookings/{id}/move` | member | `{spaceId, date, time}` → `{booking}` | 409 | `moveReservation` |
| 19 | `POST /mobile/venues/{slug}/blocks` · `DELETE …/blocks/{id}` | member | `{spaceId?, date, from, to, reason?}` → `201 {block}` | 409 overlap | `blockOff`, `removeBlock` |
| 20 | `GET /mobile/venues/{slug}/customers?q=&segment=` | member | → `{rows: [CustomerSummary], total}` — `segment` is `regulars\|noShows\|newThisMonth`, anything else is no filter | 403 | `listCustomers` |
| 21 | `GET /mobile/venues/{slug}/customers/{id}` | member | → `{customer: CustomerSummary, upcoming: [CustomerBooking], past: [CustomerBooking], notes: [{id, body, authorName, createdAt}], lastVisit}` | 404 | `getCustomer` |
| 22 | `POST …/customers/{id}/notes` · `DELETE …/customers/{id}/notes/{noteId}` · `PUT …/customers/{id}/tags {tags:[]}` · `PATCH …/customers/{id} {name, phone}` | member | → `{note}` / `{ok}` / `{customer}` / `{customer}` | 400 `fieldErrors`, 404 | `customer-actions.ts` |
| 23 | `GET /mobile/venues/{slug}/waitlist` | member | → `{entries: [{id, customerName, customerEmail, customerPhone, spaceName, startsAt, endsAt, whenLabel, status, notifiedAt, claimExpiresAt, createdAt}]}` | 403 | `listWaitlist` |
| 24 | `GET /mobile/venues/{slug}/spaces` · `POST …/spaces/{id}/active {active}` | member (toggle: admin) | → `{spaces}` / `{space}` | 403 | `setSpaceActive` |
| 25 | `POST /mobile/auth/signup` `{name, email, password}` → `{token, user}` · `POST /mobile/auth/verify` `{code}` → `{user}` · `POST /mobile/auth/resend-verification` | none / bearer | owner account + 6-digit email code | 400 fieldErrors, 409 email taken, 429 | Better Auth signUp.email + verification |
| 26 | `POST /mobile/auth/reset-password` | none | `{email, code, password}` → `{token, user}` | 400 bad code | Better Auth reset |
| 27 | `POST /mobile/venues` · `GET /mobile/venues/slug-available?slug=` | bearer | `{name, slug, timezone, address?, currency?}` → `201 {venue: VenueMembership}` (trialing subscription) | 400, 409 slug taken | `/api/venue/init`, slug rules |
| 28 | `POST /mobile/venues/{slug}/spaces` · `PATCH …/spaces/{id}` · `DELETE …/spaces/{id}` · `PUT …/spaces/{id}/hours` `[{weekday, opensAt, closesAt}]` · `POST …/spaces/{id}/image` (multipart `image`, ≤2 MB) · `DELETE …/spaces/{id}/image` | admin | space editor; the photo is optional and every surface shows the kind placeholder without one | 400, 404, 413 | `createSpace`, `updateSpace`, `setOpeningHours`, `updateSpaceImage`, `/api/upload` |
| 29 | `POST …/spaces/{id}/pricing-rules` · `DELETE …/pricing-rules/{id}` · `POST /mobile/venues/{slug}/closures` · `DELETE …/closures/{id}` · `POST …/sessions` · `POST …/sessions/{id}/cancel` | admin | pricing, closures, open-play sessions | 400, 409 | `addPricingRule`, `addClosure`, `session-actions.ts` |
| 30 | `PATCH /mobile/venues/{slug}` · `POST …/branding/{logo\|cover}` (multipart) | admin | settings: tagline, address, theme, cancellation, notice/horizon, refund terms, gcash name, timezone | 400 | `updateVenueSettings`, `branding-actions.ts` |
| 31 | `GET …/team` · `POST …/team/invitations` `{email, role}` · `DELETE …/team/invitations/{id}` · `PATCH …/team/members/{id}` `{role}` · `DELETE …/team/members/{id}` | admin (owner for owner role) | → `{members: [{id, userId, name, email, role, isSelf, joinedAt}], invitations: [{id, email, role, expiresAt}]}` | 403, 409 `last_owner` | Better Auth org plugin + last-owner guard |
| 32 | `GET …/billing` · `POST …/billing/proof` (multipart: `reference`, `paidAt`, `image`) | owner/admin | → `{band, activeSpaces, status, trialEndsAt, paidUntil?, daysLeftInTrial, dueNow, suspended, instapay, pendingPayment?, history: []}`. The amount is **not** an input — the server derives it from the band, so a venue cannot declare what it owes; and the band itself is derived from the **active** space count at read time, never stored | 400 | `src/lib/billing.ts`, `billing-actions.ts` |
| 33 | `GET …/insights?period=today\|7d\|30d\|90d` | member | → `{range, bookedValueCents, bookings, utilisationPct, noShowRatePct` (each `{value, previous, deltaPct, series}`)`, bookedByDay, peakHours` (7×24)`, mix, bySpace, customers, needsYou}`. Every bucket is a **venue-local** date and hour. `rental`+`session_seat` drive counts and value; `rental`+`session_block` drive utilisation — counting seats as occupancy would show a full court as over-booked. `deltaPct` is null against a zero baseline. An unknown `period` falls back to 30d. No `awaitingPayments` tile: v1 is pay-at-venue, so the app has no payment records to count. | 403 | `src/lib/analytics.ts` |
| 34 | `DELETE /mobile/me` | bearer | → `{ok: true}` | 409 `sole_owner` `{venues: [slug]}` | account deletion with the sole-owner guard |

## What is live

**Auth shipped on 2026-09-25** — rows 10–13, 25, 26 and 34, on the app host,
in the web repo (`src/app/api/mobile/**`, branch `feat/mobile-auth-api`).
`Feature.venueLogin` and `Feature.deleteAccount` are `true`; everything else is
still `false`.

Three things the built server settled that this document had only guessed at:

- **The token is opaque.** §Token above describes `base64url(JSON{sub,exp})`
  `.signature`; Better Auth's bearer plugin returns its own session token,
  which is `<random>.<signature>` and carries no readable `exp`. The app falls
  back to its 30-day default, which is what that fallback was for. Keeping
  Better Auth's token means one session table and one revocation path instead
  of a second token format to keep honest.
- **`message`, not `error`, is the sentence.** The server sends
  `{error: "unauthorized", message: "That email and password don't match."}`.
  `ApiError` was reading `error`, so the first real refusal rendered as
  "unauthorized".
- **Verification codes are 6 digits, hashed at rest, good for 10 minutes**, and
  are a second channel beside the web's links rather than a replacement.

**Rows 24, 27, 28 and 30 shipped the same day**, which completes O0 → O7
against a real database. `POST /mobile/venues` and
`GET /mobile/venues/slug-available`; Three rows must exist after it — Better
Auth's organisation, our `venue`, and a trialing `subscription` — and the org
is rolled back by hand if the other two fail, because a half-made venue shows
in the picker and falls over on every screen. The slug check needs a session
(the slug space is global, so anonymous it enumerates venues) and answers 200
even when the answer is no.

plus the space routes and the venue PATCH.

Two shapes this document did not pin down, and the device did:

- **`PATCH /mobile/venues/{slug}` has two callers that parse its `venue`
  differently.** Settings reads it as `VenueSettings`; onboarding's go-live
  reads the same field as a `VenueMembership`, which needs `orgId`, `role` and
  `activeSpaces`. The endpoint answered 200 and the app said "Something went
  wrong". The payload is a superset of both now. A third caller adds its fields
  there rather than branching on who asked.
- **Hours are `PUT` and replace the whole week**, because a closed day is an
  absent row. A partial update cannot express "Sunday is closed".

**Rows 14 and 15 shipped next**, which is the desk: `GET …/today` and the four
run-sheet actions. Three rules the phone would otherwise lose — a block is a
closure and never reaches the sheet, "today" is the *venue's* today via
`AT TIME ZONE`, and takings count confirmed rows only. Check-in takes an
optional time and clamps it into the booking's own window.

**Rows 16–20 shipped next** — the day grid, walk-ins, moves, blocks and the
customer typeahead. The grid is built on the web's `getCalendarDay`, so what
belongs on a day is decided in one place. Three rules worth restating: the hour
axis comes from opening hours rather than from what is booked, each lane
carries its **own** slot length, and a venue-wide closure is drawn in **every**
lane — filtering on `space_id` alone puts it in none and hides a closed venue.

**Rows 21–23 shipped after that** — the customer's own page, the CRM writes and
the waitlist. All four venue tabs are now live, which is the point where a venue
can run a day on the app with no web dashboard anywhere. Four things worth
restating:

- **One page shape for two readers.** The Calendar's typeahead and the Customers
  screen call the same endpoint (#20) and used to disagree about the key —
  `customers` for one, `rows` for the other, so the screen would have come back
  empty. It is `{rows, total}` for both, and `total` is what the header counts
  (it differs from `rows.length` as soon as a venue passes one 25-row page).
- **The segment chips filter on the server.** They were being sent and silently
  ignored. `regulars` is new on the server side — somebody who has been back,
  rather than somebody who came once.
- **Tags are set as a whole list**, not appended one at a time as on the web.
  The app edits a chip row and saves it, which also makes the write idempotent:
  a retry after a dropped connection cannot duplicate a tag.
- **Email is not editable** on #22, deliberately: it is the `(organization_id,
  email)` key the booking engine matches returning customers on, so changing it
  would either collide or split one person into two.

`Feature.signup`, `onboarding`, `venueSettings`, `today`, `calendar`,
`customers` and `venueWaitlist` are now `true`. One that looks like it should
have moved and has not:

- **`spaces`** gates every method on `RealSpacesRepository`, pricing rules and
  closures included — those are **#29**. Turning it on would open the space
  editor with two buttons that refuse.

**`claimExpiresAt` is always null** and the app must not draw a countdown from
nothing. There is no claim window on the server: `promoteWaitlist` emails the
earliest match a booking link, and whoever books first keeps the slot. Tracked
as D19.

## Backend follow-ups outside the contract

- Serve `/.well-known/assetlinks.json` (package `pro.reservme.app`, SHA-256 of
  the upload key **and** the Play App Signing key) and
  `/.well-known/apple-app-site-association` on `reservme.pro` — the marketing
  static site owns that host.
- ~~Email templates for the 6-digit verification / reset codes~~ — done
  (`deliverAuthCode`, alongside the web's link templates).
- Booking confirmation emails keep the `reservme.pro/<slug>/manage/<token>`
  link; the app imports it into the wallet.
