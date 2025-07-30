import 'package:dio/dio.dart';
import 'package:preppal/service/data/api_consts.dart';
import 'package:preppal/service/model/meal_areas_model.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meal_items_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';


import '../model/meals_by_id.dart';

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

  Future<List<MealsById>?> GetMeasById(int id,String mealId) async {
    List<MealsById> meals = [];
    final result = await _dio.get('filter.php?c=$mealId');
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        meals = m.map((e) => MealsById.fromJson(e)).toList();
        for(int i=1;i<=20;i++){
          if(result.data['meals']["strIngredient$i"] != null){
            meals[id].strIngredient?.add(result.data['meals']["strIngredient$i"]);
            print(meals[id].strIngredient);
          }
        }
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }
}
// Future<List<MealsById>?> GetMeasById(String mealId) async {
//     List<MealsById> meals = [];
//     List<String> Ingredient = [];
//     List<String> Measure = [];
//
//     try {
//       final result = await _dio.get('search.php?s=$mealId');
//
//       if (result.statusCode == 200) {
//         List<dynamic> m = result.data['meals'];
//         meals = m.map((e) => MealsById.fromJson(e)).toList();
//
//         final meal = result.data['meals'];
//
//         for (int i = 1; i <= 20; i++) {
//           final ingredient = meal["strIngredient$i"];
//           if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
//             Ingredient.add(ingredient.toString());
//           }
//           final measure = meal["strMeasure$i"];
//           if (measure != null && measure.toString().trim().isNotEmpty) {
//             Measure.add(measure.toString());
//           }
//         }
//         print("Ingredients: $Ingredient");
//         print("Measures: $Measure");
//       }
//     } on DioException catch (e) {
//       print(e.error);
//     } catch (e) {
//       print("printing the Error:$e");
//     }
//
//     return meals;
//   }