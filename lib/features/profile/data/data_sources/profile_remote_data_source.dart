import 'package:arabas_app/features/profile/data/models/profile_model.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponseModel> getProfile(String token);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl(this.dio);

  @override
  Future<ProfileResponseModel> getProfile(String token) async {
    try {
      final response = await dio.get(
        "https://arabas.runasp.net/api/Auth/Profile",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return ProfileResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception("SESSION_EXPIRED");
      }

      if (e.response?.statusCode == 500) {
        throw Exception("SERVER_ERROR");
      }

      throw Exception("NETWORK_ERROR");
    }
  }
}
