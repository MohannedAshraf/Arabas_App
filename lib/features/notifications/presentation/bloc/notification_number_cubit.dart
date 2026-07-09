import 'package:arabas_app/features/notifications/domain/usecases/get_notification_number_usecase.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/notification_number_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationNumberCubit extends Cubit<NotificationNumberState> {
  final GetNotificationNumberUseCase useCase;

  NotificationNumberCubit(this.useCase) : super(NotificationNumberInitial());

  Future<void> getUnreadCount() async {
    emit(NotificationNumberLoading());

    try {
      final result = await useCase();

      emit(NotificationNumberSuccess(result.count));
    } catch (e) {
      emit(NotificationNumberError(e.toString()));
    }
  }
}
