class DiplomaEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String imagePublicId;
  final double priceInEGP;
  final double priceOutEGP;
  final int offer;
  final int durationHours;
  final String level;
  final int enrolledStudentsCount;
  final bool isPublished;

  const DiplomaEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.imagePublicId,
    required this.priceInEGP,
    required this.priceOutEGP,
    required this.offer,
    required this.durationHours,
    required this.level,
    required this.enrolledStudentsCount,
    required this.isPublished,
  });
}
