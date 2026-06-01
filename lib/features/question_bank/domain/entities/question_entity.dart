class QuestionEntity {
  final String id;
  final String questionText;
  final String medicalSectionId;
  final int questionType;
  final int difficultyLevel;
  final String createdAt;

  final List<McqOptionEntity>? mcqOptions;
  final String? essayAnswerText;
  final bool? isTrue;
  final List<MatchingPairEntity>? matchingPairs;

  QuestionEntity({
    required this.id,
    required this.questionText,
    required this.medicalSectionId,
    required this.questionType,
    required this.difficultyLevel,
    required this.createdAt,
    this.mcqOptions,
    this.essayAnswerText,
    this.isTrue,
    this.matchingPairs,
  });
}

class McqOptionEntity {
  final String id;
  final String optionText;
  final bool isCorrect;

  McqOptionEntity({
    required this.id,
    required this.optionText,
    required this.isCorrect,
  });
}

class MatchingPairEntity {
  final String id;
  final String leftItem;
  final String rightItem;

  MatchingPairEntity({
    required this.id,
    required this.leftItem,
    required this.rightItem,
  });
}
