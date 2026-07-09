abstract class ReadNotificationState {}

class ReadNotificationInitial extends ReadNotificationState {}

class ReadNotificationLoading extends ReadNotificationState {}

class ReadNotificationSuccess extends ReadNotificationState {
  final String id;

  ReadNotificationSuccess(this.id);
}

class ReadNotificationError extends ReadNotificationState {
  final String error;

  ReadNotificationError(this.error);
}
