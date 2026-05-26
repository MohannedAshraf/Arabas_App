import 'package:arabas_app/features/certificates/domain/usecases/get_my_certificates_usecase.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/my_certificates_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CertificateCubit extends Cubit<CertificateState> {
  final GetMyCertificatesUseCase useCase;

  CertificateCubit(this.useCase) : super(CertificateInitial());

  Future<void> getCertificates() async {
    emit(CertificateLoading());

    try {
      final result = await useCase();
      emit(CertificateSuccess(result));
    } catch (e) {
      emit(CertificateError(e.toString()));
    }
  }
}
