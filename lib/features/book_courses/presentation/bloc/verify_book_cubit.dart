import 'package:bloc/bloc.dart';
import '../../domain/usecases/verify_book_usecase.dart';

part 'verify_book_state.dart';

class VerifyBookCubit extends Cubit<VerifyBookState> {
  final VerifyBookUseCase verifyBookUseCase;

  VerifyBookCubit(this.verifyBookUseCase) : super(VerifyBookInitial());

  Future<void> verifyBook(String code) async {
    emit(VerifyBookLoading());

    try {
      final result = await verifyBookUseCase(code);

      if (result) {
        emit(VerifyBookSuccess());
      } else {
        emit(VerifyBookError('الكود غير صحيح'));
      }
    } catch (e) {
      emit(VerifyBookError(e.toString()));
    }
  }
}
