import 'package:arabas_app/features/notifications/domain/entities/read_notification_entity.dart';

class ReadNotificationModel extends ReadNotificationEntity {
  const ReadNotificationModel({
    required super.isSuccess,
    required super.statusCode,
    required super.message,
    required super.data,
  });

  factory ReadNotificationModel.fromJson(Map<String, dynamic> json) {
    return ReadNotificationModel(
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
