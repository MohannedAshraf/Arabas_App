import 'package:arabas_app/features/free_lectures/domain/usecases/video_details_usecase.dart';
import 'package:arabas_app/features/free_lectures/presentation/bloc/video_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final GetVideoByIdUseCase getVideoByIdUseCase;

  VideoPlayerCubit(this.getVideoByIdUseCase) : super(VideoInitial());

  Future<void> fetchVideo(String id) async {
    emit(VideoLoading());
    try {
      final video = await getVideoByIdUseCase(id);
      emit(VideoLoaded(video));
    } catch (e) {
      emit(VideoError("حدث خطأ أثناء تحميل الفيديو"));
    }
  }
}
