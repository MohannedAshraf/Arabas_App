import 'package:arabas_app/features/diplomas/domain/entities/diploma_details_entity.dart';
import 'package:arabas_app/features/diplomas/domain/repo/diploma_details_repo.dart';

class GetDiplomaDetailsUseCase {
  final DiplomaDetailsRepository repository;

  GetDiplomaDetailsUseCase(this.repository);

  Future<DiplomaDetailsEntity> call(String id) {
    return repository.getDiplomaDetails(id);
  }
}
