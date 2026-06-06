import 'package:arabas_app/features/practicals/domain/entity/practical_details_entity.dart';
import 'package:arabas_app/features/practicals/domain/repo/practical_details_repo.dart';

class GetPracticalDetailsUseCase {
  final PracticalDetailsRepository repository;

  GetPracticalDetailsUseCase(this.repository);

  Future<PracticalDetailsEntity> call(String id) {
    return repository.getDetails(id);
  }
}
