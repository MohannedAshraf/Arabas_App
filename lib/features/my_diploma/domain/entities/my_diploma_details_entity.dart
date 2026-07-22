import 'package:equatable/equatable.dart';

class MyDiplomaDetailsEntity extends Equatable {
  final String diplomaId;
  final String diplomaName;
  final String diplomaImage;
  final int daysRemaining;
  final double progressPercent;
  final String description;
  final String introVideoUrl;
  final List<MyDiplomaDetailsModuleEntity> modules;

  const MyDiplomaDetailsEntity({
    required this.diplomaId,
    required this.diplomaName,
    required this.diplomaImage,
    required this.daysRemaining,
    required this.progressPercent,
    required this.description,
    required this.introVideoUrl,
    required this.modules,
  });

  @override
  List<Object?> get props => [
    diplomaId,
    diplomaName,
    diplomaImage,
    daysRemaining,
    progressPercent,
    description,
    introVideoUrl,
    modules,
  ];
}

class MyDiplomaDetailsModuleEntity extends Equatable {
  final String id;
  final String title;
  final int order;
  final int videosCount;
  final int examsCount;
  final List<MyDiplomaDetailsExamEntity> exams;
  final List<MyDiplomaDetailsVideoEntity> videos;

  const MyDiplomaDetailsModuleEntity({
    required this.id,
    required this.title,
    required this.order,
    required this.videosCount,
    required this.examsCount,
    required this.exams,
    required this.videos,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    order,
    videosCount,
    examsCount,
    exams,
    videos,
  ];
}

class MyDiplomaDetailsVideoEntity extends Equatable {
  final String id;
  final String title;
  final int order;
  final int durationSeconds;
  final int filesCount;
  final int quizzesCount;
  final double watchPercent;
  final bool isCompleted;
  final int totalWatchSeconds;

  const MyDiplomaDetailsVideoEntity({
    required this.id,
    required this.title,
    required this.order,
    required this.durationSeconds,
    required this.filesCount,
    required this.quizzesCount,
    required this.watchPercent,
    required this.isCompleted,
    required this.totalWatchSeconds,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    order,
    durationSeconds,
    filesCount,
    quizzesCount,
    watchPercent,
    isCompleted,
    totalWatchSeconds,
  ];
}

class MyDiplomaDetailsExamEntity extends Equatable {
  final String id;
  final String title;
  final bool isFinal;
  final int durationInMinutes;

  const MyDiplomaDetailsExamEntity({
    required this.id,
    required this.title,
    required this.isFinal,
    required this.durationInMinutes,
  });

  @override
  List<Object?> get props => [id, title, isFinal, durationInMinutes];
}
