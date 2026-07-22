import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_my_diploma_video_use_case.dart';
import 'my_diploma_video_state.dart';

class MyDiplomaVideoCubit extends Cubit<MyDiplomaVideoState> {
  final GetMyDiplomaVideoUseCase getMyDiplomaVideoUseCase;

  MyDiplomaVideoCubit(this.getMyDiplomaVideoUseCase)
    : super(MyDiplomaVideoInitial());

  Future<void> getVideo(String videoId) async {
    emit(MyDiplomaVideoLoading());

    try {
      final result = await getMyDiplomaVideoUseCase(videoId);

      emit(MyDiplomaVideoSuccess(result));
    } catch (e) {
      emit(MyDiplomaVideoError(e.toString()));
    }
  }
}
