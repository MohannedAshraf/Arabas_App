import 'package:arabas_app/features/auth/data/models/login_model.dart';
import 'package:dio/dio.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await dio.post(
      "https://arabas.runasp.net/api/Auth/login",
      data: request.toJson(),
    );

    return LoginResponseModel.fromJson(response.data);
  }
}
