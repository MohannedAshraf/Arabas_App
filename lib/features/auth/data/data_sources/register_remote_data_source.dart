import 'package:arabas_app/core/services/register_api_service.dart';
import 'package:arabas_app/features/auth/data/models/register_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
        debugPrint("ERROR : ${result.message}");
        throw Exception(result.message);
      }

      return result;
    } on DioException catch (e) {
      final message =
          e.response?.data?["message"] ??
          e.response?.data?["Message"] ??
          "Server Error";

      debugPrint("ERROR : $message");
      debugPrint("STATUS CODE : ${e.response?.statusCode}");
      debugPrint("RESPONSE DATA : ${e.response?.data}");
      debugPrint("DIO ERROR TYPE : ${e.type}");

      throw Exception(message);
    } catch (e) {
      debugPrint("ERROR : $e");
      throw Exception(e.toString());
    }
  }
}
