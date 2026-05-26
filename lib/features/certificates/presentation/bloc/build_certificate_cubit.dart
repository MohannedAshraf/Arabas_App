import 'package:arabas_app/features/certificates/domain/usecases/build_certificate_usecase.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/build_certificate_state.dart';
import 'package:bloc/bloc.dart';

class BuildCertificateCubit extends Cubit<BuildCertificateState> {
  final BuildCertificateUseCase checkCertificateUseCase;

  BuildCertificateCubit(this.checkCertificateUseCase)
    : super(BuildCertificateInitial());

  Future<void> checkCertificate({required String courseId}) async {
    emit(BuildCertificateLoading());

    try {
      final result = await checkCertificateUseCase(courseId: courseId);

      emit(BuildCertificateSuccess(result));
    } catch (e) {
      emit(BuildCertificateError(e.toString().replaceAll("Exception: ", "")));
    }
  }
}
