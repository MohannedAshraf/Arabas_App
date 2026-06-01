import 'package:arabas_app/features/diplomas/domain/entities/diplomas_entity.dart';
import 'package:arabas_app/features/diplomas/domain/repo/diplomas_repo.dart';

class GetDiplomasUseCase {
  final DiplomaRepository repository;

  GetDiplomasUseCase(this.repository);

  Future<List<DiplomaEntity>> call() {
    return repository.getDiplomas();
  }
}
