import 'package:arabas_app/features/diplomas/data/models/diplomas_model.dart';
import 'package:dio/dio.dart';

abstract class DiplomaRemoteDataSource {
  Future<List<DiplomaModel>> getDiplomas();
}

class DiplomaRemoteDataSourceImpl implements DiplomaRemoteDataSource {
  final Dio dio;

  DiplomaRemoteDataSourceImpl(this.dio);

  @override
  Future<List<DiplomaModel>> getDiplomas() async {
    final response = await dio.get(
      "UserDiploma",
      queryParameters: {"pageNumber": 1, "pageSize": 50},
    );

    final List diplomas = response.data["diplomas"] ?? [];

    return diplomas.map((e) => DiplomaModel.fromJson(e)).toList();
  }
}
