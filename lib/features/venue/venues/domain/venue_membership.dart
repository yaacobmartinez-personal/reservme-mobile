import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

part 'venue_membership.freezed.dart';
part 'venue_membership.g.dart';

/// One venue the signed-in user belongs to, with their role there
/// (`GET /mobile/me` → `venues[]`, API-CONTRACT #13).
@freezed
abstract class VenueMembership with _$VenueMembership {
  const VenueMembership._();

  const factory VenueMembership({
    required String orgId,
    required String slug,
    required String name,
    required VenueRole role,
    @Default('Asia/Manila') String timezone,
    @Default('PHP') String currency,
    @Default(VenueTheme.pine) VenueTheme theme,
    @Default(false) bool suspended,
    @Default(0) int activeSpaces,
  }) = _VenueMembership;

  factory VenueMembership.fromJson(Map<String, dynamic> json) =>
      _$VenueMembershipFromJson(json);

  bool get canManage => role.atLeast(VenueRole.admin);
  bool get isOwner => role == VenueRole.owner;
}
