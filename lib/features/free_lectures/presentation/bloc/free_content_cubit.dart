import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_articles_usecase.dart';
import '../../domain/usecases/get_videos_usecase.dart';
import 'free_content_state.dart';

class FreeContentCubit extends Cubit<FreeContentState> {
  final GetArticlesUseCase getArticlesUseCase;
  final GetVideosUseCase getVideosUseCase;

  FreeContentCubit(this.getArticlesUseCase, this.getVideosUseCase)
    : super(FreeContentInitial());

  Future<void> fetchArticles() async {
    emit(FreeContentLoading());
    try {
      final data = await getArticlesUseCase();
      emit(ArticlesLoaded(data));
    } catch (e) {
      emit(FreeContentError(e.toString()));
    }
  }

  Future<void> fetchVideos() async {
    emit(FreeContentLoading());
    try {
      final data = await getVideosUseCase();
      emit(VideosLoaded(data));
    } catch (e) {
      emit(FreeContentError(e.toString()));
    }
  }
}
