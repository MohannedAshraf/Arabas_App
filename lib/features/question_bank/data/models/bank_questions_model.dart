import 'package:arabas_app/features/question_bank/domain/entities/bank_questions_entity.dart';

class BankQuestionModel extends BankQuestionEntity {
  const BankQuestionModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory BankQuestionModel.fromJson(Map<String, dynamic> json) {
    return BankQuestionModel(
      id: json['id'] ?? '',
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
    );
  }
}
