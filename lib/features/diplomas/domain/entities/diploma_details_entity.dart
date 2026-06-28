class DiplomaDetailsEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  final int durationHours;

  final double priceInEGP;
  final double priceOutEGP;

  final int offer;

  final String level;

  final int enrolledStudentsCount;

  final bool isPublished;

  final String? introVideoUrl;

  final List<ModuleEntity> modules;

  final List<CertificateEntity> certificateImages;

  final List<StudentTrainingImageEntity> studentsInTrainingImages;

  const DiplomaDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.durationHours,
    required this.priceInEGP,
    required this.priceOutEGP,
    required this.offer,
    required this.level,
    required this.enrolledStudentsCount,
    required this.isPublished,
    required this.introVideoUrl,
    required this.modules,
    required this.certificateImages,
    required this.studentsInTrainingImages,
  });
}

class ModuleEntity {
  final String id;
  final String title;
  final int order;
  final List<VideoEntity> videos;

  const ModuleEntity({
    required this.id,
    required this.title,
    required this.order,
    required this.videos,
  });
}

class VideoEntity {
  final String id;
  final String title;
  final String description;
  final int durationSeconds;
  final int order;

  final String videoUrl; // NEW

  const VideoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.durationSeconds,
    required this.order,
    required this.videoUrl,
  });
}

class CertificateEntity {
  final String id;
  final String imageUrl;

  const CertificateEntity({required this.id, required this.imageUrl});
}

class StudentTrainingImageEntity {
  final String id;
  final String url;
  final String? imagePublicId;

  const StudentTrainingImageEntity({
    required this.id,
    required this.url,
    required this.imagePublicId,
  });
}
