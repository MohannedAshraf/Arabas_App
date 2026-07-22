// ignore_for_file: file_names

import 'package:dio/dio.dart';

import '../models/my_diploma_video_model.dart';

abstract class MyDiplomaVideoRemoteDataSource {
  Future<MyDiplomaVideoModel> getVideo(String videoId);
}

class MyDiplomaVideoRemoteDataSourceImpl
    implements MyDiplomaVideoRemoteDataSource {
  final Dio dio;

  MyDiplomaVideoRemoteDataSourceImpl(this.dio);

  @override
  Future<MyDiplomaVideoModel> getVideo(String videoId) async {
    final response = await dio.get(
      "MyDiplomaEnrollments/my-diploma/videos/$videoId",
    );

    return MyDiplomaVideoModel.fromJson(response.data["data"]);
  }
}
