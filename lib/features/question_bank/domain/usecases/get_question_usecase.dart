import 'package:arabas_app/features/question_bank/domain/repo/question_repo.dart';

import '../entities/question_entity.dart';

class GetQuestionsUseCase {
  final QuestionsRepository repository;

  GetQuestionsUseCase(this.repository);

  Future<List<QuestionEntity>> call({
    required String medicalSectionId,
    required int questionType,
  }) {
    return repository.getQuestions(
      medicalSectionId: medicalSectionId,
      questionType: questionType,
    );
  }
}
