import 'package:arabas_app/features/question_bank/domain/entities/bank_questions_entity.dart';

abstract class BankQuestionsState {}

class BankQuestionsInitial extends BankQuestionsState {}

class BankQuestionsLoading extends BankQuestionsState {}

class BankQuestionsSuccess extends BankQuestionsState {
  final List<BankQuestionEntity> sections;

  BankQuestionsSuccess(this.sections);
}

class BankQuestionsError extends BankQuestionsState {
  final String message;

  BankQuestionsError(this.message);
}
