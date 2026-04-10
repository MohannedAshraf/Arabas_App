import 'package:arabas_app/features/auth/domain/repo/login_repo.dart';

import '../entities/login_entity.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<LoginEntity> call({
    required String email,
    required String password,
    required String deviceId,
  }) {
    return repository.login(
      email: email,
      password: password,
      deviceId: deviceId,
    );
  }
}
