// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MembershipPlan _$MembershipPlanFromJson(Map<String, dynamic> json) =>
    _MembershipPlan(
      id: json['id'] as String,
      name: json['name'] as String,
      kind:
          $enumDecodeNullable(_$PlanKindEnumMap, json['kind']) ?? PlanKind.pass,
      priceCents: (json['priceCents'] as num?)?.toInt() ?? 0,
      credits: (json['credits'] as num?)?.toInt(),
      period: json['period'] as String? ?? 'one_time',
      discountPct: (json['discountPct'] as num?)?.toInt(),
      validDays: (json['validDays'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      holders: (json['holders'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MembershipPlanToJson(_MembershipPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kind': _$PlanKindEnumMap[instance.kind]!,
      'priceCents': instance.priceCents,
      'credits': instance.credits,
      'period': instance.period,
      'discountPct': instance.discountPct,
      'validDays': instance.validDays,
      'active': instance.active,
      'holders': instance.holders,
    };

const _$PlanKindEnumMap = {
  PlanKind.pass: 'pass',
  PlanKind.membership: 'membership',
};

_Holding _$HoldingFromJson(Map<String, dynamic> json) => _Holding(
  id: json['id'] as String,
  planId: json['planId'] as String,
  planName: json['planName'] as String,
  kind: $enumDecodeNullable(_$PlanKindEnumMap, json['kind']) ?? PlanKind.pass,
  creditsRemaining: (json['creditsRemaining'] as num?)?.toInt() ?? 0,
  discountPct: (json['discountPct'] as num?)?.toInt(),
  status: json['status'] as String? ?? 'active',
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$HoldingToJson(_Holding instance) => <String, dynamic>{
  'id': instance.id,
  'planId': instance.planId,
  'planName': instance.planName,
  'kind': _$PlanKindEnumMap[instance.kind]!,
  'creditsRemaining': instance.creditsRemaining,
  'discountPct': instance.discountPct,
  'status': instance.status,
  'expiresAt': instance.expiresAt?.toIso8601String(),
};

_PromoCode _$PromoCodeFromJson(Map<String, dynamic> json) => _PromoCode(
  id: json['id'] as String,
  code: json['code'] as String,
  kind:
      $enumDecodeNullable(_$PromoKindEnumMap, json['kind']) ??
      PromoKind.percent,
  percent: (json['percent'] as num?)?.toInt(),
  amountCents: (json['amountCents'] as num?)?.toInt(),
  maxUses: (json['maxUses'] as num?)?.toInt(),
  uses: (json['uses'] as num?)?.toInt() ?? 0,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  active: json['active'] as bool? ?? true,
);

Map<String, dynamic> _$PromoCodeToJson(_PromoCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'kind': _$PromoKindEnumMap[instance.kind]!,
      'percent': instance.percent,
      'amountCents': instance.amountCents,
      'maxUses': instance.maxUses,
      'uses': instance.uses,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'active': instance.active,
    };

const _$PromoKindEnumMap = {
  PromoKind.percent: 'percent',
  PromoKind.amount: 'amount',
};

_MarketingSettings _$MarketingSettingsFromJson(Map<String, dynamic> json) =>
    _MarketingSettings(
      reviewUrl: json['reviewUrl'] as String?,
      loyalty: json['loyalty'] == null
          ? const LoyaltyRules()
          : LoyaltyRules.fromJson(json['loyalty'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MarketingSettingsToJson(_MarketingSettings instance) =>
    <String, dynamic>{
      'reviewUrl': instance.reviewUrl,
      'loyalty': instance.loyalty,
    };

_LoyaltyRules _$LoyaltyRulesFromJson(Map<String, dynamic> json) =>
    _LoyaltyRules(
      pesosPerPoint: (json['pesosPerPoint'] as num?)?.toInt() ?? 100,
      winbackAfterDays: (json['winbackAfterDays'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$LoyaltyRulesToJson(_LoyaltyRules instance) =>
    <String, dynamic>{
      'pesosPerPoint': instance.pesosPerPoint,
      'winbackAfterDays': instance.winbackAfterDays,
    };

_Integrations _$IntegrationsFromJson(Map<String, dynamic> json) =>
    _Integrations(
      icalUrl: json['icalUrl'] as String?,
      webhookEvents:
          (json['webhookEvents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>['booking.created', 'booking.cancelled'],
      webhooks:
          (json['webhooks'] as List<dynamic>?)
              ?.map((e) => Webhook.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Webhook>[],
      apiKeys:
          (json['apiKeys'] as List<dynamic>?)
              ?.map((e) => ApiKeyInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ApiKeyInfo>[],
    );

Map<String, dynamic> _$IntegrationsToJson(_Integrations instance) =>
    <String, dynamic>{
      'icalUrl': instance.icalUrl,
      'webhookEvents': instance.webhookEvents,
      'webhooks': instance.webhooks,
      'apiKeys': instance.apiKeys,
    };

_Webhook _$WebhookFromJson(Map<String, dynamic> json) => _Webhook(
  id: json['id'] as String,
  url: json['url'] as String,
  secret: json['secret'] as String,
  events:
      (json['events'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  active: json['active'] as bool? ?? true,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$WebhookToJson(_Webhook instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'secret': instance.secret,
  'events': instance.events,
  'active': instance.active,
  'createdAt': instance.createdAt.toIso8601String(),
};

_ApiKeyInfo _$ApiKeyInfoFromJson(Map<String, dynamic> json) => _ApiKeyInfo(
  id: json['id'] as String,
  name: json['name'] as String,
  prefix: json['prefix'] as String,
  lastUsedAt: json['lastUsedAt'] == null
      ? null
      : DateTime.parse(json['lastUsedAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  revokedAt: json['revokedAt'] == null
      ? null
      : DateTime.parse(json['revokedAt'] as String),
);

Map<String, dynamic> _$ApiKeyInfoToJson(_ApiKeyInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'prefix': instance.prefix,
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'revokedAt': instance.revokedAt?.toIso8601String(),
    };
