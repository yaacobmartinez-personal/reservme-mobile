import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// A venue staff account (`user` table). Customers are never users.
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? name,
    @Default(false) bool emailVerified,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
