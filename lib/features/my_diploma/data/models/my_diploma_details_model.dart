import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_details_entity.dart';

class MyDiplomaDetailsModel extends MyDiplomaDetailsEntity {
  const MyDiplomaDetailsModel({
    required super.diplomaId,
    required super.diplomaName,
    required super.diplomaImage,
    required super.daysRemaining,
    required super.progressPercent,
    required super.description,
    required super.introVideoUrl,
    required super.modules,
  });

  factory MyDiplomaDetailsModel.fromJson(Map<String, dynamic> json) {
    return MyDiplomaDetailsModel(
      diplomaId: json['diplomaId'] ?? '',
      diplomaName: json['diplomaName'] ?? '',
      diplomaImage: json['diplomaImage'] ?? '',
      daysRemaining: json['daysRemaining'] ?? 0,
      progressPercent: (json['progressPercent'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      introVideoUrl: json['introVideoUrl'] ?? '',
      modules:
          (json['modules'] as List? ?? [])
              .map((e) => MyDiplomaDetailsModuleModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "diplomaId": diplomaId,
      "diplomaName": diplomaName,
      "diplomaImage": diplomaImage,
      "daysRemaining": daysRemaining,
      "progressPercent": progressPercent,
      "description": description,
      "introVideoUrl": introVideoUrl,
      "modules":
          modules
              .map((e) => (e as MyDiplomaDetailsModuleModel).toJson())
              .toList(),
    };
  }
}

class MyDiplomaDetailsModuleModel extends MyDiplomaDetailsModuleEntity {
  const MyDiplomaDetailsModuleModel({
    required super.id,
    required super.title,
    required super.order,
    required super.videosCount,
    required super.examsCount,
    required super.exams,
    required super.videos,
  });

  factory MyDiplomaDetailsModuleModel.fromJson(Map<String, dynamic> json) {
    return MyDiplomaDetailsModuleModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      order: json['order'] ?? 0,
      videosCount: json['videosCount'] ?? 0,
      examsCount: json['examsCount'] ?? 0,
      exams:
          (json['exams'] as List? ?? [])
              .map((e) => MyDiplomaDetailsExamModel.fromJson(e))
              .toList(),
      videos:
          (json['videos'] as List? ?? [])
              .map((e) => MyDiplomaDetailsVideoModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "order": order,
      "videosCount": videosCount,
      "examsCount": examsCount,
      "videos":
          videos
              .map((e) => (e as MyDiplomaDetailsVideoModel).toJson())
              .toList(),
      "exams":
          exams.map((e) => (e as MyDiplomaDetailsExamModel).toJson()).toList(),
    };
  }
}

class MyDiplomaDetailsVideoModel extends MyDiplomaDetailsVideoEntity {
  const MyDiplomaDetailsVideoModel({
    required super.id,
    required super.title,
    required super.order,
    required super.durationSeconds,
    required super.filesCount,
    required super.quizzesCount,
    required super.watchPercent,
    required super.isCompleted,
    required super.totalWatchSeconds,
  });

  factory MyDiplomaDetailsVideoModel.fromJson(Map<String, dynamic> json) {
    return MyDiplomaDetailsVideoModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      order: json['order'] ?? 0,
      durationSeconds: json['durationSeconds'] ?? 0,
      filesCount: json['filesCount'] ?? 0,
      quizzesCount: json['quizzesCount'] ?? 0,
      watchPercent: (json['watchPercent'] ?? 0).toDouble(),
      isCompleted: json['isCompleted'] ?? false,
      totalWatchSeconds: json['totalWatchSeconds'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "order": order,
      "durationSeconds": durationSeconds,
      "filesCount": filesCount,
      "quizzesCount": quizzesCount,
      "watchPercent": watchPercent,
      "isCompleted": isCompleted,
      "totalWatchSeconds": totalWatchSeconds,
    };
  }
}

class MyDiplomaDetailsExamModel extends MyDiplomaDetailsExamEntity {
  const MyDiplomaDetailsExamModel({
    required super.id,
    required super.title,
    required super.isFinal,
    required super.durationInMinutes,
  });

  factory MyDiplomaDetailsExamModel.fromJson(Map<String, dynamic> json) {
    return MyDiplomaDetailsExamModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      isFinal: json['isFinal'] ?? false,
      durationInMinutes: json['durationInMinutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "isFinal": isFinal,
      "durationInMinutes": durationInMinutes,
    };
  }
}
