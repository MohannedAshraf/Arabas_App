import 'package:dio/dio.dart';

import '../models/progress_model.dart';
import 'progress_remote_data_source.dart';

class ProgressRemoteDataSourceImpl implements ProgressRemoteDataSource {
  final Dio dio;

  ProgressRemoteDataSourceImpl(this.dio);

  @override
  Future<bool> trackProgress({
    required String lessonId,
    required int positionSeconds,
  }) async {
    final response = await dio.post(
      "/Progress/track",
      data: {"lessonId": lessonId, "positionSeconds": positionSeconds},
    );

    final model = ProgressModel.fromJson(response.data);

    return model.data;
  }
}
