// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VenueMembership _$VenueMembershipFromJson(Map<String, dynamic> json) =>
    _VenueMembership(
      orgId: json['orgId'] as String,
      slug: json['slug'] as String,
      name: json['name'] as String,
      role: $enumDecode(_$VenueRoleEnumMap, json['role']),
      timezone: json['timezone'] as String? ?? 'Asia/Manila',
      currency: json['currency'] as String? ?? 'PHP',
      theme:
          $enumDecodeNullable(_$VenueThemeEnumMap, json['theme']) ??
          VenueTheme.pine,
      suspended: json['suspended'] as bool? ?? false,
      activeSpaces: (json['activeSpaces'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VenueMembershipToJson(_VenueMembership instance) =>
    <String, dynamic>{
      'orgId': instance.orgId,
      'slug': instance.slug,
      'name': instance.name,
      'role': _$VenueRoleEnumMap[instance.role]!,
      'timezone': instance.timezone,
      'currency': instance.currency,
      'theme': _$VenueThemeEnumMap[instance.theme]!,
      'suspended': instance.suspended,
      'activeSpaces': instance.activeSpaces,
    };

const _$VenueRoleEnumMap = {
  VenueRole.owner: 'owner',
  VenueRole.admin: 'admin',
  VenueRole.member: 'member',
};

const _$VenueThemeEnumMap = {
  VenueTheme.pine: 'pine',
  VenueTheme.ocean: 'ocean',
  VenueTheme.violet: 'violet',
  VenueTheme.sunset: 'sunset',
  VenueTheme.rose: 'rose',
  VenueTheme.slate: 'slate',
};
