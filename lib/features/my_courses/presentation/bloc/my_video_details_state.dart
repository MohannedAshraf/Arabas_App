import 'package:arabas_app/features/my_courses/domain/entity/my_video_details_entity.dart';

abstract class MyVideoDetailsState {}

class MyVideoDetailsInitial extends MyVideoDetailsState {}

class MyVideoDetailsLoading extends MyVideoDetailsState {}

class MyVideoDetailsSuccess extends MyVideoDetailsState {
  final MyVideoDetailsEntity video;

  MyVideoDetailsSuccess(this.video);
}

class MyVideoDetailsError extends MyVideoDetailsState {
  final String message;

  MyVideoDetailsError(this.message);
}
