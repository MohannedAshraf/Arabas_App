import 'package:arabas_app/features/my_courses/data/models/my_video_details_model.dart';
import 'package:dio/dio.dart';

abstract class MyVideoDetailsRemoteDataSource {
  Future<MyVideoDetailsModel> getVideoDetails(String videoId);
}

class MyVideoDetailsRemoteDataSourceImpl
    implements MyVideoDetailsRemoteDataSource {
  final Dio dio;

  MyVideoDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<MyVideoDetailsModel> getVideoDetails(String videoId) async {
    final response = await dio.get(
      "Student/Course/video-details-subscribed/$videoId",
    );

    return MyVideoDetailsModel.fromJson(response.data["data"]);
  }
}
