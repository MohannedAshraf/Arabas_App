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
      final result = RegisterResponseModel.fromJson(response.data);

      if (!result.isSuccess) {
        throw Exception(result.message);
      }

      return result;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Server Error");
    }
  }
}
