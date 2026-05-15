import 'package:arabas_app/features/free_lectures/domain/entities/video_details_entity.dart';

abstract class VideoPlayerState {}

class VideoInitial extends VideoPlayerState {}

class VideoLoading extends VideoPlayerState {}

class VideoLoaded extends VideoPlayerState {
  final VideoEntity video;
  VideoLoaded(this.video);
}

class VideoError extends VideoPlayerState {
  final String message;
  VideoError(this.message);
}
