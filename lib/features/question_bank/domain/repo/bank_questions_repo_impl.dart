import 'package:arabas_app/features/question_bank/data/data_sources/bank_questions_remote_data_source.dart';
import 'package:arabas_app/features/question_bank/data/models/bank_questions_model.dart';
import 'package:arabas_app/features/question_bank/domain/entities/bank_questions_entity.dart';
import 'package:arabas_app/features/question_bank/domain/repo/bank_questions_repo.dart';

class BankQuestionsRepositoryImpl implements BankQuestionsRepository {
  final BankQuestionsRemoteDataSource remoteDataSource;

  BankQuestionsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<BankQuestionEntity>> getSections() async {
    final data = await remoteDataSource.getSections();

    return data.map((e) => BankQuestionModel.fromJson(e)).toList();
  }
}
