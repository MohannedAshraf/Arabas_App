import '../../domain/entities/my_diploma_video_entity.dart';

abstract class MyDiplomaVideoState {}

class MyDiplomaVideoInitial extends MyDiplomaVideoState {}

class MyDiplomaVideoLoading extends MyDiplomaVideoState {}

class MyDiplomaVideoSuccess extends MyDiplomaVideoState {
  final MyDiplomaVideoEntity video;

  MyDiplomaVideoSuccess(this.video);
}

class MyDiplomaVideoError extends MyDiplomaVideoState {
  final String message;

  MyDiplomaVideoError(this.message);
}
