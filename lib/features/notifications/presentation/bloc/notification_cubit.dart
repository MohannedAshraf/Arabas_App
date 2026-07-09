import 'package:arabas_app/features/notifications/domain/entities/notification_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/notification_usecase.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationUseCase useCase;

  NotificationCubit(this.useCase) : super(NotificationInitial());

  int currentPage = 1;

  Future<void> getNotifications({int page = 1}) async {
    try {
      if (state is NotificationSuccess) {
        emit(
          NotificationPaginationLoading((state as NotificationSuccess).data),
        );
      } else {
        emit(NotificationLoading());
      }

      currentPage = page;

      final result = await useCase(page);

      emit(NotificationSuccess(result));
    } catch (e) {
      emit(NotificationError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> refresh() async {
    await getNotifications(page: 1);
  }

  void markAsRead(String id) {
    if (state is! NotificationSuccess) return;

    final currentState = state as NotificationSuccess;

    final updatedNotifications =
        currentState.data.notifications.map((notification) {
          if (notification.id == id) {
            return NotificationEntity(
              id: notification.id,
              title: notification.title,
              body: notification.body,
              createdAt: notification.createdAt,
              isRead: true,
            );
          }

          return notification;
        }).toList();

    emit(
      NotificationSuccess(
        NotificationPageEntity(
          pageNumber: currentState.data.pageNumber,
          totalPages: currentState.data.totalPages,
          hasNextPage: currentState.data.hasNextPage,
          notifications: updatedNotifications,
        ),
      ),
    );
  }

  void removeNotification(String id) {
    if (state is! NotificationSuccess) return;

    final currentState = state as NotificationSuccess;

    final updatedNotifications =
        currentState.data.notifications.where((e) => e.id != id).toList();

    emit(
      NotificationSuccess(
        NotificationPageEntity(
          pageNumber: currentState.data.pageNumber,
          totalPages: currentState.data.totalPages,
          hasNextPage: currentState.data.hasNextPage,
          notifications: updatedNotifications,
        ),
      ),
    );
  }
}
