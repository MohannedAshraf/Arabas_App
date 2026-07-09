import 'package:arabas_app/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationPaginationLoading extends NotificationState {
  final NotificationPageEntity oldData;

  NotificationPaginationLoading(this.oldData);
}

class NotificationSuccess extends NotificationState {
  final NotificationPageEntity data;

  NotificationSuccess(this.data);
}

class NotificationError extends NotificationState {
  final String error;

  NotificationError(this.error);
}
