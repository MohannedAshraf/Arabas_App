import 'package:arabas_app/features/courses/data/data_sources/courses_remote_data_source.dart';
import 'package:arabas_app/features/courses/data/models/courses_sectin_model.dart';
import 'package:arabas_app/features/courses/domain/entities/courses_section_entity.dart';
import 'package:arabas_app/features/courses/domain/repo/courses_section_repo.dart';

class CoursesRepoImpl implements CoursesRepo {
  final CoursesRemoteDataSource remoteDataSource;

  CoursesRepoImpl(this.remoteDataSource);

  @override
  Future<List<SectionEntity>> getSections() async {
    final data = await remoteDataSource.getSections();
    return data.map((e) => SectionModel.fromJson(e)).toList();
  }
}
