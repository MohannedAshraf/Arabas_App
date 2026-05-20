import '../../data/data_source/verify_book_remote_data_source.dart';
import 'verify_book_repo.dart';

class VerifyBookRepoImpl implements VerifyBookRepo {
  final VerifyBookRemoteDataSource remoteDataSource;

  VerifyBookRepoImpl(this.remoteDataSource);

  @override
  Future<bool> verifyBook(String code) async {
    return await remoteDataSource.verifyBook(code);
  }
}
