import 'package:arabas_app/features/certificates/data/models/build_certificate_model.dart';
import 'package:dio/dio.dart';

abstract class BuildCertificateRemoteDataSource {
  Future<BuildCertificateModel> checkCertificate({required String courseId});
}

class BuildCertificateRemoteDataSourceImpl
    implements BuildCertificateRemoteDataSource {
  final Dio dio;

  BuildCertificateRemoteDataSourceImpl(this.dio);

  @override
  Future<BuildCertificateModel> checkCertificate({
    required String courseId,
  }) async {
    try {
      final response = await dio.post(
        "Certificate/Check",
        queryParameters: {"courseId": courseId},
      );

      if (response.data["isSuccess"] == true) {
        return BuildCertificateModel.fromJson(response.data);
      } else {
        throw response.data["message"] ?? "حدث خطأ";
      }
    } on DioException catch (e) {
      /// لو السيرفر رجع رسالة خطأ
      final serverMessage =
          e.response?.data?["message"] ??
          e.response?.data?["errors"]?.toString() ??
          "حدث خطأ أثناء طلب الشهادة";

      throw serverMessage;
    } catch (e) {
      throw e.toString();
    }
  }
}
