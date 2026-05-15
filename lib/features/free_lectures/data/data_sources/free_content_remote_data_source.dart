import 'package:dio/dio.dart';
import '../models/free_content_model.dart';

abstract class FreeContentRemoteDataSource {
  Future<List<FreeArticleModel>> getArticles();
  Future<List<FreeVideoModel>> getVideos();
}

class FreeContentRemoteDataSourceImpl implements FreeContentRemoteDataSource {
  final Dio dio;

  FreeContentRemoteDataSourceImpl(this.dio);

  @override
  Future<List<FreeArticleModel>> getArticles() async {
    final response = await dio.get("FreeArticleVideo/GetAllArticles");

    final List data = response.data['data'];
    return data.map((e) => FreeArticleModel.fromJson(e)).toList();
  }

  @override
  Future<List<FreeVideoModel>> getVideos() async {
    final response = await dio.get("FreeArticleVideo/GetAllVideos");

    final List data = response.data['data'];
    return data.map((e) => FreeVideoModel.fromJson(e)).toList();
  }
}
