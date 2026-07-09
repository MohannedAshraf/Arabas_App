import 'package:arabas_app/features/announcement/domain/usecases/get_active_announcements_use_case.dart';
import 'package:arabas_app/features/announcement/presentation/bloc/announcement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  final GetActiveAnnouncementsUseCase useCase;

  AnnouncementCubit(this.useCase) : super(AnnouncementInitial());

  Future<void> getAnnouncements() async {
    emit(AnnouncementLoading());

    try {
      final result = await useCase();

      emit(AnnouncementSuccess(result));
    } catch (e) {
      emit(AnnouncementError(e.toString().replaceAll("Exception: ", "")));
    }
  }
}
