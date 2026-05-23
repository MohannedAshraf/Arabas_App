import 'package:arabas_app/features/my_courses/domain/usecases/get_my_course_details_usecase.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_course_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCourseDetailsCubit extends Cubit<MyCourseDetailsState> {
  final GetMyCourseDetailsUsecase useCase;

  MyCourseDetailsCubit(this.useCase) : super(MyCourseDetailsInitial());

  Future<void> getCourseDetails(String courseId) async {
    emit(MyCourseDetailsLoading());

    try {
      final result = await useCase(courseId);

      emit(MyCourseDetailsSuccess(result));
    } catch (e) {
      emit(MyCourseDetailsError(e.toString()));
    }
  }
}
