import 'package:arabas_app/features/notifications/domain/usecases/delete_notification_use_case.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/delete_notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteNotificationCubit extends Cubit<DeleteNotificationState> {
  final DeleteNotificationUseCase useCase;

  DeleteNotificationCubit(this.useCase) : super(DeleteNotificationInitial());

  Future<void> deleteNotification(String id) async {
    emit(DeleteNotificationLoading());

    try {
      await useCase(id);

      emit(DeleteNotificationSuccess(id));
    } catch (e) {
      emit(DeleteNotificationError(e.toString()));
    }
  }
}
