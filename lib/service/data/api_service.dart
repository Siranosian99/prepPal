import 'package:dio/dio.dart';
import 'package:preppal/service/data/api_consts.dart';
import 'package:preppal/service/model/meal_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConsts.url));

  Future<List<MealsModel>?> ItemsCall(String d) async {
    List<MealsModel> meals = [];
    final result = await _dio.get('?$d=list');
    // i c a
    try {
      if (result.statusCode == 200) {
        List<dynamic> m=result.data['meals'];
        meals=m.map((e)=>MealsModel.fromJson(e)).toList();
      }
    }
    on DioException catch (e) {
      print(e.error);
    }
    catch (e) {
      print(e);
    }

    return meals;
  }


}