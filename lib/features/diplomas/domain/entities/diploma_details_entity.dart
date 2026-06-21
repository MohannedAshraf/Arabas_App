class DiplomaDetailsEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int durationHours;
  final double price;
  final String? introVideoUrl;

  final List<ModuleEntity> modules;

  final List<CertificateEntity> certificateImages;
  final List<StudentTrainingImageEntity> studentsInTrainingImages;

  DiplomaDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.durationHours,
    required this.price,
    required this.introVideoUrl,
    required this.modules,
    required this.certificateImages,
    required this.studentsInTrainingImages,
  });
}

class ModuleEntity {
  final String id;
  final String title;
  final List<VideoEntity> videos;

  ModuleEntity({required this.id, required this.title, required this.videos});
}

class VideoEntity {
  final String id;
  final String title;
  final int durationSeconds;

  VideoEntity({
    required this.id,
    required this.title,
    required this.durationSeconds,
  });
}

class CertificateEntity {
  final String id;
  final String imageUrl;

  CertificateEntity({required this.id, required this.imageUrl});
}

class StudentTrainingImageEntity {
  final String id;
  final String url;

  StudentTrainingImageEntity({required this.id, required this.url});
}
