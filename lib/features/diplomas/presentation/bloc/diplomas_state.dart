import 'package:arabas_app/features/diplomas/domain/entities/diplomas_entity.dart';

abstract class DiplomaState {}

class DiplomaInitial extends DiplomaState {}

class DiplomaLoading extends DiplomaState {}

class DiplomaLoaded extends DiplomaState {
  final List<DiplomaEntity> diplomas;

  DiplomaLoaded(this.diplomas);
}

class DiplomaError extends DiplomaState {
  final String message;

  DiplomaError(this.message);
}
