import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_bank_questions_usecase.dart';
import 'bank_questions_state.dart';

class BankQuestionsCubit extends Cubit<BankQuestionsState> {
  final GetBankQuestionsUseCase getBankQuestionsUseCase;

  BankQuestionsCubit(this.getBankQuestionsUseCase)
    : super(BankQuestionsInitial());

  Future<void> getSections() async {
    emit(BankQuestionsLoading());

    try {
      final sections = await getBankQuestionsUseCase();

      emit(BankQuestionsSuccess(sections));
    } catch (e) {
      emit(BankQuestionsError(e.toString()));
    }
  }
}
