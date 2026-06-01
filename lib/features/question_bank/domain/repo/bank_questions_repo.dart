import 'package:arabas_app/features/question_bank/domain/entities/bank_questions_entity.dart';

abstract class BankQuestionsRepository {
  Future<List<BankQuestionEntity>> getSections();
}
