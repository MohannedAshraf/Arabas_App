import 'package:arabas_app/core/network/dio_helper.dart';
import 'package:arabas_app/features/my_diploma/data/models/my_diploma_details_model.dart';

abstract class MyDiplomaDetailsRemoteDataSource {
  Future<MyDiplomaDetailsModel> getDiplomaDetails({required String diplomaId});
}

class MyDiplomaDetailsRemoteDataSourceImpl
    implements MyDiplomaDetailsRemoteDataSource {
  @override
  Future<MyDiplomaDetailsModel> getDiplomaDetails({
    required String diplomaId,
  }) async {
    final response = await DioHelper.createDio().get(
      "MyDiplomaEnrollments/my-diplomas/$diplomaId",
    );

    return MyDiplomaDetailsModel.fromJson(response.data["data"]);
  }
}
