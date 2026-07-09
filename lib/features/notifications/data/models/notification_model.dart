class NotificationModel {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      body: json["body"] ?? "",
      isRead: json["isRead"] ?? false,
      createdAt: json["createdAt"] ?? "",
    );
  }
}

class NotificationResponseModel {
  final bool isSuccess;
  final int statusCode;
  final String message;

  final int pageNumber;
  final int totalPages;
  final bool hasNextPage;

  final List<NotificationModel> notifications;

  NotificationResponseModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    required this.pageNumber,
    required this.totalPages,
    required this.hasNextPage,
    required this.notifications,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"];

    return NotificationResponseModel(
      isSuccess: json["isSuccess"] ?? false,
      statusCode: json["statusCode"] ?? 0,
      message: json["message"] ?? "",
      pageNumber: data["pageNumber"] ?? 1,
      totalPages: data["totalPages"] ?? 1,
      hasNextPage: data["hasNextPage"] ?? false,
      notifications:
          (data["data"] as List)
              .map((e) => NotificationModel.fromJson(e))
              .toList(),
    );
  }
}
