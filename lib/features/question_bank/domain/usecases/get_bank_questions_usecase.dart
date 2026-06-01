import 'package:arabas_app/features/question_bank/domain/entities/bank_questions_entity.dart';
import 'package:arabas_app/features/question_bank/domain/repo/bank_questions_repo.dart';

class GetBankQuestionsUseCase {
  final BankQuestionsRepository repository;

  GetBankQuestionsUseCase(this.repository);

  Future<List<BankQuestionEntity>> call() async {
    return await repository.getSections();
  }
}
