/// Staff booking input, validated exactly as the web's `bookingSchema` in
/// `src/app/app/calendar-actions.ts`: slots 1–24, party 1–500, notes ≤ 500,
/// name ≤ 120, phone ≤ 40, email lower-cased. Either an existing `customerId`
/// **or** a name + email; never neither.
///
/// Validated here rather than in the widget so the same rules apply to a
/// fake, a real request and a test, and so the error strings are the server's
/// own words.
class ManualBookingInput {
  const ManualBookingInput({
    required this.spaceId,
    required this.date,
    required this.time,
    this.slotCount = 1,
    this.partySize = 1,
    this.notes,
    this.customerId,
    this.name,
    this.email,
    this.phone,
  });

  final String spaceId;

  /// Venue-local "YYYY-MM-DD" and "HH:MM" — wall clock, never an instant, so
  /// the server builds the timestamp in the venue's own zone.
  final String date;
  final String time;
  final int slotCount;
  final int partySize;
  final String? notes;
  final String? customerId;
  final String? name;
  final String? email;
  final String? phone;

  static final _date = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  static final _time = RegExp(r'^\d{2}:\d{2}$');
  static final _email = RegExp(r'^[^@\s]+@[^@\s.]+\.[^@\s]+$');

  /// The server's message, or null when this would be accepted.
  String? validate() {
    if (spaceId.isEmpty) return 'Pick a space.';
    if (!_date.hasMatch(date) || !_time.hasMatch(time)) {
      return "That start time isn't valid.";
    }
    if (slotCount < 1 || slotCount > 24) return 'Please check the booking details.';
    if (partySize < 1 || partySize > 500) return 'Please check the booking details.';
    if ((notes ?? '').trim().length > 500) return 'Please check the booking details.';

    if (customerId != null && customerId!.isNotEmpty) return null;

    final n = (name ?? '').trim();
    final e = (email ?? '').trim();
    if (n.isEmpty || e.isEmpty) {
      return 'Choose a customer, or enter a name and email.';
    }
    if (n.length > 120) return 'Please check the booking details.';
    if (!_email.hasMatch(e)) return 'Please check the booking details.';
    if ((phone ?? '').trim().length > 40) return 'Please check the booking details.';
    return null;
  }

  bool get isValid => validate() == null;

  /// The payload the API takes, with the trimming and lower-casing the web's
  /// zod schema applies before it reaches the engine.
  Map<String, dynamic> toJson() => {
        'spaceId': spaceId,
        'date': date,
        'time': time,
        'slotCount': slotCount,
        'partySize': partySize,
        if ((notes ?? '').trim().isNotEmpty) 'notes': notes!.trim(),
        if ((customerId ?? '').isNotEmpty)
          'customerId': customerId
        else ...{
          'name': name!.trim(),
          'email': email!.trim().toLowerCase(),
          if ((phone ?? '').trim().isNotEmpty) 'phone': phone!.trim(),
        },
      };

  ManualBookingInput copyWith({
    String? spaceId,
    String? date,
    String? time,
    int? slotCount,
    int? partySize,
    String? notes,
    String? customerId,
    bool clearCustomer = false,
    String? name,
    String? email,
    String? phone,
  }) =>
      ManualBookingInput(
        spaceId: spaceId ?? this.spaceId,
        date: date ?? this.date,
        time: time ?? this.time,
        slotCount: slotCount ?? this.slotCount,
        partySize: partySize ?? this.partySize,
        notes: notes ?? this.notes,
        customerId: clearCustomer ? null : (customerId ?? this.customerId),
        name: clearCustomer ? null : (name ?? this.name),
        email: clearCustomer ? null : (email ?? this.email),
        phone: clearCustomer ? null : (phone ?? this.phone),
      );
}

/// Block-off input (`blockSchema` in the same file): a space or the whole
/// venue, a local date, a start and an end, and an optional reason ≤ 200.
class BlockInput {
  const BlockInput({
    this.spaceId,
    required this.date,
    required this.from,
    required this.to,
    this.reason,
  });

  /// Null blocks the whole venue.
  final String? spaceId;
  final String date;
  final String from;
  final String to;
  final String? reason;

  String? validate() {
    if (!ManualBookingInput._date.hasMatch(date) ||
        !ManualBookingInput._time.hasMatch(from) ||
        !ManualBookingInput._time.hasMatch(to)) {
      return 'Please give a valid start and end.';
    }
    // String compare is safe on zero-padded "HH:MM".
    if (to.compareTo(from) <= 0) return 'The end must be after the start.';
    if ((reason ?? '').trim().length > 200) return 'Please give a valid range.';
    return null;
  }

  bool get isValid => validate() == null;

  Map<String, dynamic> toJson() => {
        if (spaceId != null) 'spaceId': spaceId,
        'date': date,
        'from': from,
        'to': to,
        if ((reason ?? '').trim().isNotEmpty) 'reason': reason!.trim(),
      };

  BlockInput copyWith({
    String? spaceId,
    bool wholeVenue = false,
    String? date,
    String? from,
    String? to,
    String? reason,
  }) =>
      BlockInput(
        spaceId: wholeVenue ? null : (spaceId ?? this.spaceId),
        date: date ?? this.date,
        from: from ?? this.from,
        to: to ?? this.to,
        reason: reason ?? this.reason,
      );
}
