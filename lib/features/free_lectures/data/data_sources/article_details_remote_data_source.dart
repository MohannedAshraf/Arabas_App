import 'package:arabas_app/features/free_lectures/data/models/article_details.dart';
import 'package:dio/dio.dart';

abstract class ArticleDetailsRemoteDataSource {
  Future<ArticleDetailsModel> getArticleById(String id);
}

class ArticleDetailsRemoteDataSourceImpl
    implements ArticleDetailsRemoteDataSource {
  final Dio dio;

  ArticleDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<ArticleDetailsModel> getArticleById(String id) async {
    final response = await dio.get("FreeArticleVideo/GetArticleById/$id");

    return ArticleDetailsModel.fromJson(response.data["data"]);
  }
}
