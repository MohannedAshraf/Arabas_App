import 'package:arabas_app/features/my_courses/domain/entity/progress_entity.dart';

class ProgressModel extends ProgressEntity {
  const ProgressModel({
    required super.isSuccess,
    required super.message,
    required super.data,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      isSuccess: json["isSuccess"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] ?? false,
    );
  }
}
