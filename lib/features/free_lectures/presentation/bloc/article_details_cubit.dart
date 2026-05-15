import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_article_details_usecase.dart';
import 'article_details_state.dart';

class ArticleDetailsCubit extends Cubit<ArticleDetailsState> {
  final GetArticleDetailsUseCase getArticleDetailsUseCase;

  ArticleDetailsCubit(this.getArticleDetailsUseCase)
    : super(ArticleDetailsInitial());

  Future<void> fetchArticle(String id) async {
    emit(ArticleDetailsLoading());
    try {
      final article = await getArticleDetailsUseCase(id);
      emit(ArticleDetailsLoaded(article));
    } catch (e) {
      emit(ArticleDetailsError("حدث خطأ أثناء تحميل المحاضرة"));
    }
  }
}
