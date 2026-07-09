abstract class NotificationNumberState {}

class NotificationNumberInitial extends NotificationNumberState {}

class NotificationNumberLoading extends NotificationNumberState {}

class NotificationNumberSuccess extends NotificationNumberState {
  final int count;

  NotificationNumberSuccess(this.count);
}

class NotificationNumberError extends NotificationNumberState {
  final String error;

  NotificationNumberError(this.error);
}
