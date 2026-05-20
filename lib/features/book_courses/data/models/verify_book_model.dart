import 'package:arabas_app/features/book_courses/domain/entity/verify_book_entity.dart';

class VerifyBookModel extends VerifyBookEntity {
  VerifyBookModel({
    required super.isSuccess,
    required super.message,
    required super.data,
  });

  factory VerifyBookModel.fromJson(Map<String, dynamic> json) {
    return VerifyBookModel(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? false,
    );
  }
}
