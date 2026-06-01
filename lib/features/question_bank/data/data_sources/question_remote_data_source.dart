import 'package:dio/dio.dart';

import '../models/question_model.dart';

abstract class QuestionsRemoteDataSource {
  Future<List<QuestionModel>> getQuestions({
    required String medicalSectionId,
    required int questionType,
  });
}

class QuestionsRemoteDataSourceImpl implements QuestionsRemoteDataSource {
  final Dio dio;

  QuestionsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<QuestionModel>> getQuestions({
    required String medicalSectionId,
    required int questionType,
  }) async {
    final response = await dio.get(
      'BankQuestion/GetQuestionsByType/$questionType',
      queryParameters: {
        "pageNumber": 1,
        "pageSize": 10,
        "medicalSectionId": medicalSectionId,
      },
    );

    final List data = response.data["data"]["data"];

    return data.map((e) => QuestionModel.fromJson(e)).toList();
  }
}
