import 'package:arabas_app/features/diplomas/domain/entities/diplomas_entity.dart';

class DiplomaModel extends DiplomaEntity {
  const DiplomaModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.priceInEGP,
    required super.priceOutEGP,
    required super.offer,
    required super.durationHours,
    required super.level,
  });

  factory DiplomaModel.fromJson(Map<String, dynamic> json) {
    return DiplomaModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      priceInEGP: (json["priceInEGP"] ?? 0).toDouble(),
      priceOutEGP: (json["priceOutEGP"] ?? 0).toDouble(),
      offer: json["offer"] ?? 0,
      durationHours: json["durationHours"] ?? 0,
      level: json["level"] ?? "",
    );
  }
}
