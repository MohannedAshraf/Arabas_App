import 'package:arabas_app/features/question_bank/domain/usecases/get_question_usecase.dart';
import 'package:arabas_app/features/question_bank/presentation/bloc/question_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final GetQuestionsUseCase getQuestionsUseCase;

  QuestionsCubit(this.getQuestionsUseCase) : super(QuestionsInitial());

  Future<void> getQuestions({
    required String medicalSectionId,
    required int questionType,
  }) async {
    emit(QuestionsLoading());

    try {
      final result = await getQuestionsUseCase(
        medicalSectionId: medicalSectionId,
        questionType: questionType,
      );

      emit(QuestionsLoaded(result));
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }
}
