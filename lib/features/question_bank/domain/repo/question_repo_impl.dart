import 'package:arabas_app/features/question_bank/data/data_sources/question_remote_data_source.dart';
import 'package:arabas_app/features/question_bank/domain/repo/question_repo.dart';

import '../../domain/entities/question_entity.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsRemoteDataSource remoteDataSource;

  QuestionsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<QuestionEntity>> getQuestions({
    required String medicalSectionId,
    required int questionType,
  }) {
    return remoteDataSource.getQuestions(
      medicalSectionId: medicalSectionId,
      questionType: questionType,
    );
  }
}
