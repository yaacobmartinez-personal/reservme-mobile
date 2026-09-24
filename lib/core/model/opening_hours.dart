/// A space's weekly opening hours, shared by onboarding (O5) and the space
/// editor (G1). Both write the whole week at once, the way the web's
/// `setOpeningHours` does: a closed day simply has no row.
library;

/// One weekday's window. Closed days simply have no row, exactly as
/// `setOpeningHours` writes them.
class DayHours {
  const DayHours({
    required this.weekday,
    required this.open,
    this.opensAt = '09:00',
    this.closesAt = '22:00',
  });

  /// 0 = Sunday … 6 = Saturday, matching `opening_hours.weekday`.
  final int weekday;
  final bool open;
  final String opensAt;
  final String closesAt;

  static const names = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  String get name => names[weekday];

  /// The web drops a row whose close is not after its open — the CHECK
  /// constraint would reject it anyway.
  bool get isUsable => open && closesAt.compareTo(opensAt) > 0;

  DayHours copyWith({bool? open, String? opensAt, String? closesAt}) => DayHours(
        weekday: weekday,
        open: open ?? this.open,
        opensAt: opensAt ?? this.opensAt,
        closesAt: closesAt ?? this.closesAt,
      );

  Map<String, dynamic> toJson() => {
        'weekday': weekday,
        'open': open,
        'opensAt': opensAt,
        'closesAt': closesAt,
      };

  factory DayHours.fromJson(Map<String, dynamic> json) => DayHours(
        weekday: (json['weekday'] as num).toInt(),
        open: json['open'] as bool? ?? false,
        opensAt: json['opensAt'] as String? ?? '09:00',
        closesAt: json['closesAt'] as String? ?? '22:00',
      );
}

/// O5 · the week. Monday first on screen, because that is how a venue reads
/// its own week, but stored 0 = Sunday like the column.
class HoursInput {
  const HoursInput(this.days);

  final List<DayHours> days;

  /// A new space's default: open every day 09:00–22:00, Sunday closed. The
  /// web seeds 08:00–22:00 on create; onboarding starts a little later
  /// because that is what a court actually opens at, and the owner adjusts.
  factory HoursInput.initial() => HoursInput([
        for (var weekday = 0; weekday < 7; weekday++)
          DayHours(weekday: weekday, open: weekday != 0),
      ]);

  /// Monday … Sunday, for display.
  List<DayHours> get weekOrder => [
        for (var i = 1; i <= 7; i++) days.firstWhere((d) => d.weekday == i % 7),
      ];

  String? validate() {
    if (!days.any((d) => d.isUsable)) {
      return 'Open on at least one day, or nobody can book.';
    }
    for (final day in days.where((d) => d.open)) {
      if (!day.isUsable) return '${day.name} closes before it opens.';
    }
    return null;
  }

  bool get isValid => validate() == null;

  HoursInput replacing(DayHours day) => HoursInput([
        for (final d in days) if (d.weekday == day.weekday) day else d,
      ]);

  /// "Copy Mon to all" — the same window every day, keeping which days are
  /// open.
  HoursInput copyFrom(int weekday) {
    final source = days.firstWhere((d) => d.weekday == weekday);
    return HoursInput([
      for (final d in days)
        d.copyWith(opensAt: source.opensAt, closesAt: source.closesAt),
    ]);
  }

  /// "Same every day" — open all seven on the source's window.
  HoursInput everyDay(int weekday) {
    final source = days.firstWhere((d) => d.weekday == weekday);
    return HoursInput([
      for (final d in days)
        d.copyWith(open: true, opensAt: source.opensAt, closesAt: source.closesAt),
    ]);
  }
}
