import 'package:arabas_app/features/auth/data/models/register_model.dart';
import 'package:arabas_app/features/auth/domain/repo/register_repo.dart';

import '../entities/register_entity.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<RegisterEntity> call(RegisterRequestModel model) {
    return repository.register(model);
  }
}
