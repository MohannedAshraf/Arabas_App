import '../../domain/entities/question_entity.dart';

abstract class QuestionsState {}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final List<QuestionEntity> questions;

  QuestionsLoaded(this.questions);
}

class QuestionsError extends QuestionsState {
  final String message;

  QuestionsError(this.message);
}
