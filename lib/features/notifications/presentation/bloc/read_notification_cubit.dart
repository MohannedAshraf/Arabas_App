import 'package:arabas_app/features/notifications/domain/usecases/read_notification_use_case.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/read_notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadNotificationCubit extends Cubit<ReadNotificationState> {
  final ReadNotificationUseCase useCase;

  ReadNotificationCubit(this.useCase) : super(ReadNotificationInitial());

  Future<void> readNotification(String id) async {
    emit(ReadNotificationLoading());

    try {
      await useCase(id);

      emit(ReadNotificationSuccess(id));
    } catch (e) {
      emit(ReadNotificationError(e.toString()));
    }
  }
}
