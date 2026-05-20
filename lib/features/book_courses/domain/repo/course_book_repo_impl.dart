import 'package:arabas_app/features/book_courses/data/data_source/course_book_remote_data_source.dart';
import 'package:arabas_app/features/book_courses/domain/entity/course_book_entity.dart';
import 'package:arabas_app/features/book_courses/domain/repo/course_book_repo.dart';

class CourseBooksRepoImpl implements CourseBooksRepo {
  final CourseBooksRemoteDataSource remoteDataSource;

  CourseBooksRepoImpl(this.remoteDataSource);

  @override
  Future<List<CourseBookEntity>> getEnrolledCourseBooks() {
    return remoteDataSource.getEnrolledCourseBooks();
  }
}
