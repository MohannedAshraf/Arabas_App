import 'package:arabas_app/features/auth/data/models/login_model.dart';
import 'package:arabas_app/features/auth/domain/entities/login_entity.dart';
import 'package:arabas_app/features/auth/domain/repo/login_repo.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<LoginEntity> call(LoginRequestModel request) {
    return repository.login(request);
  }
}
