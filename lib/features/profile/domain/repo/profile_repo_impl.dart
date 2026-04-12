import 'package:arabas_app/core/services/local_storage_services.dart';
import 'package:arabas_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:arabas_app/features/profile/domain/entities/profile_entity.dart';
import 'package:arabas_app/features/profile/domain/repo/profile_repo.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final LocalStorageService localStorage;

  ProfileRepositoryImpl(this.remoteDataSource, this.localStorage);

  @override
  Future<ProfileEntity> getProfile() async {
    try {
      final token = localStorage.getAccessToken();

      // 🔥 no token → session expired
      if (token.isEmpty) {
        throw Exception("SESSION_EXPIRED");
      }

      final result = await remoteDataSource.getProfile(token);

      return result;
    } on Exception catch (e) {
      final message = e.toString();

      // 🔥 token expired case (future interceptor will handle refresh)
      if (message.contains("401") ||
          message.contains("unauthorized") ||
          message.contains("invalid_token")) {
        throw Exception("SESSION_EXPIRED");
      }

      // 🔥 server error
      if (message.contains("500")) {
        throw Exception("حدث خطأ في السيرفر، حاول لاحقاً");
      }

      return Future.error("تحقق من اتصال الانترنت");
    }
  }
}
