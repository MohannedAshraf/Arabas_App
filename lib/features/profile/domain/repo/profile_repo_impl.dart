// ignore_for_file: override_on_non_overriding_member

import 'package:arabas_app/core/services/local_storage_services.dart';
import 'package:arabas_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:arabas_app/features/profile/domain/repo/profile_repo.dart';

import '../../domain/entities/profile_entity.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final LocalStorageService localStorage;

  ProfileRepositoryImpl(this.remoteDataSource, this.localStorage);

  @override
  Future<ProfileEntity> getProfile() async {
    final token = localStorage.getToken();

    if (token.isEmpty) {
      throw Exception("Token not found");
    }

    final response = await remoteDataSource.getProfile(token);

    return response;
  }
}
