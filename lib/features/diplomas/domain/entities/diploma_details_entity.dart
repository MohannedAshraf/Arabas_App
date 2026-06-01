class DiplomaDetailsEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int durationHours;
  final double price;
  final String? introVideoUrl;
  final List<ModuleEntity> modules;

  DiplomaDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.durationHours,
    required this.price,
    required this.introVideoUrl,
    required this.modules,
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
