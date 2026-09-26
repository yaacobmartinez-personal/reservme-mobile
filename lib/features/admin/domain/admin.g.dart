// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TenantSummary _$TenantSummaryFromJson(Map<String, dynamic> json) =>
    _TenantSummary(
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      timezone: json['timezone'] as String? ?? 'Asia/Manila',
      currency: json['currency'] as String? ?? 'PHP',
      createdAt: DateTime.parse(json['createdAt'] as String),
      suspendedAt: json['suspendedAt'] == null
          ? null
          : DateTime.parse(json['suspendedAt'] as String),
      suspendedReason: json['suspendedReason'] as String?,
      billingSuspended: json['billingSuspended'] as bool? ?? false,
      activeSpaces: (json['activeSpaces'] as num?)?.toInt() ?? 0,
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      upcomingBookings: (json['upcomingBookings'] as num?)?.toInt() ?? 0,
      bookingsLast30: (json['bookingsLast30'] as num?)?.toInt() ?? 0,
      revenueLast30Cents: (json['revenueLast30Cents'] as num?)?.toInt() ?? 0,
      subscription: TenantSubscription.fromJson(
        json['subscription'] as Map<String, dynamic>,
      ),
      band: TenantBand.fromJson(json['band'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TenantSummaryToJson(_TenantSummary instance) =>
    <String, dynamic>{
      'orgId': instance.orgId,
      'name': instance.name,
      'slug': instance.slug,
      'timezone': instance.timezone,
      'currency': instance.currency,
      'createdAt': instance.createdAt.toIso8601String(),
      'suspendedAt': instance.suspendedAt?.toIso8601String(),
      'suspendedReason': instance.suspendedReason,
      'billingSuspended': instance.billingSuspended,
      'activeSpaces': instance.activeSpaces,
      'memberCount': instance.memberCount,
      'upcomingBookings': instance.upcomingBookings,
      'bookingsLast30': instance.bookingsLast30,
      'revenueLast30Cents': instance.revenueLast30Cents,
      'subscription': instance.subscription,
      'band': instance.band,
    };

_TenantSubscription _$TenantSubscriptionFromJson(Map<String, dynamic> json) =>
    _TenantSubscription(
      status:
          $enumDecodeNullable(_$BillingStatusEnumMap, json['status']) ??
          BillingStatus.trialing,
      trialDaysLeft: (json['trialDaysLeft'] as num?)?.toInt() ?? 0,
      dueNow: json['dueNow'] as bool? ?? false,
    );

Map<String, dynamic> _$TenantSubscriptionToJson(_TenantSubscription instance) =>
    <String, dynamic>{
      'status': _$BillingStatusEnumMap[instance.status]!,
      'trialDaysLeft': instance.trialDaysLeft,
      'dueNow': instance.dueNow,
    };

const _$BillingStatusEnumMap = {
  BillingStatus.trialing: 'trialing',
  BillingStatus.active: 'active',
  BillingStatus.pastDue: 'past_due',
  BillingStatus.cancelled: 'cancelled',
  BillingStatus.comped: 'comped',
};

_TenantBand _$TenantBandFromJson(Map<String, dynamic> json) => _TenantBand(
  name: json['name'] as String,
  priceCents: (json['priceCents'] as num?)?.toInt(),
);

Map<String, dynamic> _$TenantBandToJson(_TenantBand instance) =>
    <String, dynamic>{'name': instance.name, 'priceCents': instance.priceCents};

_AdminOverview _$AdminOverviewFromJson(Map<String, dynamic> json) =>
    _AdminOverview(
      totals: AdminTotals.fromJson(json['totals'] as Map<String, dynamic>),
      radar: AdminRadar.fromJson(json['radar'] as Map<String, dynamic>),
      pendingPayments: (json['pendingPayments'] as num?)?.toInt() ?? 0,
      growth:
          (json['growth'] as List<dynamic>?)
              ?.map((e) => GrowthPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GrowthPoint>[],
    );

Map<String, dynamic> _$AdminOverviewToJson(_AdminOverview instance) =>
    <String, dynamic>{
      'totals': instance.totals,
      'radar': instance.radar,
      'pendingPayments': instance.pendingPayments,
      'growth': instance.growth,
    };

_AdminTotals _$AdminTotalsFromJson(Map<String, dynamic> json) => _AdminTotals(
  tenants: (json['tenants'] as num?)?.toInt() ?? 0,
  suspended: (json['suspended'] as num?)?.toInt() ?? 0,
  activeSpaces: (json['activeSpaces'] as num?)?.toInt() ?? 0,
  bookingsLast30: (json['bookingsLast30'] as num?)?.toInt() ?? 0,
  customers: (json['customers'] as num?)?.toInt() ?? 0,
  runRateCents: (json['runRateCents'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AdminTotalsToJson(_AdminTotals instance) =>
    <String, dynamic>{
      'tenants': instance.tenants,
      'suspended': instance.suspended,
      'activeSpaces': instance.activeSpaces,
      'bookingsLast30': instance.bookingsLast30,
      'customers': instance.customers,
      'runRateCents': instance.runRateCents,
    };

_AdminRadar _$AdminRadarFromJson(Map<String, dynamic> json) => _AdminRadar(
  endingSoon:
      (json['endingSoon'] as List<dynamic>?)
          ?.map((e) => TenantSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TenantSummary>[],
  inGrace:
      (json['inGrace'] as List<dynamic>?)
          ?.map((e) => TenantSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TenantSummary>[],
  suspended:
      (json['suspended'] as List<dynamic>?)
          ?.map((e) => TenantSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TenantSummary>[],
);

Map<String, dynamic> _$AdminRadarToJson(_AdminRadar instance) =>
    <String, dynamic>{
      'endingSoon': instance.endingSoon,
      'inGrace': instance.inGrace,
      'suspended': instance.suspended,
    };

_GrowthPoint _$GrowthPointFromJson(Map<String, dynamic> json) => _GrowthPoint(
  month: json['month'] as String,
  signups: (json['signups'] as num?)?.toInt() ?? 0,
  cancellations: (json['cancellations'] as num?)?.toInt() ?? 0,
  cumulative: (json['cumulative'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$GrowthPointToJson(_GrowthPoint instance) =>
    <String, dynamic>{
      'month': instance.month,
      'signups': instance.signups,
      'cancellations': instance.cancellations,
      'cumulative': instance.cumulative,
    };

_TenantDetail _$TenantDetailFromJson(Map<String, dynamic> json) =>
    _TenantDetail(
      tenant: TenantDetailSummary.fromJson(
        json['tenant'] as Map<String, dynamic>,
      ),
      spaces:
          (json['spaces'] as List<dynamic>?)
              ?.map((e) => TenantSpace.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TenantSpace>[],
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => TenantMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TenantMember>[],
      recentBookings:
          (json['recentBookings'] as List<dynamic>?)
              ?.map((e) => TenantBooking.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TenantBooking>[],
      payments:
          (json['payments'] as List<dynamic>?)
              ?.map((e) => AdminPayment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AdminPayment>[],
    );

Map<String, dynamic> _$TenantDetailToJson(_TenantDetail instance) =>
    <String, dynamic>{
      'tenant': instance.tenant,
      'spaces': instance.spaces,
      'members': instance.members,
      'recentBookings': instance.recentBookings,
      'payments': instance.payments,
    };

_TenantDetailSummary _$TenantDetailSummaryFromJson(Map<String, dynamic> json) =>
    _TenantDetailSummary(
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      timezone: json['timezone'] as String? ?? 'Asia/Manila',
      currency: json['currency'] as String? ?? 'PHP',
      createdAt: DateTime.parse(json['createdAt'] as String),
      suspendedAt: json['suspendedAt'] == null
          ? null
          : DateTime.parse(json['suspendedAt'] as String),
      suspendedReason: json['suspendedReason'] as String?,
      billingSuspended: json['billingSuspended'] as bool? ?? false,
      activeSpaces: (json['activeSpaces'] as num?)?.toInt() ?? 0,
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      upcomingBookings: (json['upcomingBookings'] as num?)?.toInt() ?? 0,
      bookingsLast30: (json['bookingsLast30'] as num?)?.toInt() ?? 0,
      revenueLast30Cents: (json['revenueLast30Cents'] as num?)?.toInt() ?? 0,
      subscription: TenantSubscription.fromJson(
        json['subscription'] as Map<String, dynamic>,
      ),
      band: TenantBand.fromJson(json['band'] as Map<String, dynamic>),
      paidUntil: json['paidUntil'] == null
          ? null
          : DateTime.parse(json['paidUntil'] as String),
      trialEndsAt: json['trialEndsAt'] == null
          ? null
          : DateTime.parse(json['trialEndsAt'] as String),
    );

Map<String, dynamic> _$TenantDetailSummaryToJson(
  _TenantDetailSummary instance,
) => <String, dynamic>{
  'orgId': instance.orgId,
  'name': instance.name,
  'slug': instance.slug,
  'timezone': instance.timezone,
  'currency': instance.currency,
  'createdAt': instance.createdAt.toIso8601String(),
  'suspendedAt': instance.suspendedAt?.toIso8601String(),
  'suspendedReason': instance.suspendedReason,
  'billingSuspended': instance.billingSuspended,
  'activeSpaces': instance.activeSpaces,
  'memberCount': instance.memberCount,
  'upcomingBookings': instance.upcomingBookings,
  'bookingsLast30': instance.bookingsLast30,
  'revenueLast30Cents': instance.revenueLast30Cents,
  'subscription': instance.subscription,
  'band': instance.band,
  'paidUntil': instance.paidUntil?.toIso8601String(),
  'trialEndsAt': instance.trialEndsAt?.toIso8601String(),
};

_TenantSpace _$TenantSpaceFromJson(Map<String, dynamic> json) => _TenantSpace(
  id: json['id'] as String,
  name: json['name'] as String,
  kind: json['kind'] as String? ?? 'other',
  priceCents: (json['priceCents'] as num?)?.toInt() ?? 0,
  active: json['active'] as bool? ?? true,
);

Map<String, dynamic> _$TenantSpaceToJson(_TenantSpace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kind': instance.kind,
      'priceCents': instance.priceCents,
      'active': instance.active,
    };

_TenantMember _$TenantMemberFromJson(Map<String, dynamic> json) =>
    _TenantMember(
      name: json['name'] as String?,
      email: json['email'] as String,
      role: json['role'] as String,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$TenantMemberToJson(_TenantMember instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'joinedAt': instance.joinedAt.toIso8601String(),
    };

_TenantBooking _$TenantBookingFromJson(Map<String, dynamic> json) =>
    _TenantBooking(
      reference: json['reference'] as String,
      status: json['status'] as String,
      spaceName: json['spaceName'] as String,
      customerName: json['customerName'] as String?,
      label: json['label'] as String,
      amountCents: (json['amountCents'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TenantBookingToJson(_TenantBooking instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'status': instance.status,
      'spaceName': instance.spaceName,
      'customerName': instance.customerName,
      'label': instance.label,
      'amountCents': instance.amountCents,
    };

_AdminPayment _$AdminPaymentFromJson(Map<String, dynamic> json) =>
    _AdminPayment(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      venueName: json['venueName'] as String?,
      amountCents: (json['amountCents'] as num?)?.toInt() ?? 0,
      reference: json['reference'] as String,
      paidAt: DateTime.parse(json['paidAt'] as String),
      status: json['status'] as String? ?? 'submitted',
      note: json['note'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AdminPaymentToJson(_AdminPayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orgId': instance.orgId,
      'venueName': instance.venueName,
      'amountCents': instance.amountCents,
      'reference': instance.reference,
      'paidAt': instance.paidAt.toIso8601String(),
      'status': instance.status,
      'note': instance.note,
      'receiptUrl': instance.receiptUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_InstapaySettings _$InstapaySettingsFromJson(Map<String, dynamic> json) =>
    _InstapaySettings(
      qrUrl: json['qrUrl'] as String?,
      payee: json['payee'] as String?,
      account: json['account'] as String?,
      configured: json['configured'] as bool? ?? false,
    );

Map<String, dynamic> _$InstapaySettingsToJson(_InstapaySettings instance) =>
    <String, dynamic>{
      'qrUrl': instance.qrUrl,
      'payee': instance.payee,
      'account': instance.account,
      'configured': instance.configured,
    };

_AuditEntry _$AuditEntryFromJson(Map<String, dynamic> json) => _AuditEntry(
  id: json['id'] as String,
  actorName: json['actorName'] as String,
  actorEmail: json['actorEmail'] as String,
  action: json['action'] as String,
  organizationName: json['organizationName'] as String?,
  target: json['target'] as String?,
  impersonating: json['impersonating'] as bool? ?? false,
  detail: json['detail'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AuditEntryToJson(_AuditEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actorName': instance.actorName,
      'actorEmail': instance.actorEmail,
      'action': instance.action,
      'organizationName': instance.organizationName,
      'target': instance.target,
      'impersonating': instance.impersonating,
      'detail': instance.detail,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_PlatformAdminEntry _$PlatformAdminEntryFromJson(Map<String, dynamic> json) =>
    _PlatformAdminEntry(
      userId: json['userId'] as String,
      name: json['name'] as String?,
      email: json['email'] as String,
      grantedAt: DateTime.parse(json['grantedAt'] as String),
      isSelf: json['isSelf'] as bool? ?? false,
    );

Map<String, dynamic> _$PlatformAdminEntryToJson(_PlatformAdminEntry instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'grantedAt': instance.grantedAt.toIso8601String(),
      'isSelf': instance.isSelf,
    };
