import '../../domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  QuestionModel({
    required super.id,
    required super.questionText,
    required super.medicalSectionId,
    required super.questionType,
    required super.difficultyLevel,
    required super.createdAt,
    super.mcqOptions,
    super.essayAnswerText,
    super.isTrue,
    super.matchingPairs,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      questionText: json['questionText'],
      medicalSectionId: json['medicalSectionId'],
      questionType: json['questionType'],
      difficultyLevel: json['difficultyLevel'],
      createdAt: json['createdAt'],

      mcqOptions:
          json['mcqOptions'] != null
              ? (json['mcqOptions'] as List)
                  .map((e) => McqOptionModel.fromJson(e))
                  .toList()
              : null,

      essayAnswerText: json['essayAnswerText'],
      isTrue: json['isTrue'],

      matchingPairs:
          json['matchingPairs'] != null
              ? (json['matchingPairs'] as List)
                  .map((e) => MatchingPairModel.fromJson(e))
                  .toList()
              : null,
    );
  }
}

class McqOptionModel extends McqOptionEntity {
  McqOptionModel({
    required super.id,
    required super.optionText,
    required super.isCorrect,
  });

  factory McqOptionModel.fromJson(Map<String, dynamic> json) {
    return McqOptionModel(
      id: json['id'],
      optionText: json['optionText'],
      isCorrect: json['isCorrect'],
    );
  }
}

class MatchingPairModel extends MatchingPairEntity {
  MatchingPairModel({
    required super.id,
    required super.leftItem,
    required super.rightItem,
  });

  factory MatchingPairModel.fromJson(Map<String, dynamic> json) {
    return MatchingPairModel(
      id: json['id'],
      leftItem: json['leftItem'],
      rightItem: json['rightItem'],
    );
  }
}
