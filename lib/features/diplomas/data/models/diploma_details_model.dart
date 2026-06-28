import '../../domain/entities/diploma_details_entity.dart';

class DiplomaDetailsModel extends DiplomaDetailsEntity {
  const DiplomaDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.durationHours,
    required super.priceInEGP,
    required super.priceOutEGP,
    required super.offer,
    required super.level,
    required super.enrolledStudentsCount,
    required super.isPublished,
    required super.introVideoUrl,
    required super.modules,
    required super.certificateImages,
    required super.studentsInTrainingImages,
  });

  factory DiplomaDetailsModel.fromJson(Map<String, dynamic> json) {
    return DiplomaDetailsModel(
      id: json["id"] ?? "",

      title: json["title"] ?? "",

      description: json["description"] ?? "",

      imageUrl: json["imageUrl"] ?? "",

      durationHours: json["durationHours"] ?? 0,

      priceInEGP: (json["priceInEGP"] ?? 0).toDouble(),

      priceOutEGP: (json["priceOutEGP"] ?? 0).toDouble(),

      offer: json["offer"] ?? 0,

      level: json["level"] ?? "",

      enrolledStudentsCount: json["enrolledStudentsCount"] ?? 0,

      isPublished: json["isPublished"] ?? false,

      introVideoUrl: json["introVideoUrl"],

      modules:
          (json["modules"] as List?)
              ?.map(
                (e) => ModuleEntity(
                  id: e["id"] ?? "",
                  title: e["title"] ?? "",
                  order: e["order"] ?? 0,
                  videos:
                      (e["videos"] as List?)
                          ?.map(
                            (v) => VideoEntity(
                              id: v["id"] ?? "",
                              title: v["title"] ?? "",
                              description: v["description"] ?? "",
                              durationSeconds: v["durationSeconds"] ?? 0,
                              order: v["order"] ?? 0,

                              videoUrl: v["videoUrl"] ?? "", // NEW
                            ),
                          )
                          .toList() ??
                      [],
                ),
              )
              .toList() ??
          [],

      certificateImages:
          (json["certificateImages"] as List?)
              ?.map(
                (e) => CertificateEntity(
                  id: e["id"] ?? "",
                  imageUrl: e["imageUrl"] ?? "",
                ),
              )
              .toList() ??
          [],

      studentsInTrainingImages:
          (json["urlStudentsInTraining"] as List?)
              ?.map(
                (e) => StudentTrainingImageEntity(
                  id: e["id"] ?? "",
                  url: e["url"] ?? "",
                  imagePublicId: e["imagePublicId"],
                ),
              )
              .toList() ??
          [],
    );
  }
}
