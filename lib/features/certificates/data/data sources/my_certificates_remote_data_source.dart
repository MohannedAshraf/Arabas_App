import 'package:arabas_app/features/certificates/data/models/my_certificates_model.dart';
import 'package:dio/dio.dart';

abstract class CertificateRemoteDataSource {
  Future<List<CertificateModel>> getMyCertificates();
}

class CertificateRemoteDataSourceImpl implements CertificateRemoteDataSource {
  final Dio dio;

  CertificateRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CertificateModel>> getMyCertificates() async {
    final response = await dio.get("/Certificate/my-certificates");

    final List data = response.data["data"];

    return data.map((e) => CertificateModel.fromJson(e)).toList();
  }
}
