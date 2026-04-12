class LoginRequestModel {
  final String email;
  final String password;
  final String deviceId;
  final String fingerprint;
  final String platform;

  LoginRequestModel({
    required this.email,
    required this.password,
    required this.deviceId,
    required this.fingerprint,
    required this.platform,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "deviceId": deviceId,
      "fingerprint": fingerprint,
      "platform": platform,
    };
  }
}

class LoginResponseModel {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final LoginDataModel? data;
  final dynamic errors;

  LoginResponseModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    this.data,
    this.errors,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      isSuccess: json["isSuccess"] ?? json["IsSuccess"],
      statusCode: json["statusCode"] ?? json["StatusCode"],
      message: json["message"] ?? json["Message"],
      data:
          (json["data"] ?? json["Data"]) != null
              ? LoginDataModel.fromJson(json["data"] ?? json["Data"])
              : null,
      errors: json["errors"] ?? json["Errors"],
    );
  }
}

class LoginDataModel {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final UserModel user;

  LoginDataModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.user,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expiresIn: json['expiresIn'],
      user: UserModel.fromJson(json['user']),
    );
  }
}

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String? profileImageUrl;
  final List<String> roles;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.profileImageUrl,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      profileImageUrl: json['profileImageUrl'],
      roles: List<String>.from(json['roles']),
    );
  }
}
