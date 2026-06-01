import 'package:arabas_app/features/diplomas/data/models/diploma_details_model.dart';
import 'package:dio/dio.dart';

abstract class DiplomaDetailsRemoteDataSource {
  Future<DiplomaDetailsModel> getDiplomaDetails(String id);
}

class DiplomaDetailsRemoteDataSourceImpl
    implements DiplomaDetailsRemoteDataSource {
  final Dio dio;

  DiplomaDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<DiplomaDetailsModel> getDiplomaDetails(String id) async {
    final response = await dio.get("UserDiploma/$id");

    return DiplomaDetailsModel.fromJson(response.data);
  }
}
