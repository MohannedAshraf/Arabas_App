import '../repo/verify_book_repo.dart';

class VerifyBookUseCase {
  final VerifyBookRepo repository;

  VerifyBookUseCase(this.repository);

  Future<bool> call(String code) async {
    return await repository.verifyBook(code);
  }
}
