import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_details_entity.dart';

abstract class MyDiplomaDetailsState {
  const MyDiplomaDetailsState();
}

class MyDiplomaDetailsInitial extends MyDiplomaDetailsState {
  const MyDiplomaDetailsInitial();
}

class MyDiplomaDetailsLoading extends MyDiplomaDetailsState {
  const MyDiplomaDetailsLoading();
}

class MyDiplomaDetailsSuccess extends MyDiplomaDetailsState {
  final MyDiplomaDetailsEntity diploma;

  const MyDiplomaDetailsSuccess(this.diploma);
}

class MyDiplomaDetailsError extends MyDiplomaDetailsState {
  final String message;

  const MyDiplomaDetailsError(this.message);
}
