import 'package:arabas_app/features/practicals/domain/entity/practical_details_entity.dart';

abstract class PracticalDetailsState {}

class PracticalDetailsInitial extends PracticalDetailsState {}

class PracticalDetailsLoading extends PracticalDetailsState {}

class PracticalDetailsSuccess extends PracticalDetailsState {
  final PracticalDetailsEntity practical;

  PracticalDetailsSuccess(this.practical);
}

class PracticalDetailsError extends PracticalDetailsState {
  final String message;

  PracticalDetailsError(this.message);
}
