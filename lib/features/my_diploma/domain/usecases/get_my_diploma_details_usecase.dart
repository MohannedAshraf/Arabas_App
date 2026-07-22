import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_details_entity.dart';
import 'package:arabas_app/features/my_diploma/domain/repo/my_diploma_details_repo.dart';

class GetMyDiplomaDetailsUseCase {
  final MyDiplomaDetailsRepository repository;

  GetMyDiplomaDetailsUseCase({
    required this.repository,
  });

  Future<MyDiplomaDetailsEntity> call({
    required String diplomaId,
  }) {
    return repository.getMyDiplomaDetails(
      diplomaId: diplomaId,
    );
  }
}