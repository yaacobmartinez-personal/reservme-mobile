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
| 3 | `POST /public/venues/{slug}/bookings` | none | `{spaceId, startsAt, endsAt, name, email, phone?, promo?, partySize?}` → `201 {booking}` with `manageToken`; a replayed `Idempotency-Key` answers `200` with the first one | 400, 403 suspended, 409 `slot_taken`, 429 | `reserveSpace` + the shared discount/announce tail |
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
| 29 | `POST …/spaces/{id}/pricing-rules` · `DELETE …/spaces/{id}/pricing-rules/{ruleId}` · `POST …/closures` · `DELETE …/closures/{closureId}?forSpaceId=` | admin | each answers `{space}` — the whole space, so the editor redraws in one round trip | 400 `fieldErrors`, 404 | `addPricingRule`, `addClosure` |
| 30 | `PATCH /mobile/venues/{slug}` · `POST …/branding/{logo\|cover}` (multipart) | admin | settings: tagline, address, theme, cancellation, notice/horizon, refund terms, gcash name, timezone | 400 | `updateVenueSettings`, `branding-actions.ts` |
| 31 | `GET …/team` · `POST …/team/invitations` · `DELETE …/team/invitations/{id}` · `PATCH …/team/members/{id}` · `DELETE …/team/members/{id}` | read: member, write: admin | each answers the whole team | 400, 403, 404, 409 `last_owner` | `listMembers` + Better Auth org plugin |
| 32 | `GET …/billing` · `POST …/billing/proof` (multipart: reference, paidAt, optional image) | owner/admin | → `{billing}` | 400, 409 `quoted` \| `already_pending`, 413 | `getBillingState`, `listOrgPayments`, `instapayConfig` |
| 33 | `GET …/insights?period=today\|7d\|30d\|90d` | member | → `{insights}` — an unknown period is 30 days, not a 400 | 403 | `getDashboard` |
| 34 | `DELETE /mobile/me` | bearer | → `{ok: true}` | 409 `sole_owner` `{venues: [slug]}` | account deletion with the sole-owner guard |
| 35 | `GET /mobile/admin/overview` | platform admin | → `{totals: {tenants, suspended, activeSpaces, bookingsLast30, customers, runRateCents}, radar: {endingSoon, inGrace, suspended: [Tenant]}, pendingPayments, growth: [{month, signups, cancellations, cumulative}]}` | 401, 404 (not an admin) | the console's front page |
| 36 | `GET /mobile/admin/tenants?q=` · `GET /mobile/admin/tenants/{orgId}` | platform admin | → `{tenants: [Tenant]}` · `{tenant, spaces, members, recentBookings, payments}` | 404 | every venue; one venue |
| 37 | `POST …/tenants/{orgId}/suspend` `{reason?}` · `POST …/reactivate` · `POST …/email` `{subject, body}` | platform admin | → `{ok: true}` | 400, 404, 409 `no_owner_email`, 502 `send_failed` | venue access, and a message to the first owner |
| 38 | `POST …/tenants/{orgId}/billing` `{action: "mark_paid", paidUntil: "YYYY-MM-DD"}` \| `{action: "comp"}` \| `{action: "cancel"}` | platform admin | → `{ok: true}` | 400, 404 | billing overrides; mark-paid is inclusive |
| 39 | `GET /mobile/admin/payments` · `POST …/payments/{id}/approve` · `POST …/payments/{id}/reject` `{note?}` | platform admin | → `{payments: [Payment]}` · `{ok: true}` | 404, 409 `not_submitted` | the verification queue |
| 40 | `GET` · `PUT /mobile/admin/billing-config` `{qrUrl, payee, account}` | platform admin | → `{qrUrl, payee, account, configured}` | 400 | the platform's InstaPay details |
| 41 | `GET /mobile/admin/audit?limit=` · `GET /mobile/admin/admins` · `POST …/admins/{userId}/revoke` | platform admin | → `{entries}` · `{admins}` · `{ok: true}` | 404, 409 `last_admin` | the audit trail; admins |

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

