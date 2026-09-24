import '../../../core/model/enums.dart';
export '../../../core/model/opening_hours.dart' show DayHours, HoursInput;

/// Input rules for the six onboarding steps, ported from the web so the
/// screens refuse in place rather than round-tripping to find out.
///
/// Sources: Better Auth's `minPasswordLength: 10` (`src/lib/auth.ts`), the
/// `spaceSchema` and settings schema in `src/app/app/actions.ts`, and
/// `slugify` + `RESERVED_SLUGS` for the booking-page address.

/// O1 · the owner's account.
class SignupInput {
  const SignupInput({
    required this.name,
    required this.email,
    required this.password,
    this.acceptedTerms = false,
  });

  final String name;
  final String email;
  final String password;
  final bool acceptedTerms;

  /// Better Auth's minimum. Shown up front, because finding out after typing
  /// is worse than being told.
  static const minPasswordLength = 10;
  static final _email = RegExp(r'^[^@\s]+@[^@\s.]+\.[^@\s]+$');

  String? validate() {
    if (name.trim().isEmpty) return 'What should we call you?';
    if (name.trim().length > 120) return 'That name is too long.';
    if (!_email.hasMatch(email.trim())) return "That email doesn't look right.";
    if (password.length < minPasswordLength) {
      return 'Use at least $minPasswordLength characters.';
    }
    if (!acceptedTerms) return 'Please accept the terms to continue.';
    return null;
  }

  bool get isValid => validate() == null;
}

/// O3 · the venue and its public booking page.
class VenueInput {
  const VenueInput({
    required this.name,
    required this.slug,
    required this.timezone,
    required this.currency,
    this.address,
  });

  final String name;

  /// The `reservme.pro/<slug>` address.
  final String slug;
  final String timezone;
  final String currency;
  final String? address;

  /// The apex serves these as its own pages, so a venue cannot take them —
  /// the page would be shadowed and unreachable (`RESERVED_SLUGS`).
  static const reserved = {
    'privacy', 'terms', 'legal', 'dpa', 'about', 'contact', 'support',
    'pricing', 'login', 'signup', 'admin', 'app', 'api', 'healthz', 'www',
    'help', 'blog',
  };

  static final _slug = RegExp(r'^[a-z0-9]+(-[a-z0-9]+)*$');

  /// "Katipunan Courts" → "katipunan-courts", the same shape as the web's
  /// `slugify`, so a venue created here and one created there agree.
  static String slugify(String input, {String fallbackPrefix = 'venue'}) {
    final slug = input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    final capped = slug.length > 48 ? slug.substring(0, 48) : slug;
    return capped.isEmpty
        ? '$fallbackPrefix-${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}'
        : capped;
  }

  String? validate() {
    if (name.trim().isEmpty) return 'Give your venue a name.';
    if (name.trim().length > 120) return 'That name is too long.';
    final s = slug.trim();
    if (s.isEmpty) return 'Pick a booking-page address.';
    if (s.length > 48) return 'Keep the address under 48 characters.';
    if (!_slug.hasMatch(s)) {
      return 'Letters, numbers and dashes only.';
    }
    if (reserved.contains(s)) return 'That address is taken by ReservMe itself.';
    if (timezone.trim().isEmpty) return 'Pick a timezone.';
    if (currency.trim().length != 3) return 'Pick a currency.';
    if ((address ?? '').trim().length > 200) return 'That address is too long.';
    return null;
  }

  bool get isValid => validate() == null;
}

/// O4 · the first bookable space (`spaceSchema`).
class FirstSpaceInput {
  const FirstSpaceInput({
    required this.name,
    this.kind = SpaceKind.court,
    this.slotMinutes = 60,
    this.priceCents = 0,
    this.capacity = 1,
    this.photoPath,
  });

  final String name;
  final SpaceKind kind;
  final int slotMinutes;
  final int priceCents;
  final int capacity;

  /// A local file the owner picked. Optional — a space without one shows its
  /// kind placeholder everywhere, never a grey box.
  final String? photoPath;

  static const slotChoices = [15, 30, 45, 60, 90, 120];

  String? validate() {
    if (name.trim().isEmpty) return 'Give the space a name.';
    if (name.trim().length > 80) return 'That name is too long.';
    if (slotMinutes < 15 || slotMinutes > 1440) {
      return 'A slot is between 15 minutes and a day.';
    }
    if (capacity < 1 || capacity > 500) return 'Capacity is between 1 and 500.';
    if (priceCents < 0) return "A price can't be negative.";
    return null;
  }

  bool get isValid => validate() == null;
}

/// O6 · the booking rules (the settings schema's policy half).
class PolicyInput {
  const PolicyInput({
    this.cancellationMode = CancellationMode.grace,
    this.graceHours = 24,
    this.minNoticeMinutes = 60,
    this.maxHorizonDays = 60,
  });

  final CancellationMode cancellationMode;
  final int graceHours;
  final int minNoticeMinutes;
  final int maxHorizonDays;

  static const noticeChoices = [0, 30, 60, 120, 240, 1440];
  static const horizonChoices = [7, 14, 30, 60, 90, 180, 365];

  String? validate() {
    if (graceHours < 0 || graceHours > 720) {
      return 'A grace window is between 0 and 720 hours.';
    }
    if (minNoticeMinutes < 0 || minNoticeMinutes > 20160) {
      return 'Notice is between none and two weeks.';
    }
    if (maxHorizonDays < 1 || maxHorizonDays > 365) {
      return 'Bookings open between 1 and 365 days ahead.';
    }
    return null;
  }

  bool get isValid => validate() == null;

  PolicyInput copyWith({
    CancellationMode? cancellationMode,
    int? graceHours,
    int? minNoticeMinutes,
    int? maxHorizonDays,
  }) =>
      PolicyInput(
        cancellationMode: cancellationMode ?? this.cancellationMode,
        graceHours: graceHours ?? this.graceHours,
        minNoticeMinutes: minNoticeMinutes ?? this.minNoticeMinutes,
        maxHorizonDays: maxHorizonDays ?? this.maxHorizonDays,
      );

  static String noticeLabel(int minutes) => switch (minutes) {
        0 => 'No notice',
        < 60 => '$minutes minutes',
        60 => '1 hour',
        < 1440 => '${minutes ~/ 60} hours',
        _ => '${minutes ~/ 1440} day${minutes ~/ 1440 == 1 ? '' : 's'}',
      };

  static String horizonLabel(int days) =>
      days == 365 ? 'A year ahead' : '$days days ahead';
}
