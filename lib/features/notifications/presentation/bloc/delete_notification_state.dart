abstract class DeleteNotificationState {}

class DeleteNotificationInitial extends DeleteNotificationState {}

class DeleteNotificationLoading extends DeleteNotificationState {}

class DeleteNotificationSuccess extends DeleteNotificationState {
  final String id;

  DeleteNotificationSuccess(this.id);
}

class DeleteNotificationError extends DeleteNotificationState {
  final String error;

  DeleteNotificationError(this.error);
}
