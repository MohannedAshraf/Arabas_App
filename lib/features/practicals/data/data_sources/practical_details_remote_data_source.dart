import 'package:dio/dio.dart';

import '../models/practical_details_model.dart';

abstract class PracticalDetailsRemoteDataSource {
  Future<PracticalDetailsModel> getDetails(String id);
}

class PracticalDetailsRemoteDataSourceImpl
    implements PracticalDetailsRemoteDataSource {
  final Dio dio;

  PracticalDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<PracticalDetailsModel> getDetails(String id) async {
    final response = await dio.get("Practical/$id");

    return PracticalDetailsModel.fromJson(response.data);
  }
}
