class NotificationNumberModel {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final int count;

  NotificationNumberModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    required this.count,
  });

  factory NotificationNumberModel.fromJson(Map<String, dynamic> json) {
    return NotificationNumberModel(
      isSuccess: json["isSuccess"],
      statusCode: json["statusCode"],
      message: json["message"],
      count: json["data"] ?? 0,
    );
  }
}
