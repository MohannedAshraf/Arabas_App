import 'package:dio/dio.dart';

abstract class BankQuestionsRemoteDataSource {
  Future<List<Map<String, dynamic>>> getSections();
}

class BankQuestionsRemoteDataSourceImpl
    implements BankQuestionsRemoteDataSource {
  final Dio dio;

  BankQuestionsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Map<String, dynamic>>> getSections() async {
    final response = await dio.get("/MedicalSection/GetMedicalSection");

    return List<Map<String, dynamic>>.from(response.data['data']);
  }
}
