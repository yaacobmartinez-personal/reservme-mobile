// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Team _$TeamFromJson(Map<String, dynamic> json) => _Team(
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TeamMember>[],
  invitations:
      (json['invitations'] as List<dynamic>?)
          ?.map((e) => PendingInvite.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PendingInvite>[],
  yourRole:
      $enumDecodeNullable(_$VenueRoleEnumMap, json['yourRole']) ??
      VenueRole.member,
);

Map<String, dynamic> _$TeamToJson(_Team instance) => <String, dynamic>{
  'members': instance.members,
  'invitations': instance.invitations,
  'yourRole': _$VenueRoleEnumMap[instance.yourRole]!,
};

const _$VenueRoleEnumMap = {
  VenueRole.owner: 'owner',
  VenueRole.admin: 'admin',
  VenueRole.member: 'member',
};

_TeamMember _$TeamMemberFromJson(Map<String, dynamic> json) => _TeamMember(
  id: json['id'] as String,
  userId: json['userId'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  role:
      $enumDecodeNullable(_$VenueRoleEnumMap, json['role']) ?? VenueRole.member,
  isSelf: json['isSelf'] as bool? ?? false,
  joinedAt: DateTime.parse(json['joinedAt'] as String),
);

Map<String, dynamic> _$TeamMemberToJson(_TeamMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'role': _$VenueRoleEnumMap[instance.role]!,
      'isSelf': instance.isSelf,
      'joinedAt': instance.joinedAt.toIso8601String(),
    };

_PendingInvite _$PendingInviteFromJson(Map<String, dynamic> json) =>
    _PendingInvite(
      id: json['id'] as String,
      email: json['email'] as String,
      role:
          $enumDecodeNullable(_$VenueRoleEnumMap, json['role']) ??
          VenueRole.member,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$PendingInviteToJson(_PendingInvite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': _$VenueRoleEnumMap[instance.role]!,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };
