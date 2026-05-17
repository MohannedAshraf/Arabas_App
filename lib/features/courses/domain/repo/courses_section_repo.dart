import 'package:arabas_app/features/courses/domain/entities/courses_section_entity.dart';

abstract class CoursesRepo {
  Future<List<SectionEntity>> getSections();
}
