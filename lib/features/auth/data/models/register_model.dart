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
    };
  }
}

class RegisterResponseModel {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final String data;
  final dynamic errors;

  RegisterResponseModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      isSuccess: json["isSuccess"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"],
      errors: json["errors"],
    );
  }
}
