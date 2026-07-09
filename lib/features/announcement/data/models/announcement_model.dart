import 'package:arabas_app/features/announcement/domain/entities/announcement_entity.dart';

class AnnouncementModel extends AnnouncementEntity {
  const AnnouncementModel({
    required super.id,
    required super.title,
    required super.isActive,
    required super.displayOrder,
    required super.startDate,
    required super.endDate,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      isActive: json["isActive"] ?? false,
      displayOrder: json["displayOrder"] ?? 0,
      startDate: json["startDate"] ?? "",
      endDate: json["endDate"] ?? "",
    );
  }
}
