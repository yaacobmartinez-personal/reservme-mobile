/// The bundled onboarding photography, named once so no screen carries a
/// string literal.
///
/// These are **AI-generated placeholders**. They are good enough to show the
/// product, not good enough to ship: replace them with licensed or real venue
/// photography before store submission (docs/DEFERRED.md, D2). The Welcome
/// screen's hero matters most — it is the first thing an owner sees.
abstract final class Photos {
  static const court = 'assets/photos/court.webp';
  static const owner = 'assets/photos/owner.webp';
  static const studio = 'assets/photos/studio.webp';

  /// The Welcome hero: a floodlit padel court at dusk.
  static const padel = 'assets/photos/padel.webp';

  /// The "you're live" screen's QR poster.
  static const qr = 'assets/photos/qr.webp';

  static const all = [court, owner, studio, padel, qr];
}
