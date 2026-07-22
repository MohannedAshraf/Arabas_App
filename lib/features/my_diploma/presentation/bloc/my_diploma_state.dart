import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_entity.dart';

abstract class MyDiplomaState {
  const MyDiplomaState();
}

class MyDiplomaInitial extends MyDiplomaState {
  const MyDiplomaInitial();
}

class MyDiplomaLoading extends MyDiplomaState {
  const MyDiplomaLoading();
}

class MyDiplomaSuccess extends MyDiplomaState {
  final List<MyDiplomaEntity> diplomas;

  const MyDiplomaSuccess(this.diplomas);
}

class MyDiplomaError extends MyDiplomaState {
  final String message;

  const MyDiplomaError(this.message);
}
