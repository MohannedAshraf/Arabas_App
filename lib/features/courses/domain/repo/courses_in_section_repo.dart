import 'package:arabas_app/features/courses/domain/entities/courses_in_section_entity.dart';

abstract class CoursessRepo {
  Future<List<CoursesInSectionEntity>> getCoursesBySection(
    String sectionId,
    int page,
  );
}
