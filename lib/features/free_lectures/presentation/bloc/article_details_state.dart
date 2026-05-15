import '../../domain/entities/article_details_entity.dart';

abstract class ArticleDetailsState {}

class ArticleDetailsInitial extends ArticleDetailsState {}

class ArticleDetailsLoading extends ArticleDetailsState {}

class ArticleDetailsLoaded extends ArticleDetailsState {
  final ArticleDetailsEntity article;
  ArticleDetailsLoaded(this.article);
}

class ArticleDetailsError extends ArticleDetailsState {
  final String message;
  ArticleDetailsError(this.message);
}
