import 'package:dio/dio.dart';

import '../models/last_progress_model.dart';

abstract class LastProgressRemoteDataSource {
  Future<List<LastProgressModel>> getLastThreeProgress();
}

class LastProgressRemoteDataSourceImpl implements LastProgressRemoteDataSource {
  final Dio dio;

  LastProgressRemoteDataSourceImpl(this.dio);

  @override
  Future<List<LastProgressModel>> getLastThreeProgress() async {
    final response = await dio.get("Progress/get-last-three");

    final List list = response.data["data"];

    return list.map((e) => LastProgressModel.fromJson(e)).toList();
  }
}
