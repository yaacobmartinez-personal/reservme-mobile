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
| 20 | `GET /mobile/venues/{slug}/customers?q=&cursor=` | member | → `{customers: [CustomerSummary], next?}` | 403 | `searchCustomers` |
| 21 | `GET /mobile/venues/{slug}/customers/{id}` | member | → `{customer, bookings: [Booking], notes: [{id, body, authorName, createdAt}]}` | 404 | customer detail page |
| 22 | `POST …/customers/{id}/notes` · `DELETE …/notes/{noteId}` · `PUT …/customers/{id}/tags` · `PATCH …/customers/{id}` | member | per `customer-actions.ts` | 400, 404 | `customer-actions.ts` |
| 23 | `GET /mobile/venues/{slug}/waitlist` | member | → `{entries: [{id, customerName, spaceName, startsAt, endsAt, status, notifiedAt?, claimExpiresAt?, createdAt}]}` | 403 | waitlist page |
| 24 | `GET /mobile/venues/{slug}/spaces` · `POST …/spaces/{id}/active {active}` | member (toggle: admin) | → `{spaces}` / `{space}` | 403 | `setSpaceActive` |
| 25 | `POST /mobile/auth/signup` `{name, email, password}` → `{token, user}` · `POST /mobile/auth/verify` `{code}` → `{user}` · `POST /mobile/auth/resend-verification` | none / bearer | owner account + 6-digit email code | 400 fieldErrors, 409 email taken, 429 | Better Auth signUp.email + verification |
| 26 | `POST /mobile/auth/reset-password` | none | `{email, code, password}` → `{token, user}` | 400 bad code | Better Auth reset |
| 27 | `POST /mobile/venues` · `GET /mobile/venues/slug-available?slug=` | bearer | `{name, slug, timezone, address?, currency?}` → `201 {venue: VenueMembership}` (trialing subscription) | 400, 409 slug taken | `/api/venue/init`, slug rules |
| 28 | `POST /mobile/venues/{slug}/spaces` · `PATCH …/spaces/{id}` · `DELETE …/spaces/{id}` · `PUT …/spaces/{id}/hours` `[{weekday, opensAt, closesAt}]` · `POST …/spaces/{id}/image` (multipart `image`, ≤2 MB) · `DELETE …/spaces/{id}/image` | admin | space editor; the photo is optional and every surface shows the kind placeholder without one | 400, 404, 413 | `createSpace`, `updateSpace`, `setOpeningHours`, `updateSpaceImage`, `/api/upload` |
| 29 | `POST …/spaces/{id}/pricing-rules` · `DELETE …/pricing-rules/{id}` · `POST /mobile/venues/{slug}/closures` · `DELETE …/closures/{id}` · `POST …/sessions` · `POST …/sessions/{id}/cancel` | admin | pricing, closures, open-play sessions | 400, 409 | `addPricingRule`, `addClosure`, `session-actions.ts` |
| 30 | `PATCH /mobile/venues/{slug}` · `POST …/branding/{logo\|cover}` (multipart) | admin | settings: tagline, address, theme, cancellation, notice/horizon, refund terms, gcash name, timezone | 400 | `updateVenueSettings`, `branding-actions.ts` |
| 31 | `GET …/team` · `POST …/team/invitations` `{email, role}` · `DELETE …/team/invitations/{id}` · `PATCH …/team/members/{id}` `{role}` · `DELETE …/team/members/{id}` | admin (owner for owner role) | → `{members: [{id, userId, name, email, role, isSelf, joinedAt}], invitations: [{id, email, role, expiresAt}]}` | 403, 409 `last_owner` | Better Auth org plugin + last-owner guard |
| 32 | `GET …/billing` · `POST …/billing/proof` (multipart: `amountCents`, `reference`, `image`) | owner | → `{band, priceCents, status, trialEndsAt, paidUntil?, instapayQrUrl, history: []}` | 400 | `src/lib/billing.ts`, `billing-actions.ts` |
| 33 | `GET …/insights?period=7d\|30d\|90d` | member | → `{kpis: {bookedValueCents, bookedValueDelta, bookings, bookingsDelta, utilisation, noShowRate}, bookedByDay: [{date, cents}], peakHours: [[0..1]×7×14], revenueBySpace: [{spaceId, name, cents}]}` | 403 | `src/lib/analytics.ts` |
| 34 | `DELETE /mobile/me` | bearer | → `{ok: true}` | 409 `sole_owner` `{venues: [slug]}` | account deletion with the sole-owner guard |

## Backend follow-ups outside the contract

- Serve `/.well-known/assetlinks.json` (package `pro.reservme.app`, SHA-256 of
  the upload key **and** the Play App Signing key) and
  `/.well-known/apple-app-site-association` on `reservme.pro` — the marketing
  static site owns that host.
- Email templates for the 6-digit verification / reset codes (the web uses
  links).
- Booking confirmation emails keep the `reservme.pro/<slug>/manage/<token>`
  link; the app imports it into the wallet.
