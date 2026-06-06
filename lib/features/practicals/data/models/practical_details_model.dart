import 'package:arabas_app/features/practicals/domain/entity/practical_details_entity.dart';

class PracticalDetailsModel extends PracticalDetailsEntity {
  PracticalDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.certificateUrl,
    required super.createdAt,
    required super.students,
  });

  factory PracticalDetailsModel.fromJson(Map<String, dynamic> json) {
    return PracticalDetailsModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["urlImgOut"] ?? "",
      certificateUrl: json["urlCertificate"] ?? "",
      createdAt: json["createAt"] ?? "",
      students:
          (json["urlStudents"] as List)
              .map((e) => StudentImageModel.fromJson(e))
              .toList(),
    );
  }
}

class StudentImageModel extends StudentImageEntity {
  StudentImageModel({required super.id, required super.imageUrl});

  factory StudentImageModel.fromJson(Map<String, dynamic> json) {
    return StudentImageModel(id: json["id"] ?? "", imageUrl: json["url"] ?? "");
  }
}
