import 'package:arabas_app/features/my_courses/domain/usecases/progress_in_course_usecase.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/progress_in_course_state.dart';
import 'package:bloc/bloc.dart';

class ProgressInCourseCubit extends Cubit<ProgressInCourseState> {
  final ProgressInCourseUseCase useCase;

  ProgressInCourseCubit(this.useCase) : super(ProgressInCourseInitial());

  Future<void> getProgressInCourse({required String courseId}) async {
    emit(ProgressInCourseLoading());

    try {
      final result = await useCase(courseId: courseId);

      emit(ProgressInCourseSuccess(result));
    } catch (e) {
      emit(ProgressInCourseFailure(e.toString()));
    }
  }
}
