import '../../domain/entities/diploma_details_entity.dart';

class DiplomaDetailsModel extends DiplomaDetailsEntity {
  DiplomaDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.durationHours,
    required super.price,
    required super.introVideoUrl,
    required super.modules,
  });

  factory DiplomaDetailsModel.fromJson(Map<String, dynamic> json) {
    return DiplomaDetailsModel(
      id: json["id"],
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      durationHours: json["durationHours"] ?? 0,
      price: (json["priceInEGP"] ?? 0).toDouble(),
      introVideoUrl: json["introVideoUrl"],
      modules:
          (json["modules"] as List)
              .map(
                (e) => ModuleEntity(
                  id: e["id"],
                  title: e["title"],
                  videos:
                      (e["videos"] as List)
                          .map(
                            (v) => VideoEntity(
                              id: v["id"],
                              title: v["title"],
                              durationSeconds: v["durationSeconds"] ?? 0,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
    );
  }
}
