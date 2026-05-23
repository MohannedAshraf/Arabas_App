import 'package:arabas_app/features/my_courses/domain/usecases/get_my_video_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_video_details_state.dart';

class MyVideoDetailsCubit extends Cubit<MyVideoDetailsState> {
  final GetMyVideoDetailsUsecase usecase;

  MyVideoDetailsCubit(this.usecase) : super(MyVideoDetailsInitial());

  Future<void> getVideoDetails(String videoId) async {
    emit(MyVideoDetailsLoading());

    try {
      final result = await usecase(videoId);

      emit(MyVideoDetailsSuccess(result));
    } catch (e) {
      emit(MyVideoDetailsError(e.toString()));
    }
  }
}
