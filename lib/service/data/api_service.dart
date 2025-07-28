import 'package:dio/dio.dart';
import 'package:preppal/service/data/api_consts.dart';
import 'package:preppal/service/model/meal_areas_model.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meal_items_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';

import '../../screens/inside_cat.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConsts.url));

  Future<List<MealsModel>?> ItemsCall() async {
    List<MealsModel> meals = [];
    final result = await _dio.get('?i=list');
    // i c a
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        meals = m.map((e) => MealsModel.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }

  Future<List<MealsCat>?> CatCall() async {
    List<MealsCat> meals = [];
    final result = await _dio.get('categories.php');
    // i c a
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['categories'];
        meals = m.map((e) => MealsCat.fromJson(e)).toList();
        print("This IS MMM:$meals");
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }

  Future<List<MealsArea>?> ArCall() async {
    List<MealsArea> meals = [];
    final result = await _dio.get('?a=list');
    // i c a
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        meals = m.map((e) => MealsArea.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }

  Future<List<MealsbyCat>?> CallByCat() async {
    List<MealsbyCat> meals = [];
    final result = await _dio.get('filter.php?c=Seafood');
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        meals = m.map((e) => MealsbyCat.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }

  Future<List<MealsbyCat>?> CallByCatInsdie(String category) async {
    List<MealsbyCat> meals = [];
    final result = await _dio.get('filter.php?c=$category');
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        meals = m.map((e) => MealsbyCat.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }

  Future<List<MealsById>?> MealsById(String mealId) async {
    List<MealsById> meals = [];
    final result = await _dio.get('filter.php?c=$category');
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        meals = m.map((e) => MealsbyCat.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }
}
