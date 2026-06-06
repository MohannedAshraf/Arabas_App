class PracticalDetailsEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String certificateUrl;
  final String createdAt;
  final List<StudentImageEntity> students;

  PracticalDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.certificateUrl,
    required this.createdAt,
    required this.students,
  });
}

class StudentImageEntity {
  final String id;
  final String imageUrl;

  StudentImageEntity({required this.id, required this.imageUrl});
}
