import 'package:arabas_app/features/practicals/domain/entity/practical_entity.dart';
import 'package:arabas_app/features/practicals/domain/repo/practical_repo.dart';

class GetPracticalUseCase {
  final PracticalRepository repository;

  GetPracticalUseCase(this.repository);

  Future<List<PracticalEntity>> call() {
    return repository.getPracticals();
  }
}
