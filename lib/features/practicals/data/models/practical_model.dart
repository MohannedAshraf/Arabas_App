import 'package:arabas_app/features/practicals/domain/entity/practical_entity.dart';

class PracticalModel extends PracticalEntity {
  const PracticalModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.description,
    required super.durationInHours,
    required super.studentsCount,
  });

  factory PracticalModel.fromJson(Map<String, dynamic> json) {
    return PracticalModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      imageUrl: json["urlImgOut"] ?? "",
      description: json["description"] ?? "",
      durationInHours: json["durationInHours"] ?? 0,
      studentsCount: json["studentsCount"] ?? 0,
    );
  }
}