**Every venue-side flag is now `true`**: `venueLogin`, `signup`, `onboarding`,
`venueSettings`, `today`, `calendar`, `customers`, `venueWaitlist`, `spaces`
and `deleteAccount`. What is still false is the customer half (#1–#9) and the
three owner screens behind More — team (#31), billing (#32), insights (#33).

**Row 29 shipped last on the venue side**, which is what let `Feature.spaces`
move: one flag gates every method on `RealSpacesRepository`, so the editor
could not open at all until peak pricing and closures existed. Three notes:

- **A pricing rule's times have no zone**, and must not. They are `time`
  columns: 18:00 is the venue's evening wherever the server runs, and an
  instant would move it when a clock somewhere else changed. A **closure** is
  the opposite — a real instant, built with `make_timestamptz(..., timezone)`
  in Postgres for exactly the reason `calendar-json.ts` documents.
- **A closure from the editor is not a block from the calendar (#19)**, though
  both write `closure`. A block shuts a window of *today* and any staff member
  can put one in; a closure here can run across days and is owner-or-admin,
  because a venue-wide one takes every space off sale. Neither cancels what is
  already booked.
- **Sessions are not in #29.** The row proposed create/cancel, and the app
  treats sessions as read-only in v1 (D17) — `RealSpacesRepository` never calls
  them. Building endpoints nothing calls is how a contract starts lying, so
  they are deferred with the feature.

**`claimExpiresAt` is always null** and the app must not draw a countdown from
nothing. There is no claim window on the server: `promoteWaitlist` emails the
earliest match a booking link, and whoever books first keeps the slot. Tracked
as D19.

**Rows 31–33 finished the venue side.** Every flag except the customer half is
now true. Four things worth restating:

- **The last-owner guard is ours, not Better Auth's.** Demoting or removing the
  only owner leaves a venue nobody can hand over, invite into or bill, and it
  is not recoverable from inside the app. Both writes check it and answer
  409 `last_owner`. Changing your *own* role is allowed: an owner handing the
  venue on and stepping down is a real thing, and since only an owner can
  demote an owner, forbidding it would make the guard unreachable.
- **Invitations go through the organization plugin**, not a direct `invitation`
  insert, so the email, the 48-hour expiry and the accept page keep working.
  The invitation is checked against *this* venue before it is cancelled — the
  id alone would let an admin of one venue revoke another's invite.
- **The billing amount is never in the request.** It comes from the band,
  which is itself derived from the *active* space count at read time: pausing a
  court drops a band with no write anywhere. A quoted plan and an
  already-pending payment are 409s, not validation errors.
- **Insights differs from the web dashboard twice, on purpose.** Value and
  utilisation arrive as one row per day rather than two series, and there is no
  "awaiting payments" tile — v1 is pay-at-venue, so it would be a permanent
  zero.

**Rows 1–9 finished it: the public booking loop.** Every row of the contract
is live. The things worth restating are all about this being the one surface a
stranger can write to:

- **There is no Turnstile, and no equivalent.** It is a browser challenge; an
  app cannot run one without embedding a webview in a booking form. Public
  writes are rate-limited instead, on three buckets — by IP, by venue and by
  device (`X-Device-Id`, the app's installation id). The first two are *the
  same buckets the web form uses*, so a venue has one budget however the
  attempt arrives, not two. Be clear about what this does not buy: an attacker
  with many IPs and a scripted client is not stopped by any of it, and the
  device id is self-reported. It stops floods, not a motivated adversary. Play
  Integrity and App Attest are the real answer and are not in v1 (**D24**).
- **`Idempotency-Key` is honoured**, per venue, on both booking endpoints. The
  key is the *caller's* and must be identical across retries of one attempt —
  the client used to mint one per request, which gave every retry a fresh key
  and made the header decorative. The controller now holds the key across a
  failure and clears it only when the server has answered.
- **The organisation comes from the slug, never the body.** A space id selects
  among that venue's spaces; it does not name one. The same is true of a
  session id, a manage token and a waitlist space.
- **The manage token is the capability.** It comes back exactly twice — when
  the booking is made, and when the holder reads it back — and never anywhere
  else. `getManageableBooking` matches it against the slug, so a token cannot
  be read under another venue.
- **Suspension refuses writes, not reads.** A suspended venue's page still
  answers so it can explain itself, and an existing booking can still be
  opened and cancelled. Only new bookings are refused.
- **Availability is a prediction.** The exclusion constraint decides, so
  `slot_taken` is a normal answer on a slot the grid showed as open.

**Rows 35–41: the platform-admin console.** The app is the only surface after
launch, so the web's `/admin` console comes with it. What is worth restating:

- **Admin status is read from `platform_admin` on every request**, never
  cached in a token. `/me` carries `platformAdmin` so the app can show the
  entry, but every admin route checks for itself, and a revoke lands on the
  next tap rather than the next sign-in.
- **A signed-in non-admin gets 404, not 403.** A venue owner's token should
  not be able to confirm the console exists.
- **Both surfaces share one set of rules** (`src/lib/admin/operations.ts`): an
  approval extends a month from the later of now and the paid-through date,
  approving twice is a 409 and not a second month, a payment or comp lifts a
  *billing* suspension and never a manual one, and the last admin cannot be
  revoked.
- **Every decision is audited with the real person and the request's origin.**
  The IP stays on the server; the app is shown who, what and when.
- **`PUT billing-config` clears an empty field.** Keeping the current QR means
  sending it back — the app reads it first when no new image was picked.
- **Not here, deliberately:** impersonation (it sets a browser cookie on the
  web host and means nothing in the app) and granting admin, which stays
  `scripts/grant-admin.ts` — making someone a platform admin should need
  database access, not a phone.

## Backend follow-ups outside the contract

- Serve `/.well-known/assetlinks.json` (package `pro.reservme.app`, SHA-256 of
  the upload key **and** the Play App Signing key) and
  `/.well-known/apple-app-site-association` on `reservme.pro` — the marketing
  static site owns that host.
- ~~Email templates for the 6-digit verification / reset codes~~ — done
  (`deliverAuthCode`, alongside the web's link templates).
- Booking confirmation emails keep the `reservme.pro/<slug>/manage/<token>`
  link; the app imports it into the wallet.
