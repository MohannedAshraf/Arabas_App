class CoursesInSectionEntity {
  final String id;
  final String title;
  final String imageUrl;
  final String? imagePublicId;

  final int priceInEGP;
  final int priceOutEGP;

  final int offer;
  final String categoryName;

  final bool isPublished;
  final String created;

  final int durationHours;
  final int rateStar;
  final int videoCount;

  CoursesInSectionEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.imagePublicId,
    required this.priceInEGP,
    required this.priceOutEGP,
    required this.offer,
    required this.categoryName,
    required this.isPublished,
    required this.created,
    required this.durationHours,
    required this.rateStar,
    required this.videoCount,
  });
}
