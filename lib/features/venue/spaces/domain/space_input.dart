import '../../../../core/model/enums.dart';

/// Input rules for the space editor (G1), ported from `spaceSchema`,
/// `addPricingRule` and `addClosure` in `src/app/app/actions.ts` so the sheets
/// refuse in place with the server's own wording.

/// G1 · the basics. `price` is typed in pesos and stored in centavos, the same
/// conversion the web's `toCents` does — including its forgiving parse, which
/// strips anything that is not a digit or a dot and falls back to zero.
class SpaceInput {
  const SpaceInput({
    required this.name,
    this.kind = SpaceKind.court,
    this.capacity = 1,
    this.slotMinutes = 60,
    this.bufferMinutes = 0,
    this.priceCents = 0,
  });

  final String name;
  final SpaceKind kind;
  final int capacity;
  final int slotMinutes;
  final int bufferMinutes;
  final int priceCents;

  static const slotChoices = [15, 30, 45, 60, 90, 120];

  /// The web's `toCents`: pesos in, centavos out, never negative.
  static int toCents(String pesos) {
    final cleaned = pesos.replaceAll(RegExp(r'[^\d.]'), '');
    final value = double.tryParse(cleaned);
    if (value == null || !value.isFinite || value < 0) return 0;
    return (value * 100).round();
  }

  String? validate() {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'Give the space a name.';
    if (trimmed.length > 80) return 'That name is too long.';
    if (capacity < 1 || capacity > 500) return 'Capacity is between 1 and 500.';
    if (slotMinutes < 15 || slotMinutes > 1440) {
      return 'A slot is between 15 minutes and 24 hours.';
    }
    if (bufferMinutes < 0 || bufferMinutes > 240) {
      return 'A buffer is between none and 4 hours.';
    }
    return null;
  }

  bool get isValid => validate() == null;

  SpaceInput copyWith({
    String? name,
    SpaceKind? kind,
    int? capacity,
    int? slotMinutes,
    int? bufferMinutes,
    int? priceCents,
  }) =>
      SpaceInput(
        name: name ?? this.name,
        kind: kind ?? this.kind,
        capacity: capacity ?? this.capacity,
        slotMinutes: slotMinutes ?? this.slotMinutes,
        bufferMinutes: bufferMinutes ?? this.bufferMinutes,
        priceCents: priceCents ?? this.priceCents,
      );

  Map<String, dynamic> toJson() => {
        'name': name.trim(),
        'kind': kind.wire,
        'capacity': capacity,
        'slotMinutes': slotMinutes,
        'bufferMinutes': bufferMinutes,
        'priceCents': priceCents,
      };
}

/// G1 · a peak-price rule. Wall clock in the venue's own zone, weekdays stored
/// 0 = Sunday like `pricing_rule.weekdays`.
class PricingRuleInput {
  const PricingRuleInput({
    this.label = '',
    this.weekdays = const [],
    this.startsAt = '18:00',
    this.endsAt = '22:00',
    this.priceCents = 0,
  });

  final String label;
  final List<int> weekdays;
  final String startsAt;
  final String endsAt;
  final int priceCents;

  String? validate() {
    if (weekdays.isEmpty) return 'Pick at least one day.';
    if (endsAt.compareTo(startsAt) <= 0) {
      return 'The end time must be after the start.';
    }
    if (label.trim().length > 60) return 'Keep the label short.';
    return null;
  }

  bool get isValid => validate() == null;

  PricingRuleInput copyWith({
    String? label,
    List<int>? weekdays,
    String? startsAt,
    String? endsAt,
    int? priceCents,
  }) =>
      PricingRuleInput(
        label: label ?? this.label,
        weekdays: weekdays ?? this.weekdays,
        startsAt: startsAt ?? this.startsAt,
        endsAt: endsAt ?? this.endsAt,
        priceCents: priceCents ?? this.priceCents,
      );

  PricingRuleInput toggleDay(int weekday) => copyWith(
        weekdays: weekdays.contains(weekday)
            ? [for (final d in weekdays) if (d != weekday) d]
            : [...weekdays, weekday]
          ..sort(),
      );

  Map<String, dynamic> toJson() => {
        'label': label.trim().isEmpty ? null : label.trim(),
        'weekdays': weekdays,
        'startsAt': startsAt,
        'endsAt': endsAt,
        'priceCents': priceCents,
      };
}

/// G1/G2 · a closure. Venue-local wall clock, never an instant — the server
/// builds the timestamp in the venue's zone, exactly as `addClosure` does.
///
/// A closure with no `spaceId` shuts the whole venue.
class ClosureInput {
  const ClosureInput({
    this.spaceId,
    required this.fromDate,
    required this.fromTime,
    required this.toDate,
    required this.toTime,
    this.reason = '',
  });

  final String? spaceId;
  final String fromDate;
  final String fromTime;
  final String toDate;
  final String toTime;
  final String reason;

  String get from => '$fromDate $fromTime';
  String get to => '$toDate $toTime';

  /// [nowLocal] is the venue's own "YYYY-MM-DD HH:MM", so the comparison is
  /// the same string compare the rest of this class uses — and, more to the
  /// point, it is the *venue's* clock. A phone in another zone would otherwise
  /// decide for itself whether a window had passed.
  String? validate({String? nowLocal}) {
    if (to.compareTo(from) <= 0) return 'Please give a valid start and end.';
    if (reason.trim().length > 200) return 'Keep the reason short.';
    // A closure stops *new* bookings inside its window. One that has already
    // ended can stop nothing, and the editor would file it and then show
    // "Nothing coming up" — which reads as the save having failed.
    if (nowLocal != null && to.compareTo(nowLocal) <= 0) {
      return 'That window has already passed.';
    }
    return null;
  }

  bool get isValid => validate() == null;

  ClosureInput copyWith({
    String? spaceId,
    bool clearSpace = false,
    String? fromDate,
    String? fromTime,
    String? toDate,
    String? toTime,
    String? reason,
  }) =>
      ClosureInput(
        spaceId: clearSpace ? null : (spaceId ?? this.spaceId),
        fromDate: fromDate ?? this.fromDate,
        fromTime: fromTime ?? this.fromTime,
        toDate: toDate ?? this.toDate,
        toTime: toTime ?? this.toTime,
        reason: reason ?? this.reason,
      );

  Map<String, dynamic> toJson() => {
        'spaceId': spaceId,
        'date': fromDate,
        'from': fromTime,
        'toDate': toDate,
        'to': toTime,
        'reason': reason.trim().isEmpty ? null : reason.trim(),
      };
}
