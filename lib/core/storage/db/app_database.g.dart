// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WalletBookingsTable extends WalletBookings
    with TableInfo<$WalletBookingsTable, WalletRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletBookingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _venueSlugMeta = const VerificationMeta(
    'venueSlug',
  );
  @override
  late final GeneratedColumn<String> venueSlug = GeneratedColumn<String>(
    'venue_slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _manageTokenMeta = const VerificationMeta(
    'manageToken',
  );
  @override
  late final GeneratedColumn<String> manageToken = GeneratedColumn<String>(
    'manage_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueNameMeta = const VerificationMeta(
    'venueName',
  );
  @override
  late final GeneratedColumn<String> venueName = GeneratedColumn<String>(
    'venue_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueThemeMeta = const VerificationMeta(
    'venueTheme',
  );
  @override
  late final GeneratedColumn<String> venueTheme = GeneratedColumn<String>(
    'venue_theme',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pine'),
  );
  static const VerificationMeta _spaceNameMeta = const VerificationMeta(
    'spaceName',
  );
  @override
  late final GeneratedColumn<String> spaceName = GeneratedColumn<String>(
    'space_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Asia/Manila'),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PHP'),
  );
  static const VerificationMeta _startsAtMeta = const VerificationMeta(
    'startsAt',
  );
  @override
  late final GeneratedColumn<DateTime> startsAt = GeneratedColumn<DateTime>(
    'starts_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endsAtMeta = const VerificationMeta('endsAt');
  @override
  late final GeneratedColumn<DateTime> endsAt = GeneratedColumn<DateTime>(
    'ends_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('confirmed'),
  );
  static const VerificationMeta _snapshotMeta = const VerificationMeta(
    'snapshot',
  );
  @override
  late final GeneratedColumn<String> snapshot = GeneratedColumn<String>(
    'snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    venueSlug,
    manageToken,
    reference,
    venueName,
    venueTheme,
    spaceName,
    timezone,
    currency,
    startsAt,
    endsAt,
    amountCents,
    status,
    snapshot,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallet_bookings';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalletRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('venue_slug')) {
      context.handle(
        _venueSlugMeta,
        venueSlug.isAcceptableOrUnknown(data['venue_slug']!, _venueSlugMeta),
      );
    } else if (isInserting) {
      context.missing(_venueSlugMeta);
    }
    if (data.containsKey('manage_token')) {
      context.handle(
        _manageTokenMeta,
        manageToken.isAcceptableOrUnknown(
          data['manage_token']!,
          _manageTokenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_manageTokenMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('venue_name')) {
      context.handle(
        _venueNameMeta,
        venueName.isAcceptableOrUnknown(data['venue_name']!, _venueNameMeta),
      );
    } else if (isInserting) {
      context.missing(_venueNameMeta);
    }
    if (data.containsKey('venue_theme')) {
      context.handle(
        _venueThemeMeta,
        venueTheme.isAcceptableOrUnknown(data['venue_theme']!, _venueThemeMeta),
      );
    }
    if (data.containsKey('space_name')) {
      context.handle(
        _spaceNameMeta,
        spaceName.isAcceptableOrUnknown(data['space_name']!, _spaceNameMeta),
      );
    } else if (isInserting) {
      context.missing(_spaceNameMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('starts_at')) {
      context.handle(
        _startsAtMeta,
        startsAt.isAcceptableOrUnknown(data['starts_at']!, _startsAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startsAtMeta);
    }
    if (data.containsKey('ends_at')) {
      context.handle(
        _endsAtMeta,
        endsAt.isAcceptableOrUnknown(data['ends_at']!, _endsAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endsAtMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('snapshot')) {
      context.handle(
        _snapshotMeta,
        snapshot.isAcceptableOrUnknown(data['snapshot']!, _snapshotMeta),
      );
    } else if (isInserting) {
      context.missing(_snapshotMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSyncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {venueSlug, manageToken};
  @override
  WalletRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalletRow(
      venueSlug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_slug'],
      )!,
      manageToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manage_token'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
      venueName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_name'],
      )!,
      venueTheme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_theme'],
      )!,
      spaceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}space_name'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      startsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}starts_at'],
      )!,
      endsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ends_at'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      snapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snapshot'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      )!,
    );
  }

  @override
  $WalletBookingsTable createAlias(String alias) {
    return $WalletBookingsTable(attachedDatabase, alias);
  }
}

class WalletRow extends DataClass implements Insertable<WalletRow> {
  final String venueSlug;
  final String manageToken;
  final String reference;
  final String venueName;
  final String venueTheme;
  final String spaceName;
  final String timezone;
  final String currency;
  final DateTime startsAt;
  final DateTime endsAt;
  final int amountCents;
  final String status;

