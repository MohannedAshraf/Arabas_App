import 'package:dio/dio.dart';

abstract class FreeVideoRemoteDataSource {
  Future<Map<String, dynamic>> getVideoById(String id);
}

class FreeVideoRemoteDataSourceImpl implements FreeVideoRemoteDataSource {
  final Dio dio;

  FreeVideoRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> getVideoById(String id) async {
    final response = await dio.get("/FreeArticleVideo/GetVideoById/$id");

    if (response.statusCode == 200 && response.data["isSuccess"] == true) {
      return response.data;
    } else {
      throw Exception("فشل تحميل الفيديو من السيرفر");
    }
  }
}
