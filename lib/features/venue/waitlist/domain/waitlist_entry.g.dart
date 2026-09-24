// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waitlist_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WaitlistEntry _$WaitlistEntryFromJson(Map<String, dynamic> json) =>
    _WaitlistEntry(
      id: json['id'] as String,
      customerName: json['customerName'] as String,
      customerEmail: json['customerEmail'] as String?,
      customerPhone: json['customerPhone'] as String?,
      spaceName: json['spaceName'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      whenLabel: json['whenLabel'] as String,
      status:
          $enumDecodeNullable(_$WaitlistStatusEnumMap, json['status']) ??
          WaitlistStatus.waiting,
      createdAt: DateTime.parse(json['createdAt'] as String),
      notifiedAt: json['notifiedAt'] == null
          ? null
          : DateTime.parse(json['notifiedAt'] as String),
      claimExpiresAt: json['claimExpiresAt'] == null
          ? null
          : DateTime.parse(json['claimExpiresAt'] as String),
    );

Map<String, dynamic> _$WaitlistEntryToJson(_WaitlistEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'customerPhone': instance.customerPhone,
      'spaceName': instance.spaceName,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'whenLabel': instance.whenLabel,
      'status': _$WaitlistStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'notifiedAt': instance.notifiedAt?.toIso8601String(),
      'claimExpiresAt': instance.claimExpiresAt?.toIso8601String(),
    };

const _$WaitlistStatusEnumMap = {
  WaitlistStatus.waiting: 'waiting',
  WaitlistStatus.notified: 'notified',
  WaitlistStatus.converted: 'converted',
  WaitlistStatus.expired: 'expired',
};
