import 'package:dio/dio.dart';

import '../models/practical_model.dart';

abstract class PracticalRemoteDataSource {
  Future<List<PracticalModel>> getPracticals();
}

class PracticalRemoteDataSourceImpl implements PracticalRemoteDataSource {
  final Dio dio;

  PracticalRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PracticalModel>> getPracticals() async {
    final response = await dio.get("Practical");

    return (response.data as List)
        .map((e) => PracticalModel.fromJson(e))
        .toList();
  }
}
