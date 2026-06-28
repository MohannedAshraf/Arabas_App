import 'package:arabas_app/features/practicals/domain/entity/practical_details_entity.dart';

class PracticalDetailsModel extends PracticalDetailsEntity {
  PracticalDetailsModel({
    required super.id,
    required super.title,
    required super.durationInHours,
    required super.studentsCount,
    required super.description,
    required super.imageUrl,
    required super.imagePublicId,
    required super.createdAt,
    required super.certificateUrl,
    required super.certificatePublicId,
    required super.students,
  });

  factory PracticalDetailsModel.fromJson(Map<String, dynamic> json) {
    return PracticalDetailsModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      durationInHours: json["durationInHours"] ?? 0,
      studentsCount: json["studentsCount"] ?? 0,
      description: json["description"] ?? "",
      imageUrl: json["urlImgOut"] ?? "",
      imagePublicId: json["imagePublicId"] ?? "",
      createdAt: json["createAt"] ?? "",
      certificateUrl: json["urlCertificate"] ?? "",
      certificatePublicId: json["certificatePublicId"] ?? "",
      students:
          (json["urlStudents"] as List? ?? [])
              .map((e) => StudentImageModel.fromJson(e))
              .toList(),
    );
  }
}

class StudentImageModel extends StudentImageEntity {
  StudentImageModel({
    required super.id,
    required super.imageUrl,
    required super.imagePublicId,
  });

  factory StudentImageModel.fromJson(Map<String, dynamic> json) {
    return StudentImageModel(
      id: json["id"] ?? "",
      imageUrl: json["url"] ?? "",
      imagePublicId: json["imagePublicId"] ?? "",
    );
  }
}
