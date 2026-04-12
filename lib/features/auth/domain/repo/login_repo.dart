import 'package:arabas_app/features/auth/data/models/login_model.dart';
import 'package:arabas_app/features/auth/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<LoginEntity> login(LoginRequestModel request);
}
