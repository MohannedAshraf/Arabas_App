class PracticalDetailsEntity {
  final String id;
  final String title;
  final int durationInHours;
  final int studentsCount;
  final String description;
  final String imageUrl;
  final String imagePublicId;
  final String createdAt;
  final String certificateUrl;
  final String certificatePublicId;
  final List<StudentImageEntity> students;

  PracticalDetailsEntity({
    required this.id,
    required this.title,
    required this.durationInHours,
    required this.studentsCount,
    required this.description,
    required this.imageUrl,
    required this.imagePublicId,
    required this.createdAt,
    required this.certificateUrl,
    required this.certificatePublicId,
    required this.students,
  });
}

class StudentImageEntity {
  final String id;
  final String imageUrl;
  final String imagePublicId;

  StudentImageEntity({
    required this.id,
    required this.imageUrl,
    required this.imagePublicId,
  });
}
