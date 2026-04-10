class LoginEntity {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final UserEntity user;

  LoginEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.user,
  });
}

class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String? profileImageUrl;
  final List<String> roles;

  UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.profileImageUrl,
    required this.roles,
  });
}
