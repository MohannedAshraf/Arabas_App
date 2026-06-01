class DiplomaEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double priceInEGP;
  final double priceOutEGP;
  final int offer;
  final int durationHours;
  final String level;

  const DiplomaEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.priceInEGP,
    required this.priceOutEGP,
    required this.offer,
    required this.durationHours,
    required this.level,
  });
}
