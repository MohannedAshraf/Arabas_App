import 'package:arabas_app/features/practicals/domain/entity/practical_entity.dart';

class PracticalModel extends PracticalEntity {
  PracticalModel({
    required super.id,
    required super.title,
    required super.imageUrl,
  });

  factory PracticalModel.fromJson(Map<String, dynamic> json) {
    return PracticalModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      imageUrl: json["urlImgOut"] ?? "",
    );
  }
}
