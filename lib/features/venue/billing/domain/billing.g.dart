// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Billing _$BillingFromJson(Map<String, dynamic> json) => _Billing(
  status:
      $enumDecodeNullable(_$BillingStatusEnumMap, json['status']) ??
      BillingStatus.trialing,
  band: PlanBand.fromJson(json['band'] as Map<String, dynamic>),
  activeSpaces: (json['activeSpaces'] as num?)?.toInt() ?? 0,
  trialEndsAt: DateTime.parse(json['trialEndsAt'] as String),
  paidUntil: json['paidUntil'] == null
      ? null
      : DateTime.parse(json['paidUntil'] as String),
  daysLeftInTrial: (json['daysLeftInTrial'] as num?)?.toInt(),
  dueNow: json['dueNow'] as bool? ?? false,
  suspended: json['suspended'] as bool? ?? false,
  pendingPayment: json['pendingPayment'] == null
      ? null
      : BillingPayment.fromJson(json['pendingPayment'] as Map<String, dynamic>),
  history:
      (json['history'] as List<dynamic>?)
          ?.map((e) => BillingPayment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <BillingPayment>[],
  instapay: json['instapay'] == null
      ? null
      : InstapayDetails.fromJson(json['instapay'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BillingToJson(_Billing instance) => <String, dynamic>{
  'status': _$BillingStatusEnumMap[instance.status]!,
  'band': instance.band,
  'activeSpaces': instance.activeSpaces,
  'trialEndsAt': instance.trialEndsAt.toIso8601String(),
  'paidUntil': instance.paidUntil?.toIso8601String(),
  'daysLeftInTrial': instance.daysLeftInTrial,
  'dueNow': instance.dueNow,
  'suspended': instance.suspended,
  'pendingPayment': instance.pendingPayment,
  'history': instance.history,
  'instapay': instance.instapay,
};

const _$BillingStatusEnumMap = {
  BillingStatus.trialing: 'trialing',
  BillingStatus.active: 'active',
  BillingStatus.pastDue: 'past_due',
  BillingStatus.cancelled: 'cancelled',
  BillingStatus.comped: 'comped',
};

_PlanBand _$PlanBandFromJson(Map<String, dynamic> json) => _PlanBand(
  id: json['id'] as String,
  name: json['name'] as String,
  minSpaces: (json['minSpaces'] as num).toInt(),
  maxSpaces: (json['maxSpaces'] as num?)?.toInt(),
  pricePesos: (json['pricePesos'] as num?)?.toInt(),
  blurb: json['blurb'] as String,
);

Map<String, dynamic> _$PlanBandToJson(_PlanBand instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'minSpaces': instance.minSpaces,
  'maxSpaces': instance.maxSpaces,
  'pricePesos': instance.pricePesos,
  'blurb': instance.blurb,
};

_BillingPayment _$BillingPaymentFromJson(Map<String, dynamic> json) =>
    _BillingPayment(
      id: json['id'] as String,
      amountCents: (json['amountCents'] as num?)?.toInt() ?? 0,
      reference: json['reference'] as String,
      paidAt: json['paidAt'] as String,
      status:
          $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']) ??
          PaymentStatus.submitted,
      note: json['note'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BillingPaymentToJson(_BillingPayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amountCents': instance.amountCents,
      'reference': instance.reference,
      'paidAt': instance.paidAt,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'note': instance.note,
      'receiptUrl': instance.receiptUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.submitted: 'submitted',
  PaymentStatus.approved: 'approved',
  PaymentStatus.rejected: 'rejected',
};

_InstapayDetails _$InstapayDetailsFromJson(Map<String, dynamic> json) =>
    _InstapayDetails(
      qrUrl: json['qrUrl'] as String?,
      payee: json['payee'] as String?,
      account: json['account'] as String?,
    );

Map<String, dynamic> _$InstapayDetailsToJson(_InstapayDetails instance) =>
    <String, dynamic>{
      'qrUrl': instance.qrUrl,
      'payee': instance.payee,
      'account': instance.account,
    };
