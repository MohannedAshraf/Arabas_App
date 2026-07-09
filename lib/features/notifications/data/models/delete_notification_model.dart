import 'package:arabas_app/features/notifications/domain/entities/delete_notification_entity.dart';

class DeleteNotificationModel extends DeleteNotificationEntity {
  const DeleteNotificationModel({
    required super.isSuccess,
    required super.statusCode,
    required super.message,
    required super.data,
  });

  factory DeleteNotificationModel.fromJson(Map<String, dynamic> json) {
    return DeleteNotificationModel(
      isSuccess: json["isSuccess"] ?? false,
      statusCode: json["statusCode"] ?? 0,
      message: json["message"] ?? "",
      data: json["data"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isSuccess": isSuccess,
      "statusCode": statusCode,
      "message": message,
      "data": data,
    };
  }
}
