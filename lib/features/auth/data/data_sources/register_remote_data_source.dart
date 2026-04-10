import 'package:arabas_app/core/services/register_api_service.dart';
import 'package:arabas_app/features/auth/data/models/register_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponseModel> register(RegisterRequestModel model);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    try {
      final response = await apiService.register(model.toJson());
      return RegisterResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Server Error");
    }
  }
}
