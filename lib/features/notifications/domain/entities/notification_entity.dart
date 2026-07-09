class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final String createdAt;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });
}

class NotificationPageEntity {
  final int pageNumber;
  final int totalPages;
  final bool hasNextPage;

  final List<NotificationEntity> notifications;

  NotificationPageEntity({
    required this.pageNumber,
    required this.totalPages,
    required this.hasNextPage,
    required this.notifications,
  });
}
