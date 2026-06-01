import 'package:arabas_app/features/diplomas/domain/entities/diploma_details_entity.dart';

abstract class DiplomaDetailsState {}

class DiplomaDetailsInitial extends DiplomaDetailsState {}

class DiplomaDetailsLoading extends DiplomaDetailsState {}

class DiplomaDetailsLoaded extends DiplomaDetailsState {
  final DiplomaDetailsEntity diploma;

  DiplomaDetailsLoaded(this.diploma);
}

class DiplomaDetailsError extends DiplomaDetailsState {
  final String message;

  DiplomaDetailsError(this.message);
}
