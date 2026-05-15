import '../../domain/entities/free_content_entity.dart';

abstract class FreeContentState {}

class FreeContentInitial extends FreeContentState {}

class FreeContentLoading extends FreeContentState {}

class ArticlesLoaded extends FreeContentState {
  final List<FreeArticleEntity> articles;
  ArticlesLoaded(this.articles);
}

class VideosLoaded extends FreeContentState {
  final List<FreeVideoEntity> videos;
  VideosLoaded(this.videos);
}

class FreeContentError extends FreeContentState {
  final String message;
  FreeContentError(this.message);
}
