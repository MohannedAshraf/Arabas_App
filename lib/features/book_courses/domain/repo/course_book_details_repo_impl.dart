import 'package:arabas_app/features/book_courses/data/data_source/course_book_details_remote_data_source.dart';
import 'package:arabas_app/features/book_courses/domain/entity/course_book_details_entity.dart';
import 'package:arabas_app/features/book_courses/domain/repo/course_book_details_repo.dart';

class CourseBookDetailsRepoImpl implements CourseBookDetailsRepo {
  final CourseBookDetailsRemoteDS remote;

  CourseBookDetailsRepoImpl(this.remote);

  @override
  Future<CourseBookDetailsEntity> getDetails(String id) async {
    final model = await remote.getDetails(id);

    return CourseBookDetailsEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      createdAt: model.createdAt,
      chapters:
          model.chapters
              .map(
                (e) => ChapterEntity(
                  id: e.id,
                  title: e.title,
                  description: e.description,
                  order: e.order,
                  url: e.url,
                ),
              )
              .toList(),
    );
  }
}
