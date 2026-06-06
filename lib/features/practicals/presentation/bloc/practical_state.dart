import 'package:arabas_app/features/practicals/domain/entity/practical_entity.dart';

abstract class PracticalState {}

class PracticalInitial extends PracticalState {}

class PracticalLoading extends PracticalState {}

class PracticalSuccess extends PracticalState {
  final List<PracticalEntity> practicals;

  PracticalSuccess(this.practicals);
}

class PracticalError extends PracticalState {
  final String message;

  PracticalError(this.message);
}
