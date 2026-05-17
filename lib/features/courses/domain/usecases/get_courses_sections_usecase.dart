import 'package:arabas_app/features/courses/domain/entities/courses_section_entity.dart';
import 'package:arabas_app/features/courses/domain/repo/courses_section_repo.dart';

class GetSectionsUseCase {
  final CoursesRepo repo;

  GetSectionsUseCase(this.repo);

  Future<List<SectionEntity>> call() async {
    return await repo.getSections();
  }
}