  /// The whole [Booking] as JSON, so the detail screen renders offline
  /// exactly as it did online.
  final String snapshot;
  final DateTime lastSyncedAt;
  const WalletRow({
    required this.venueSlug,
    required this.manageToken,
    required this.reference,
    required this.venueName,
    required this.venueTheme,
    required this.spaceName,
    required this.timezone,
    required this.currency,
    required this.startsAt,
    required this.endsAt,
    required this.amountCents,
    required this.status,
    required this.snapshot,
    required this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['venue_slug'] = Variable<String>(venueSlug);
    map['manage_token'] = Variable<String>(manageToken);
    map['reference'] = Variable<String>(reference);
    map['venue_name'] = Variable<String>(venueName);
    map['venue_theme'] = Variable<String>(venueTheme);
    map['space_name'] = Variable<String>(spaceName);
    map['timezone'] = Variable<String>(timezone);
    map['currency'] = Variable<String>(currency);
    map['starts_at'] = Variable<DateTime>(startsAt);
    map['ends_at'] = Variable<DateTime>(endsAt);
    map['amount_cents'] = Variable<int>(amountCents);
    map['status'] = Variable<String>(status);
    map['snapshot'] = Variable<String>(snapshot);
    map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    return map;
  }

  WalletBookingsCompanion toCompanion(bool nullToAbsent) {
    return WalletBookingsCompanion(
      venueSlug: Value(venueSlug),
      manageToken: Value(manageToken),
      reference: Value(reference),
      venueName: Value(venueName),
      venueTheme: Value(venueTheme),
      spaceName: Value(spaceName),
      timezone: Value(timezone),
      currency: Value(currency),
      startsAt: Value(startsAt),
      endsAt: Value(endsAt),
      amountCents: Value(amountCents),
      status: Value(status),
      snapshot: Value(snapshot),
      lastSyncedAt: Value(lastSyncedAt),
    );
  }

  factory WalletRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalletRow(
      venueSlug: serializer.fromJson<String>(json['venueSlug']),
      manageToken: serializer.fromJson<String>(json['manageToken']),
      reference: serializer.fromJson<String>(json['reference']),
      venueName: serializer.fromJson<String>(json['venueName']),
      venueTheme: serializer.fromJson<String>(json['venueTheme']),
      spaceName: serializer.fromJson<String>(json['spaceName']),
      timezone: serializer.fromJson<String>(json['timezone']),
      currency: serializer.fromJson<String>(json['currency']),
      startsAt: serializer.fromJson<DateTime>(json['startsAt']),
      endsAt: serializer.fromJson<DateTime>(json['endsAt']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      status: serializer.fromJson<String>(json['status']),
      snapshot: serializer.fromJson<String>(json['snapshot']),
      lastSyncedAt: serializer.fromJson<DateTime>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'venueSlug': serializer.toJson<String>(venueSlug),
      'manageToken': serializer.toJson<String>(manageToken),
      'reference': serializer.toJson<String>(reference),
      'venueName': serializer.toJson<String>(venueName),
      'venueTheme': serializer.toJson<String>(venueTheme),
      'spaceName': serializer.toJson<String>(spaceName),
      'timezone': serializer.toJson<String>(timezone),
      'currency': serializer.toJson<String>(currency),
      'startsAt': serializer.toJson<DateTime>(startsAt),
      'endsAt': serializer.toJson<DateTime>(endsAt),
      'amountCents': serializer.toJson<int>(amountCents),
      'status': serializer.toJson<String>(status),
      'snapshot': serializer.toJson<String>(snapshot),
      'lastSyncedAt': serializer.toJson<DateTime>(lastSyncedAt),
    };
  }

  WalletRow copyWith({
    String? venueSlug,
    String? manageToken,
    String? reference,
    String? venueName,
    String? venueTheme,
    String? spaceName,
    String? timezone,
    String? currency,
    DateTime? startsAt,
    DateTime? endsAt,
    int? amountCents,
    String? status,
    String? snapshot,
    DateTime? lastSyncedAt,
  }) => WalletRow(
    venueSlug: venueSlug ?? this.venueSlug,
    manageToken: manageToken ?? this.manageToken,
    reference: reference ?? this.reference,
    venueName: venueName ?? this.venueName,
    venueTheme: venueTheme ?? this.venueTheme,
    spaceName: spaceName ?? this.spaceName,
    timezone: timezone ?? this.timezone,
    currency: currency ?? this.currency,
    startsAt: startsAt ?? this.startsAt,
    endsAt: endsAt ?? this.endsAt,
    amountCents: amountCents ?? this.amountCents,
    status: status ?? this.status,
    snapshot: snapshot ?? this.snapshot,
    lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
  );
  WalletRow copyWithCompanion(WalletBookingsCompanion data) {
    return WalletRow(
      venueSlug: data.venueSlug.present ? data.venueSlug.value : this.venueSlug,
      manageToken: data.manageToken.present
          ? data.manageToken.value
          : this.manageToken,
      reference: data.reference.present ? data.reference.value : this.reference,
      venueName: data.venueName.present ? data.venueName.value : this.venueName,
      venueTheme: data.venueTheme.present
          ? data.venueTheme.value
          : this.venueTheme,
      spaceName: data.spaceName.present ? data.spaceName.value : this.spaceName,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      currency: data.currency.present ? data.currency.value : this.currency,
      startsAt: data.startsAt.present ? data.startsAt.value : this.startsAt,
      endsAt: data.endsAt.present ? data.endsAt.value : this.endsAt,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      status: data.status.present ? data.status.value : this.status,
      snapshot: data.snapshot.present ? data.snapshot.value : this.snapshot,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalletRow(')
          ..write('venueSlug: $venueSlug, ')
          ..write('manageToken: $manageToken, ')
          ..write('reference: $reference, ')
          ..write('venueName: $venueName, ')
          ..write('venueTheme: $venueTheme, ')
          ..write('spaceName: $spaceName, ')
          ..write('timezone: $timezone, ')
          ..write('currency: $currency, ')
          ..write('startsAt: $startsAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('amountCents: $amountCents, ')
          ..write('status: $status, ')
          ..write('snapshot: $snapshot, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    venueSlug,
    manageToken,
    reference,
    venueName,
    venueTheme,
    spaceName,
    timezone,
    currency,
    startsAt,
    endsAt,
    amountCents,
    status,
    snapshot,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalletRow &&
          other.venueSlug == this.venueSlug &&
          other.manageToken == this.manageToken &&
          other.reference == this.reference &&
          other.venueName == this.venueName &&
          other.venueTheme == this.venueTheme &&
          other.spaceName == this.spaceName &&
          other.timezone == this.timezone &&
          other.currency == this.currency &&
          other.startsAt == this.startsAt &&
          other.endsAt == this.endsAt &&
          other.amountCents == this.amountCents &&
          other.status == this.status &&
          other.snapshot == this.snapshot &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class WalletBookingsCompanion extends UpdateCompanion<WalletRow> {
  final Value<String> venueSlug;
  final Value<String> manageToken;
  final Value<String> reference;
  final Value<String> venueName;
  final Value<String> venueTheme;
  final Value<String> spaceName;
  final Value<String> timezone;
  final Value<String> currency;
  final Value<DateTime> startsAt;
  final Value<DateTime> endsAt;
  final Value<int> amountCents;
  final Value<String> status;
  final Value<String> snapshot;
  final Value<DateTime> lastSyncedAt;
  final Value<int> rowid;
  const WalletBookingsCompanion({
    this.venueSlug = const Value.absent(),
    this.manageToken = const Value.absent(),
    this.reference = const Value.absent(),
    this.venueName = const Value.absent(),
    this.venueTheme = const Value.absent(),
    this.spaceName = const Value.absent(),
    this.timezone = const Value.absent(),
    this.currency = const Value.absent(),
    this.startsAt = const Value.absent(),
    this.endsAt = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.status = const Value.absent(),
    this.snapshot = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalletBookingsCompanion.insert({
    required String venueSlug,
    required String manageToken,
    required String reference,
    required String venueName,
    this.venueTheme = const Value.absent(),
    required String spaceName,
    this.timezone = const Value.absent(),
    this.currency = const Value.absent(),
    required DateTime startsAt,
    required DateTime endsAt,
    this.amountCents = const Value.absent(),
    this.status = const Value.absent(),
    required String snapshot,
    required DateTime lastSyncedAt,
    this.rowid = const Value.absent(),
  }) : venueSlug = Value(venueSlug),
       manageToken = Value(manageToken),
       reference = Value(reference),
       venueName = Value(venueName),
       spaceName = Value(spaceName),
       startsAt = Value(startsAt),
       endsAt = Value(endsAt),
       snapshot = Value(snapshot),
       lastSyncedAt = Value(lastSyncedAt);
  static Insertable<WalletRow> custom({
    Expression<String>? venueSlug,
    Expression<String>? manageToken,
    Expression<String>? reference,
    Expression<String>? venueName,
    Expression<String>? venueTheme,
    Expression<String>? spaceName,
    Expression<String>? timezone,
    Expression<String>? currency,
    Expression<DateTime>? startsAt,
    Expression<DateTime>? endsAt,
    Expression<int>? amountCents,
    Expression<String>? status,
    Expression<String>? snapshot,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (venueSlug != null) 'venue_slug': venueSlug,
      if (manageToken != null) 'manage_token': manageToken,
      if (reference != null) 'reference': reference,
      if (venueName != null) 'venue_name': venueName,
      if (venueTheme != null) 'venue_theme': venueTheme,
      if (spaceName != null) 'space_name': spaceName,
      if (timezone != null) 'timezone': timezone,
      if (currency != null) 'currency': currency,
      if (startsAt != null) 'starts_at': startsAt,
      if (endsAt != null) 'ends_at': endsAt,
      if (amountCents != null) 'amount_cents': amountCents,
      if (status != null) 'status': status,
      if (snapshot != null) 'snapshot': snapshot,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalletBookingsCompanion copyWith({
    Value<String>? venueSlug,
    Value<String>? manageToken,
    Value<String>? reference,
    Value<String>? venueName,
    Value<String>? venueTheme,
    Value<String>? spaceName,
    Value<String>? timezone,
    Value<String>? currency,
    Value<DateTime>? startsAt,
    Value<DateTime>? endsAt,
    Value<int>? amountCents,
    Value<String>? status,
    Value<String>? snapshot,
    Value<DateTime>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return WalletBookingsCompanion(
      venueSlug: venueSlug ?? this.venueSlug,
      manageToken: manageToken ?? this.manageToken,
      reference: reference ?? this.reference,
      venueName: venueName ?? this.venueName,
      venueTheme: venueTheme ?? this.venueTheme,
      spaceName: spaceName ?? this.spaceName,
      timezone: timezone ?? this.timezone,
      currency: currency ?? this.currency,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      amountCents: amountCents ?? this.amountCents,
      status: status ?? this.status,
      snapshot: snapshot ?? this.snapshot,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (venueSlug.present) {
      map['venue_slug'] = Variable<String>(venueSlug.value);
    }
    if (manageToken.present) {
      map['manage_token'] = Variable<String>(manageToken.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (venueName.present) {
      map['venue_name'] = Variable<String>(venueName.value);
    }
    if (venueTheme.present) {
      map['venue_theme'] = Variable<String>(venueTheme.value);
    }
    if (spaceName.present) {
      map['space_name'] = Variable<String>(spaceName.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (startsAt.present) {
      map['starts_at'] = Variable<DateTime>(startsAt.value);
    }
    if (endsAt.present) {
      map['ends_at'] = Variable<DateTime>(endsAt.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (snapshot.present) {
      map['snapshot'] = Variable<String>(snapshot.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletBookingsCompanion(')
          ..write('venueSlug: $venueSlug, ')
          ..write('manageToken: $manageToken, ')
          ..write('reference: $reference, ')
          ..write('venueName: $venueName, ')
          ..write('venueTheme: $venueTheme, ')
          ..write('spaceName: $spaceName, ')
          ..write('timezone: $timezone, ')
          ..write('currency: $currency, ')
          ..write('startsAt: $startsAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('amountCents: $amountCents, ')
          ..write('status: $status, ')
          ..write('snapshot: $snapshot, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecentVenuesTable extends RecentVenues
    with TableInfo<$RecentVenuesTable, RecentVenueRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentVenuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
    'theme',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pine'),
  );
  static const VerificationMeta _taglineMeta = const VerificationMeta(
    'tagline',
  );
  @override
  late final GeneratedColumn<String> tagline = GeneratedColumn<String>(
    'tagline',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverUrlMeta = const VerificationMeta(
    'coverUrl',
  );
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
    'cover_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastBookedAtMeta = const VerificationMeta(
    'lastBookedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastBookedAt = GeneratedColumn<DateTime>(
    'last_booked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    slug,
    name,
    theme,
    tagline,
    coverUrl,
    openedAt,
    lastBookedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recent_venues';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecentVenueRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('theme')) {
      context.handle(
        _themeMeta,
        theme.isAcceptableOrUnknown(data['theme']!, _themeMeta),
      );
    }
    if (data.containsKey('tagline')) {
      context.handle(
        _taglineMeta,
        tagline.isAcceptableOrUnknown(data['tagline']!, _taglineMeta),
      );
    }
    if (data.containsKey('cover_url')) {
      context.handle(
        _coverUrlMeta,
        coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta),
      );
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_openedAtMeta);
    }
    if (data.containsKey('last_booked_at')) {
      context.handle(
        _lastBookedAtMeta,
        lastBookedAt.isAcceptableOrUnknown(
          data['last_booked_at']!,
          _lastBookedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slug};
  @override
  RecentVenueRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentVenueRow(
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      theme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme'],
      )!,
      tagline: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tagline'],
      ),
      coverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_url'],
      ),
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      )!,
      lastBookedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_booked_at'],
      ),
    );
  }

  @override
  $RecentVenuesTable createAlias(String alias) {
    return $RecentVenuesTable(attachedDatabase, alias);
  }
}

class RecentVenueRow extends DataClass implements Insertable<RecentVenueRow> {
  final String slug;
  final String name;
  final String theme;
  final String? tagline;
  final String? coverUrl;
  final DateTime openedAt;

  /// Set when the customer has actually booked here, so the card can say so.
  final DateTime? lastBookedAt;
  const RecentVenueRow({
    required this.slug,
    required this.name,
    required this.theme,
    this.tagline,
    this.coverUrl,
    required this.openedAt,
    this.lastBookedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    map['theme'] = Variable<String>(theme);
    if (!nullToAbsent || tagline != null) {
      map['tagline'] = Variable<String>(tagline);
    }
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    map['opened_at'] = Variable<DateTime>(openedAt);
    if (!nullToAbsent || lastBookedAt != null) {
      map['last_booked_at'] = Variable<DateTime>(lastBookedAt);
    }
    return map;
  }

  RecentVenuesCompanion toCompanion(bool nullToAbsent) {
    return RecentVenuesCompanion(
      slug: Value(slug),
      name: Value(name),
      theme: Value(theme),
      tagline: tagline == null && nullToAbsent
          ? const Value.absent()
          : Value(tagline),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
      openedAt: Value(openedAt),
      lastBookedAt: lastBookedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBookedAt),
    );
  }

  factory RecentVenueRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentVenueRow(
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
      theme: serializer.fromJson<String>(json['theme']),
      tagline: serializer.fromJson<String?>(json['tagline']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
      lastBookedAt: serializer.fromJson<DateTime?>(json['lastBookedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
      'theme': serializer.toJson<String>(theme),
      'tagline': serializer.toJson<String?>(tagline),
      'coverUrl': serializer.toJson<String?>(coverUrl),
      'openedAt': serializer.toJson<DateTime>(openedAt),
      'lastBookedAt': serializer.toJson<DateTime?>(lastBookedAt),
    };
  }

  RecentVenueRow copyWith({
    String? slug,
    String? name,
    String? theme,
    Value<String?> tagline = const Value.absent(),
    Value<String?> coverUrl = const Value.absent(),
    DateTime? openedAt,
    Value<DateTime?> lastBookedAt = const Value.absent(),
  }) => RecentVenueRow(
    slug: slug ?? this.slug,
    name: name ?? this.name,
    theme: theme ?? this.theme,
    tagline: tagline.present ? tagline.value : this.tagline,
    coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
    openedAt: openedAt ?? this.openedAt,
    lastBookedAt: lastBookedAt.present ? lastBookedAt.value : this.lastBookedAt,
  );
  RecentVenueRow copyWithCompanion(RecentVenuesCompanion data) {
    return RecentVenueRow(
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
      theme: data.theme.present ? data.theme.value : this.theme,
      tagline: data.tagline.present ? data.tagline.value : this.tagline,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      lastBookedAt: data.lastBookedAt.present
          ? data.lastBookedAt.value
          : this.lastBookedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentVenueRow(')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('theme: $theme, ')
          ..write('tagline: $tagline, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('openedAt: $openedAt, ')
          ..write('lastBookedAt: $lastBookedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(slug, name, theme, tagline, coverUrl, openedAt, lastBookedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentVenueRow &&
          other.slug == this.slug &&
          other.name == this.name &&
          other.theme == this.theme &&
          other.tagline == this.tagline &&
          other.coverUrl == this.coverUrl &&
          other.openedAt == this.openedAt &&
          other.lastBookedAt == this.lastBookedAt);
}

class RecentVenuesCompanion extends UpdateCompanion<RecentVenueRow> {
  final Value<String> slug;
  final Value<String> name;
  final Value<String> theme;
  final Value<String?> tagline;
  final Value<String?> coverUrl;
  final Value<DateTime> openedAt;
  final Value<DateTime?> lastBookedAt;
  final Value<int> rowid;
  const RecentVenuesCompanion({
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
    this.theme = const Value.absent(),
    this.tagline = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.lastBookedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecentVenuesCompanion.insert({
    required String slug,
    required String name,
    this.theme = const Value.absent(),
    this.tagline = const Value.absent(),
    this.coverUrl = const Value.absent(),
    required DateTime openedAt,
    this.lastBookedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : slug = Value(slug),
       name = Value(name),
       openedAt = Value(openedAt);
  static Insertable<RecentVenueRow> custom({
    Expression<String>? slug,
    Expression<String>? name,
    Expression<String>? theme,
    Expression<String>? tagline,
    Expression<String>? coverUrl,
    Expression<DateTime>? openedAt,
    Expression<DateTime>? lastBookedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
      if (theme != null) 'theme': theme,
      if (tagline != null) 'tagline': tagline,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (openedAt != null) 'opened_at': openedAt,
      if (lastBookedAt != null) 'last_booked_at': lastBookedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecentVenuesCompanion copyWith({
    Value<String>? slug,
    Value<String>? name,
    Value<String>? theme,
    Value<String?>? tagline,
    Value<String?>? coverUrl,
    Value<DateTime>? openedAt,
    Value<DateTime?>? lastBookedAt,
    Value<int>? rowid,
  }) {
    return RecentVenuesCompanion(
      slug: slug ?? this.slug,
      name: name ?? this.name,
      theme: theme ?? this.theme,
      tagline: tagline ?? this.tagline,
      coverUrl: coverUrl ?? this.coverUrl,
      openedAt: openedAt ?? this.openedAt,
      lastBookedAt: lastBookedAt ?? this.lastBookedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    if (tagline.present) {
      map['tagline'] = Variable<String>(tagline.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (lastBookedAt.present) {
      map['last_booked_at'] = Variable<DateTime>(lastBookedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentVenuesCompanion(')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('theme: $theme, ')
          ..write('tagline: $tagline, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('openedAt: $openedAt, ')
          ..write('lastBookedAt: $lastBookedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VenueCacheTable extends VenueCache
    with TableInfo<$VenueCacheTable, VenueCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VenueCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _venueSlugMeta = const VerificationMeta(
    'venueSlug',
  );
  @override
  late final GeneratedColumn<String> venueSlug = GeneratedColumn<String>(
    'venue_slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [venueSlug, key, payload, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'venue_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<VenueCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('venue_slug')) {
      context.handle(
        _venueSlugMeta,
        venueSlug.isAcceptableOrUnknown(data['venue_slug']!, _venueSlugMeta),
      );
    } else if (isInserting) {
      context.missing(_venueSlugMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {venueSlug, key};
  @override
  VenueCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VenueCacheRow(
      venueSlug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_slug'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $VenueCacheTable createAlias(String alias) {
    return $VenueCacheTable(attachedDatabase, alias);
  }
}

class VenueCacheRow extends DataClass implements Insertable<VenueCacheRow> {
  final String venueSlug;

  /// Which screen: "today", later "calendar:<date>", "customers".
  final String key;

  /// The response as JSON, exactly as the screen would have rendered it.
  final String payload;
  final DateTime fetchedAt;
  const VenueCacheRow({
    required this.venueSlug,
    required this.key,
    required this.payload,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['venue_slug'] = Variable<String>(venueSlug);
    map['key'] = Variable<String>(key);
    map['payload'] = Variable<String>(payload);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  VenueCacheCompanion toCompanion(bool nullToAbsent) {
    return VenueCacheCompanion(
      venueSlug: Value(venueSlug),
      key: Value(key),
      payload: Value(payload),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory VenueCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VenueCacheRow(
      venueSlug: serializer.fromJson<String>(json['venueSlug']),
      key: serializer.fromJson<String>(json['key']),
      payload: serializer.fromJson<String>(json['payload']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'venueSlug': serializer.toJson<String>(venueSlug),
      'key': serializer.toJson<String>(key),
      'payload': serializer.toJson<String>(payload),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  VenueCacheRow copyWith({
    String? venueSlug,
    String? key,
    String? payload,
    DateTime? fetchedAt,
  }) => VenueCacheRow(
    venueSlug: venueSlug ?? this.venueSlug,
    key: key ?? this.key,
    payload: payload ?? this.payload,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  VenueCacheRow copyWithCompanion(VenueCacheCompanion data) {
    return VenueCacheRow(
      venueSlug: data.venueSlug.present ? data.venueSlug.value : this.venueSlug,
      key: data.key.present ? data.key.value : this.key,
      payload: data.payload.present ? data.payload.value : this.payload,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VenueCacheRow(')
          ..write('venueSlug: $venueSlug, ')
          ..write('key: $key, ')
          ..write('payload: $payload, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(venueSlug, key, payload, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VenueCacheRow &&
          other.venueSlug == this.venueSlug &&
          other.key == this.key &&
          other.payload == this.payload &&
          other.fetchedAt == this.fetchedAt);
}

class VenueCacheCompanion extends UpdateCompanion<VenueCacheRow> {
  final Value<String> venueSlug;
  final Value<String> key;
  final Value<String> payload;
  final Value<DateTime> fetchedAt;
  final Value<int> rowid;
  const VenueCacheCompanion({
    this.venueSlug = const Value.absent(),
    this.key = const Value.absent(),
    this.payload = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VenueCacheCompanion.insert({
    required String venueSlug,
    required String key,
    required String payload,
    required DateTime fetchedAt,
    this.rowid = const Value.absent(),
  }) : venueSlug = Value(venueSlug),
       key = Value(key),
       payload = Value(payload),
       fetchedAt = Value(fetchedAt);
  static Insertable<VenueCacheRow> custom({
    Expression<String>? venueSlug,
    Expression<String>? key,
    Expression<String>? payload,
    Expression<DateTime>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (venueSlug != null) 'venue_slug': venueSlug,
      if (key != null) 'key': key,
      if (payload != null) 'payload': payload,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VenueCacheCompanion copyWith({
    Value<String>? venueSlug,
    Value<String>? key,
    Value<String>? payload,
    Value<DateTime>? fetchedAt,
    Value<int>? rowid,
  }) {
    return VenueCacheCompanion(
      venueSlug: venueSlug ?? this.venueSlug,
      key: key ?? this.key,
      payload: payload ?? this.payload,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (venueSlug.present) {
      map['venue_slug'] = Variable<String>(venueSlug.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VenueCacheCompanion(')
          ..write('venueSlug: $venueSlug, ')
          ..write('key: $key, ')
          ..write('payload: $payload, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WalletBookingsTable walletBookings = $WalletBookingsTable(this);
  late final $RecentVenuesTable recentVenues = $RecentVenuesTable(this);
  late final $VenueCacheTable venueCache = $VenueCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    walletBookings,
    recentVenues,
    venueCache,
  ];
}

typedef $$WalletBookingsTableCreateCompanionBuilder =
    WalletBookingsCompanion Function({
      required String venueSlug,
      required String manageToken,
      required String reference,
      required String venueName,
      Value<String> venueTheme,
      required String spaceName,
      Value<String> timezone,
      Value<String> currency,
      required DateTime startsAt,
      required DateTime endsAt,
      Value<int> amountCents,
      Value<String> status,
      required String snapshot,
      required DateTime lastSyncedAt,
      Value<int> rowid,
    });
typedef $$WalletBookingsTableUpdateCompanionBuilder =
    WalletBookingsCompanion Function({
      Value<String> venueSlug,
      Value<String> manageToken,
      Value<String> reference,
      Value<String> venueName,
      Value<String> venueTheme,
      Value<String> spaceName,
      Value<String> timezone,
      Value<String> currency,
      Value<DateTime> startsAt,
      Value<DateTime> endsAt,
      Value<int> amountCents,
      Value<String> status,
      Value<String> snapshot,
      Value<DateTime> lastSyncedAt,
      Value<int> rowid,
    });

class $$WalletBookingsTableFilterComposer
    extends Composer<_$AppDatabase, $WalletBookingsTable> {
  $$WalletBookingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get venueSlug => $composableBuilder(
    column: $table.venueSlug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manageToken => $composableBuilder(
    column: $table.manageToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueName => $composableBuilder(
    column: $table.venueName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueTheme => $composableBuilder(
    column: $table.venueTheme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spaceName => $composableBuilder(
    column: $table.spaceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snapshot => $composableBuilder(
    column: $table.snapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WalletBookingsTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletBookingsTable> {
  $$WalletBookingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get venueSlug => $composableBuilder(
    column: $table.venueSlug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manageToken => $composableBuilder(
    column: $table.manageToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueName => $composableBuilder(
    column: $table.venueName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueTheme => $composableBuilder(
    column: $table.venueTheme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spaceName => $composableBuilder(
    column: $table.spaceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snapshot => $composableBuilder(
    column: $table.snapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalletBookingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletBookingsTable> {
  $$WalletBookingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get venueSlug =>
      $composableBuilder(column: $table.venueSlug, builder: (column) => column);

  GeneratedColumn<String> get manageToken => $composableBuilder(
    column: $table.manageToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get venueName =>
      $composableBuilder(column: $table.venueName, builder: (column) => column);

  GeneratedColumn<String> get venueTheme => $composableBuilder(
    column: $table.venueTheme,
    builder: (column) => column,
  );

  GeneratedColumn<String> get spaceName =>
      $composableBuilder(column: $table.spaceName, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<DateTime> get startsAt =>
      $composableBuilder(column: $table.startsAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endsAt =>
      $composableBuilder(column: $table.endsAt, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get snapshot =>
      $composableBuilder(column: $table.snapshot, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$WalletBookingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalletBookingsTable,
          WalletRow,
          $$WalletBookingsTableFilterComposer,
          $$WalletBookingsTableOrderingComposer,
          $$WalletBookingsTableAnnotationComposer,
          $$WalletBookingsTableCreateCompanionBuilder,
          $$WalletBookingsTableUpdateCompanionBuilder,
          (
            WalletRow,
            BaseReferences<_$AppDatabase, $WalletBookingsTable, WalletRow>,
          ),
          WalletRow,
          PrefetchHooks Function()
        > {
  $$WalletBookingsTableTableManager(
    _$AppDatabase db,
    $WalletBookingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletBookingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletBookingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletBookingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> venueSlug = const Value.absent(),
                Value<String> manageToken = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<String> venueName = const Value.absent(),
                Value<String> venueTheme = const Value.absent(),
                Value<String> spaceName = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> startsAt = const Value.absent(),
                Value<DateTime> endsAt = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> snapshot = const Value.absent(),
                Value<DateTime> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalletBookingsCompanion(
                venueSlug: venueSlug,
                manageToken: manageToken,
                reference: reference,
                venueName: venueName,
                venueTheme: venueTheme,
                spaceName: spaceName,
                timezone: timezone,
                currency: currency,
                startsAt: startsAt,
                endsAt: endsAt,
                amountCents: amountCents,
                status: status,
                snapshot: snapshot,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String venueSlug,
                required String manageToken,
                required String reference,
                required String venueName,
                Value<String> venueTheme = const Value.absent(),
                required String spaceName,
                Value<String> timezone = const Value.absent(),
                Value<String> currency = const Value.absent(),
                required DateTime startsAt,
                required DateTime endsAt,
                Value<int> amountCents = const Value.absent(),
                Value<String> status = const Value.absent(),
                required String snapshot,
                required DateTime lastSyncedAt,
                Value<int> rowid = const Value.absent(),
              }) => WalletBookingsCompanion.insert(
                venueSlug: venueSlug,
                manageToken: manageToken,
                reference: reference,
                venueName: venueName,
                venueTheme: venueTheme,
                spaceName: spaceName,
                timezone: timezone,
                currency: currency,
                startsAt: startsAt,
                endsAt: endsAt,
                amountCents: amountCents,
                status: status,
                snapshot: snapshot,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WalletBookingsTable, WalletRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WalletBookingsTable,
                    WalletRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WalletBookingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalletBookingsTable,
      WalletRow,
      $$WalletBookingsTableFilterComposer,
      $$WalletBookingsTableOrderingComposer,
      $$WalletBookingsTableAnnotationComposer,
      $$WalletBookingsTableCreateCompanionBuilder,
      $$WalletBookingsTableUpdateCompanionBuilder,
      (
        WalletRow,
        BaseReferences<_$AppDatabase, $WalletBookingsTable, WalletRow>,
      ),
      WalletRow,
      PrefetchHooks Function()
    >;
typedef $$RecentVenuesTableCreateCompanionBuilder =
    RecentVenuesCompanion Function({
      required String slug,
      required String name,
      Value<String> theme,
      Value<String?> tagline,
      Value<String?> coverUrl,
      required DateTime openedAt,
      Value<DateTime?> lastBookedAt,
      Value<int> rowid,
    });
typedef $$RecentVenuesTableUpdateCompanionBuilder =
    RecentVenuesCompanion Function({
      Value<String> slug,
      Value<String> name,
      Value<String> theme,
      Value<String?> tagline,
      Value<String?> coverUrl,
      Value<DateTime> openedAt,
      Value<DateTime?> lastBookedAt,
      Value<int> rowid,
    });

class $$RecentVenuesTableFilterComposer
    extends Composer<_$AppDatabase, $RecentVenuesTable> {
  $$RecentVenuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagline => $composableBuilder(
    column: $table.tagline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBookedAt => $composableBuilder(
    column: $table.lastBookedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecentVenuesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecentVenuesTable> {
  $$RecentVenuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagline => $composableBuilder(
    column: $table.tagline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBookedAt => $composableBuilder(
    column: $table.lastBookedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecentVenuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecentVenuesTable> {
  $$RecentVenuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumn<String> get tagline =>
      $composableBuilder(column: $table.tagline, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastBookedAt => $composableBuilder(
    column: $table.lastBookedAt,
    builder: (column) => column,
  );
}

class $$RecentVenuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecentVenuesTable,
          RecentVenueRow,
          $$RecentVenuesTableFilterComposer,
          $$RecentVenuesTableOrderingComposer,
          $$RecentVenuesTableAnnotationComposer,
          $$RecentVenuesTableCreateCompanionBuilder,
          $$RecentVenuesTableUpdateCompanionBuilder,
          (
            RecentVenueRow,
            BaseReferences<_$AppDatabase, $RecentVenuesTable, RecentVenueRow>,
          ),
          RecentVenueRow,
          PrefetchHooks Function()
        > {
  $$RecentVenuesTableTableManager(_$AppDatabase db, $RecentVenuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentVenuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentVenuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentVenuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> theme = const Value.absent(),
                Value<String?> tagline = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                Value<DateTime> openedAt = const Value.absent(),
                Value<DateTime?> lastBookedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecentVenuesCompanion(
                slug: slug,
                name: name,
                theme: theme,
                tagline: tagline,
                coverUrl: coverUrl,
                openedAt: openedAt,
                lastBookedAt: lastBookedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String slug,
                required String name,
                Value<String> theme = const Value.absent(),
                Value<String?> tagline = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                required DateTime openedAt,
                Value<DateTime?> lastBookedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecentVenuesCompanion.insert(
                slug: slug,
                name: name,
                theme: theme,
                tagline: tagline,
                coverUrl: coverUrl,
                openedAt: openedAt,
                lastBookedAt: lastBookedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecentVenuesTable, RecentVenueRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $RecentVenuesTable,
                    RecentVenueRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecentVenuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecentVenuesTable,
      RecentVenueRow,
      $$RecentVenuesTableFilterComposer,
      $$RecentVenuesTableOrderingComposer,
      $$RecentVenuesTableAnnotationComposer,
      $$RecentVenuesTableCreateCompanionBuilder,
      $$RecentVenuesTableUpdateCompanionBuilder,
      (
        RecentVenueRow,
        BaseReferences<_$AppDatabase, $RecentVenuesTable, RecentVenueRow>,
      ),
      RecentVenueRow,
      PrefetchHooks Function()
    >;
typedef $$VenueCacheTableCreateCompanionBuilder = VenueCacheCompanion Function({
  required String venueSlug,
  required String key,
  required String payload,
  required DateTime fetchedAt,
  Value<int> rowid,
});
typedef $$VenueCacheTableUpdateCompanionBuilder = VenueCacheCompanion Function({
  Value<String> venueSlug,
  Value<String> key,
  Value<String> payload,
  Value<DateTime> fetchedAt,
  Value<int> rowid,
});

class $$VenueCacheTableFilterComposer
    extends Composer<_$AppDatabase, $VenueCacheTable> {
  $$VenueCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get venueSlug => $composableBuilder(
    column: $table.venueSlug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VenueCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $VenueCacheTable> {
  $$VenueCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get venueSlug => $composableBuilder(
    column: $table.venueSlug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VenueCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $VenueCacheTable> {
  $$VenueCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get venueSlug =>
      $composableBuilder(column: $table.venueSlug, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$VenueCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VenueCacheTable,
          VenueCacheRow,
          $$VenueCacheTableFilterComposer,
          $$VenueCacheTableOrderingComposer,
          $$VenueCacheTableAnnotationComposer,
          $$VenueCacheTableCreateCompanionBuilder,
          $$VenueCacheTableUpdateCompanionBuilder,
          (
            VenueCacheRow,
            BaseReferences<_$AppDatabase, $VenueCacheTable, VenueCacheRow>,
          ),
          VenueCacheRow,
          PrefetchHooks Function()
        > {
  $$VenueCacheTableTableManager(_$AppDatabase db, $VenueCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VenueCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VenueCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VenueCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> venueSlug = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VenueCacheCompanion(
                venueSlug: venueSlug,
                key: key,
                payload: payload,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String venueSlug,
                required String key,
                required String payload,
                required DateTime fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => VenueCacheCompanion.insert(
                venueSlug: venueSlug,
                key: key,
                payload: payload,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VenueCacheTable, VenueCacheRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $VenueCacheTable,
                    VenueCacheRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VenueCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VenueCacheTable,
      VenueCacheRow,
      $$VenueCacheTableFilterComposer,
      $$VenueCacheTableOrderingComposer,
      $$VenueCacheTableAnnotationComposer,
      $$VenueCacheTableCreateCompanionBuilder,
      $$VenueCacheTableUpdateCompanionBuilder,
      (
        VenueCacheRow,
        BaseReferences<_$AppDatabase, $VenueCacheTable, VenueCacheRow>,
      ),
      VenueCacheRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WalletBookingsTableTableManager get walletBookings =>
      $$WalletBookingsTableTableManager(_db, _db.walletBookings);
  $$RecentVenuesTableTableManager get recentVenues =>
      $$RecentVenuesTableTableManager(_db, _db.recentVenues);
  $$VenueCacheTableTableManager get venueCache =>
      $$VenueCacheTableTableManager(_db, _db.venueCache);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'365ef3f215d780c29a21b6328f0b547a8363c6a6';
