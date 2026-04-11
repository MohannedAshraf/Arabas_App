import 'package:arabas_app/core/services/local_storage_services.dart';
import 'package:arabas_app/features/auth/data/data_sources/login_remote_data_source.dart';
import 'package:arabas_app/features/auth/data/models/login_model.dart';
import 'package:arabas_app/features/auth/domain/repo/login_repo.dart';

import '../../domain/entities/login_entity.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LocalStorageService localStorage; // 🔥 جديد

  LoginRepositoryImpl(this.remoteDataSource, this.localStorage);

  @override
  Future<LoginEntity> login({
    required String email,
    required String password,
    required String deviceId,
  }) async {
    final response = await remoteDataSource.login(
      LoginRequestModel(email: email, password: password, deviceId: deviceId),
    );

    final data = response.data!;

    /// 🔥 أهم سطر في المشروع كله
    await localStorage.saveToken(data.accessToken);

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
