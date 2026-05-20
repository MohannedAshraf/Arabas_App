import 'package:arabas_app/features/book_courses/domain/entity/course_book_entity.dart';

class CourseBookModel extends CourseBookEntity {
  CourseBookModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createdAt,
  });

  factory CourseBookModel.fromJson(Map<String, dynamic> json) {
    return CourseBookModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['createAt'],
    );
  }
}
