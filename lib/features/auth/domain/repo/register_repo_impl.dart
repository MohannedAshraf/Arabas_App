import 'package:arabas_app/features/auth/data/data_sources/register_remote_data_source.dart';
import 'package:arabas_app/features/auth/data/models/register_model.dart';
import 'package:arabas_app/features/auth/domain/repo/register_repo.dart';

import '../../domain/entities/register_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<RegisterEntity> register(RegisterRequestModel model) async {
    final response = await remoteDataSource.register(model);

    return RegisterEntity(userId: response.data, message: response.message);
  }
}
