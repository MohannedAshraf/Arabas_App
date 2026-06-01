import '../entities/question_entity.dart';

abstract class QuestionsRepository {
  Future<List<QuestionEntity>> getQuestions({
    required String medicalSectionId,
    required int questionType,
  });
}
