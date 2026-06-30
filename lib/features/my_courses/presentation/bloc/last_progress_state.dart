import '../../domain/entity/last_progress_entity.dart';

abstract class LastProgressState {}

class LastProgressInitial extends LastProgressState {}

class LastProgressLoading extends LastProgressState {}

class LastProgressLoaded extends LastProgressState {
  final List<LastProgressEntity> progress;

  LastProgressLoaded(this.progress);
}

class LastProgressError extends LastProgressState {
  final String message;

  LastProgressError(this.message);
}
