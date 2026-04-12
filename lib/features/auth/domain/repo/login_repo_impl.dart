import 'package:arabas_app/core/services/local_storage_services.dart';
import 'package:arabas_app/features/auth/data/data_sources/login_remote_data_source.dart';
import 'package:arabas_app/features/auth/data/models/login_model.dart';
import 'package:arabas_app/features/auth/domain/entities/login_entity.dart';
import 'package:arabas_app/features/auth/domain/repo/login_repo.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LocalStorageService localStorage;

  LoginRepositoryImpl(this.remoteDataSource, this.localStorage);

  @override
  Future<LoginEntity> login(LoginRequestModel request) async {
    final response = await remoteDataSource.login(request);

    final data = response.data!;

    // 🔥 Save BOTH tokens
    await localStorage.saveAccessToken(data.accessToken);
    await localStorage.saveRefreshToken(data.refreshToken);

    return LoginEntity(
      accessToken: data.accessToken,
      refreshToken: data.refreshToken,
      expiresIn: data.expiresIn,
      user: UserEntity(
        id: data.user.id,
        email: data.user.email,
        fullName: data.user.fullName,
        phoneNumber: data.user.phoneNumber,
        profileImageUrl: data.user.profileImageUrl,
        roles: data.user.roles,
      ),
    );
  }
}
