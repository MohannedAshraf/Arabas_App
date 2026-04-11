import 'package:arabas_app/features/profile/domain/repo/profile_repo.dart';

import '../entities/profile_entity.dart';

class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase(this.repository);

  Future<ProfileEntity> call() async {
    return await repository.getProfile();
  }
}
