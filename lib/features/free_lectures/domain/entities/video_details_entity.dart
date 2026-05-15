class VideoEntity {
  final String id;
  final String title;
  final String videoUrl;
  final String? description;

  VideoEntity({
    required this.id,
    required this.title,
    required this.videoUrl,
    this.description,
  });
}
