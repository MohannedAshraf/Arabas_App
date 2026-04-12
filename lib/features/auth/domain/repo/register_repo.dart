import 'package:arabas_app/features/auth/data/models/register_model.dart';

import '../entities/register_entity.dart';

abstract class AuthRepository {
  Future<RegisterEntity> register(RegisterRequestModel model);
}
