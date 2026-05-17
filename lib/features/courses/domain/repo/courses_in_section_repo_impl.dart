import 'package:arabas_app/features/courses/data/data_sources/courses_in_section_remote_data_source.dart';
import 'package:arabas_app/features/courses/data/models/courses_in_section_model.dart';
import 'package:arabas_app/features/courses/domain/entities/courses_in_section_entity.dart';
import 'package:arabas_app/features/courses/domain/repo/courses_in_section_repo.dart';

class CoursessRepoImpl implements CoursessRepo {
  final CoursesInSectionRemoteDataSource remote;
  CoursessRepoImpl(this.remote);

  @override
  Future<List<CoursesInSectionEntity>> getCoursesBySection(
    String sectionId,
    int page,
  ) async {
    final data = await remote.getCoursesBySection(
      sectionId: sectionId,
      page: page,
    );

    final list = data["data"]["data"] as List;

    return list.map((e) => CoursesInSectionModel.fromJson(e)).toList();
  }
}
