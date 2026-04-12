class RegisterRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String deviceId;
  final String deviceName;
  final String platform;
  final String fingerprint;

  RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.deviceId,
    required this.deviceName,
    required this.platform,
    required this.fingerprint,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "phoneNumber": phoneNumber,
      "deviceId": deviceId,
      "deviceName": deviceName,
      "platform": platform,
      "fingerprint": fingerprint,
    };
  }
}

class RegisterResponseModel {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final String? data;
  final dynamic errors;

  RegisterResponseModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    this.data,
    this.errors,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      isSuccess: json["isSuccess"] ?? json["IsSuccess"],
      statusCode: json["statusCode"] ?? json["StatusCode"],
      message: json["message"] ?? json["Message"],
      data: json["data"] ?? json["Data"],
      errors: json["errors"] ?? json["Errors"],
    );
  }
}
