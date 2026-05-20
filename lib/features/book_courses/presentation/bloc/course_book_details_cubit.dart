import 'package:arabas_app/features/book_courses/domain/usecases/get_course_book_details_usecase.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/course_book_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBookDetailsCubit extends Cubit<CourseBookDetailsState> {
  final GetCourseBookDetailsUseCase useCase;

  CourseBookDetailsCubit(this.useCase) : super(DetailsInitial());

  Future<void> getDetails(String id) async {
    emit(DetailsLoading());
    try {
      final data = await useCase(id);
      emit(DetailsLoaded(data, 0));
    } catch (e) {
      emit(DetailsError(e.toString()));
    }
  }

  void changeVideo(int index) {
    final current = state as DetailsLoaded;
    emit(DetailsLoaded(current.data, index));
  }
}
