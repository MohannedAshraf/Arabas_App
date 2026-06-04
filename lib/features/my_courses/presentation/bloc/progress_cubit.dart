import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/track_progress_usecase.dart';
import 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final TrackProgressUseCase trackProgressUseCase;

  ProgressCubit(this.trackProgressUseCase) : super(ProgressInitial());

  Future<void> trackProgress({
    required String lessonId,
    required int positionSeconds,
  }) async {
    try {
      emit(ProgressLoading());

      final result = await trackProgressUseCase(
        lessonId: lessonId,
        positionSeconds: positionSeconds,
      );

      print(
        "🔥 API TRACK SUCCESS => lessonId: $lessonId | position: $positionSeconds | result: $result",
      );

      emit(ProgressSuccess());
    } catch (e) {
      emit(ProgressError(e.toString()));
    }
  }
}
