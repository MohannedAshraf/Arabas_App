import '../../domain/entities/profile_entity.dart';

class ProfileResponseModel extends ProfileEntity {
  final bool isSuccess;
  final int statusCode;
  final String message;

  ProfileResponseModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    required super.id,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    required super.imageUrl,
    required super.phoneName,
    required super.platform,
    required super.totalCourses,
    required super.totalExamSolve,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return ProfileResponseModel(
      isSuccess: json['isSuccess'] ?? false,
      statusCode: json['statusCode'] ?? 500,
      message: json['message'] ?? "",
      id: data['id'] ?? "",
      fullName: data['fullName'] ?? "",
      email: data['email'] ?? "",
      phoneNumber: data['phoneNumber'] ?? "",
      role: data['role'] ?? "",
      imageUrl: data['imageUrl'] ?? "",
      phoneName: List<String>.from(data['phoneName'] ?? []),
      platform: List<String>.from(data['platform'] ?? []),
      totalCourses: data['totalCourses'] ?? 0,
      totalExamSolve: data['totalExamSolve'] ?? 0,
    );
  }
}

class ProfileRequestModel {
  final String token;

  ProfileRequestModel({required this.token});
}
