import 'package:arabas_app/features/my_courses/domain/usecases/get_last_progress_usecase.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/last_progress_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LastProgressCubit extends Cubit<LastProgressState> {
  final GetLastThreeProgressUseCase getLastThreeProgressUseCase;

  LastProgressCubit(this.getLastThreeProgressUseCase)
    : super(LastProgressInitial());

  Future<void> getLastThreeProgress() async {
    emit(LastProgressLoading());

    try {
      final result = await getLastThreeProgressUseCase();

      emit(LastProgressLoaded(result));
    } catch (e) {
      emit(LastProgressError(e.toString()));
    }
  }
}
