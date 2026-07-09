class DeleteNotificationEntity {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final bool data;

  const DeleteNotificationEntity({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    required this.data,
  });
}
