import 'package:arabas_app/features/courses/domain/entities/courses_in_section_entity.dart';
import 'package:arabas_app/features/courses/domain/repo/courses_in_section_repo.dart';

class GetCoursesUseCase {
  final CoursessRepo repo;
  GetCoursesUseCase(this.repo);

  Future<List<CoursesInSectionEntity>> call(String sectionId, int page) {
    return repo.getCoursesBySection(sectionId, page);
  }
}
