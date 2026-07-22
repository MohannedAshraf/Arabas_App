import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_entity.dart';

class MyDiplomaModel extends MyDiplomaEntity {
  const MyDiplomaModel({
    required super.diplomaId,
    required super.diplomaName,
    required super.diplomaImage,
    required super.daysRemaining,
    required super.progressPercent,
    required super.description,
    required super.introVideoUrl,
  });

  factory MyDiplomaModel.fromJson(Map<String, dynamic> json) {
    return MyDiplomaModel(
      diplomaId: json['diplomaId'] ?? '',
      diplomaName: json['diplomaName'] ?? '',
      diplomaImage: json['diplomaImage'] ?? '',
      daysRemaining: json['daysRemaining'] ?? 0,
      progressPercent: (json['progressPercent'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      introVideoUrl: json['introVideoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diplomaId': diplomaId,
      'diplomaName': diplomaName,
      'diplomaImage': diplomaImage,
      'daysRemaining': daysRemaining,
      'progressPercent': progressPercent,
      'description': description,
      'introVideoUrl': introVideoUrl,
    };
  }

  MyDiplomaModel copyWith({
    String? diplomaId,
    String? diplomaName,
    String? diplomaImage,
    int? daysRemaining,
    double? progressPercent,
    String? description,
    String? introVideoUrl,
  }) {
    return MyDiplomaModel(
      diplomaId: diplomaId ?? this.diplomaId,
      diplomaName: diplomaName ?? this.diplomaName,
      diplomaImage: diplomaImage ?? this.diplomaImage,
      daysRemaining: daysRemaining ?? this.daysRemaining,
      progressPercent: progressPercent ?? this.progressPercent,
      description: description ?? this.description,
      introVideoUrl: introVideoUrl ?? this.introVideoUrl,
    );
  }
}
