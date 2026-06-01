import 'package:arabas_app/features/question_bank/domain/entities/bank_questions_entity.dart';

class BankQuestionModel extends BankQuestionEntity {
  const BankQuestionModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
  });

  factory BankQuestionModel.fromJson(Map<String, dynamic> json) {
    return BankQuestionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
