class AnnouncementEntity {
  final String id;
  final String title;
  final bool isActive;
  final int displayOrder;
  final String startDate;
  final String endDate;

  const AnnouncementEntity({
    required this.id,
    required this.title,
    required this.isActive,
    required this.displayOrder,
    required this.startDate,
    required this.endDate,
  });
}
