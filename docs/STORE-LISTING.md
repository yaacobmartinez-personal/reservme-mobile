# Store listing — draft

Copy and answers for Google Play and the App Store. **Nothing here is filed.**
Every claim below has to be true of the build being submitted; several are not
true yet, and are marked.

## The app

| | |
|---|---|
| Name | ReservMe |
| Bundle / package | `pro.reservme.app` |
| Category | Business |
| Content rating | Everyone / 4+ |
| Countries | Philippines at launch |
| Price | Free to install; venues pay a monthly subscription |

## Short description (Play, 80 characters)

> Book a court in seconds. Run your venue from your pocket.

## Full description

> **For the people booking**
>
> No account, no password, no app fatigue. Open your venue's page, pick a time,
> and you are booked. Your bookings live on this phone, and a link in your
> email manages them from anywhere.
>
> **For the people running the place**
>
> ReservMe is the whole desk in your pocket: today's run sheet with check-in
> and no-show in one tap, a calendar you can take a walk-in booking on, your
> customers with their history and your notes, and your spaces with their
> hours and pricing.
>
> - A booking page for every venue, free of commission
> - Your customers book without making an account
> - Peak pricing, opening hours and closures, per space
> - Check in, cancel or move a booking from the run sheet
> - Insights: booked value, utilisation, and when people actually book
> - Built for Philippine venues — pesos, local time, pay at the venue

Rules of the house, same as the marketing site: **no invented social proof**.
No testimonials, no customer logos, no "trusted by N venues". Every number is
a product decision we control.

## Screenshots

Eight, phone portrait, from a `fake` build so the demo world is populated and
no real customer's name appears.

| # | Screen | Caption |
|---|---|---|
| 1 | O0 Welcome | Your courts, booked while you sleep |
| 2 | C1 Find a venue | No account needed to book |
| 3 | C3 Pick a slot | Live availability, in your venue's own time |
| 4 | V4 Today | The run sheet, with check-in in one tap |
| 5 | V7 Calendar | Take a walk-in without leaving the desk |
| 6 | V10 Customers | Who they are, and what you wrote down |
| 7 | G1 Space editor | Hours, peak pricing and closures per space |
| 8 | G5 Insights | Booked value, utilisation, peak hours |

**Not ready.** Screenshots need a device that renders (D18), and the Welcome
hero is an AI-generated placeholder that must be replaced first (D2b).

## Data safety (Play) / Privacy nutrition (App Store)

Answer for what the app *actually does today*. Re-check every line against the
build being submitted.

| Data | Collected | Shared | Why | Optional |
|---|---|---|---|---|
| Name | Yes | No | On a booking, so the venue knows who is coming | No, to book |
| Email | Yes | No | Confirmation and the manage link | No, to book |
| Phone | Yes | No | So the venue can reach you about the booking | Yes |
| Approximate location | No | — | — | — |
| Precise location | No | — | — | — |
| Payment info | No | — | v1 is pay at the venue; the app takes no payments | — |
| Photos | Yes | No | A venue's own space photos, uploaded by staff | Yes |
| Contacts | No | — | — | — |
| App activity / analytics | No | — | No analytics SDK is in the build | — |
| Crash logs | **Yes**, when `SENTRY_DSN` is set | No (Sentry is a processor) | App version, device model, OS, what the app was doing. Booking links and emails are scrubbed on the phone before sending | No |
| Diagnostics | **Yes**, same Sentry reports | No | As above | No |

Additional answers:

- **Is data encrypted in transit?** Yes, HTTPS throughout.
- **Can users request deletion?** Yes. Venue staff: Account → Delete your
  account. Customers, who have no account: Account → delete all local data,
  which wipes the wallet and preferences from the device.
- **Are there ads?** No.
- **Does the app share data with third parties?** No. Processors acting for
  us are not "sharing" under either store's definition: Brevo (email), Render
  (hosting), Neon (database), Sentry (crash reports). Name them in the privacy
  policy, which the web repo's `src/content/legal.ts` now does.
- **Apple privacy label:** Contact info (name, email, phone) and Diagnostics
  (crash data) — linked to the user for venue staff, *not* used for tracking.
  No tracking, so no App Tracking Transparency prompt.

### The bookings on a customer's phone

Worth stating plainly in the privacy policy, because it is unusual: customers
have no account. A booking is stored on the device, keyed by the manage token
from the confirmation email. That token is the capability — anyone holding the
link can manage the booking, exactly as with the emailed link itself. It lives
in app-private storage, is excluded from Android backup
(`allowBackup="false"`), and is never logged or sent anywhere but the venue's
own API.

## Account deletion (both stores require a route)

- In-app: **More → Your account → Delete your account**.
- Refused while you are the only owner of a venue, with the venues named — a
  venue with no owner has nobody who can pay for it or hand it on. Make
  someone else an owner first.
- Public URL for the Play listing: `https://<server host>/delete-account`
  — today `https://reservme-web.onrender.com/delete-account`. Served on every
  host, so it keeps working when the domain moves.

## Support and legal

| | Status |
|---|---|
| Support email | not decided |
| Privacy policy URL | `https://reservme-web.onrender.com/privacy` until the domain exists; linked in the app from sign-up and both Account screens |
| Terms URL | `https://reservme-web.onrender.com/terms` |
| Deletion URL (Play) | `https://reservme-web.onrender.com/delete-account` |

The policy names `privacy@reservme.pro` as its contact. That address does not
exist until the domain does — change `LEGAL.contactEmail` in the web repo to a
working address before submitting.
| Marketing URL | `reservme.pro` |

## Payments on iOS

A venue's subscription is paid by bank transfer (InstaPay/GCash) with a proof
upload. Apple treats a subscription paid inside an iOS app as in-app purchase
territory (guideline 3.1.1), so **on iOS the Billing screen shows the plan and
its status only** — no "How to pay", no payee details, no proof upload, and
the banners do not tell the owner to pay. `paymentsInApp` in
`lib/core/config/legal.dart` is the one switch. Android keeps the whole flow.
Say so in the App Review notes if asked: the subscription is sold and paid
outside the app.

## Before submitting

- [ ] D18: walk the app on a physical device
- [ ] D2b: replace the AI-generated onboarding photos
- [ ] D13: a backend to talk to, and the `Feature` flags flipped
- [ ] Well-known files served from the apex, so links skip the chooser
- [ ] Upload keystore created and backed up (docs/RELEASE.md)
- [ ] Support email decided (and `LEGAL.contactEmail` pointed at it)
- [x] Deletion-policy page written (`/delete-account`)
- [x] Privacy policy and terms linked in the app
- [x] No payment flow on iOS
- [ ] Screenshots captured from a `fake` build
- [ ] Data-safety answers re-checked against the submitted build
