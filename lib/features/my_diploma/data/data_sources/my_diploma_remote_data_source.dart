import 'package:arabas_app/core/network/dio_helper.dart';
import 'package:arabas_app/features/my_diploma/data/models/my_diploma_model.dart';

abstract class MyDiplomaRemoteDataSource {
  Future<List<MyDiplomaModel>> getMyDiplomas({required bool activeOnly});
}

class MyDiplomaRemoteDataSourceImpl implements MyDiplomaRemoteDataSource {
  @override
  Future<List<MyDiplomaModel>> getMyDiplomas({required bool activeOnly}) async {
    final response = await DioHelper.createDio().get(
      'MyDiplomaEnrollments/my-diplomas',
      queryParameters: {'activeOnly': activeOnly},
    );

    final List data = response.data['data'];

    return data.map((e) => MyDiplomaModel.fromJson(e)).toList();
  }
}
