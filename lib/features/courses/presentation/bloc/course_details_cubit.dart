import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_course_details_usecase.dart';
import 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  final GetCourseDetailsUseCase useCase;

  CourseDetailsCubit(this.useCase) : super(CourseDetailsInitial());

  Future<void> getCourseDetails(String id) async {
    emit(CourseDetailsLoading());

    try {
      final course = await useCase(id);
      emit(CourseDetailsSuccess(course));
    } catch (e, s) {
      print(e);
      print(s);

      emit(CourseDetailsError(e.toString()));
    }
  }
}
