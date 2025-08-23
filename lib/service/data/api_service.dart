import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:preppal/consts/api_consts.dart';
import 'package:preppal/service/model/meal_areas_model.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/other_recipes_model.dart';

import '../model/meals_by_id.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConsts.mainUrl));
  final Dio _dio2 = Dio(BaseOptions(baseUrl: ApiConsts.seconderyUrl));
  final Dio _dioT = Dio();

  Future<List<MealsCat>?> CatCall() async {
    List<MealsCat> meals = [];
    final result = await _dio.get('categories.php');
    // i c a
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['categories'];
        meals = m.map((e) => MealsCat.fromJson(e)).toList();
        TranslateService('ar',meals.toString());
        print(TranslateService('ar',meals.toString()));
        var cbox = Hive.box<MealsCat>('category');
        await cbox.clear(); // Optional: clear old data
        await cbox.addAll(meals);
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }


  Future<List<MealsbyCat>?> CallByCatInsdie(String category) async {
    List<MealsbyCat> inMeals = [];
    final result = await _dio.get('filter.php?c=$category');
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        inMeals = m.map((e) => MealsbyCat.fromJson(e)).toList();
        var mbox = Hive.box<MealsbyCat>('SeaFood');
        await mbox.addAll(inMeals);
        var inbox = Hive.box<MealsbyCat>('inCat');
        await inbox.addAll(inMeals);
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return inMeals;
  }

  Future<List<MealsById>?> GetMealsById(String mealId) async {
    List<MealsById> meals = [];
    List<String> ingredient = [];
    List<String> measures = [];

    final result = await _dio.get('lookup.php?i=$mealId');

    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        meals = m.map((e) => MealsById.fromJson(e)).toList();

        for (int i = 1; i <= 20; i++) {
          final ing = result.data['meals'][0]['strIngredient$i'];
          final mes = result.data['meals'][0]['strMeasure$i'];
          if (ing != null && ing.toString().trim().isNotEmpty) {
            // ingredient.add(ing.toString().trim());
            // measures.add(mes.toString().trim());git
            ingredient.add(
              '$i━ ${ing.toString().trim()} :${mes.toString().trim()}\n',
            );
          }
        }
        meals[0].strIngredient = ingredient;
        meals[0].strMeasure = measures;

      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }

  Future<List<MealsById>?> GetRandomMeal() async {
    List<MealsById> meals = [];
    List<String> ingredient = [];
    List<String> measures = [];

    final result = await _dio.get('random.php');

    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        meals = m.map((e) => MealsById.fromJson(e)).toList();

        for (int i = 1; i <= 20; i++) {
          final ing = result.data['meals'][0]['strIngredient$i'];
          final mes = result.data['meals'][0]['strMeasure$i'];
          if (ing != null && ing.toString().trim().isNotEmpty) {
            // ingredient.add(ing.toString().trim());
            // measures.add(mes.toString().trim());
            ingredient.add(
              '$i━ ${ing.toString().trim()} :${mes.toString().trim()}\n',
            );
          }
        }
        meals[0].strIngredient = ingredient;
        meals[0].strMeasure = measures;
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }

  Future<List<OtherRecipes>?> OtherRecipesCall() async {
    List<OtherRecipes> recipes = [];
    final result = await _dio2.get(
      'recipes?size=100&page=1',
      options: Options(
        headers: {
          'x-rapidapi-key':
              '05dd5ab504mshe0b8e13b84f9856p100bb3jsnf942f962d553',
          // Your API key
          'x-rapidapi-host': 'recipe-food-nutrition16.p.rapidapi.com',
          // API host from RapidAPI
        },
      ),
    );
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data["data"];
        recipes = m.map((e) => OtherRecipes.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return recipes;
  }
  Future<void> TranslateService(String toLang,String text) async {

    final result = await _dioT.post(ApiConsts.translateUrl,
      queryParameters: {
        "from": 'en',
        "to": toLang,
        "query": text,
      },
      options: Options(
        headers: {
          'x-rapidapi-key':
          '05dd5ab504mshe0b8e13b84f9856p100bb3jsnf942f962d553',
          // Your API key
          'x-rapidapi-host': 'free-google-translator.p.rapidapi.com',
          // API host from RapidAPI
        },
      ),
    );
    try {
      if (result.statusCode == 200) {
        // List<dynamic> m = result.data["data"];
        print(result.data["translation"]);
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }


  }
}






// Future<List<MealsModel>?> ItemsCall() async {
//   List<MealsModel> meals = [];
//   final result = await _dio.get('?i=list');
//   // i c a
//   try {
//     if (result.statusCode == 200) {
//       List<dynamic> m = result.data['meals'];
//       meals = m.map((e) => MealsModel.fromJson(e)).toList();
//     }
//   } on DioException catch (e) {
//     print(e.error);
//   } catch (e) {
//     print(e);
//   }
//
//   return meals;
// }
// Future<List<MealsArea>?> ArCall() async {
//     List<MealsArea> meals = [];
//     final result = await _dio.get('?a=list');
//     // i c a
//     try {
//       if (result.statusCode == 200) {
//         List<dynamic> m = result.data['meals'];
//         meals = m.map((e) => MealsArea.fromJson(e)).toList();
//       }
//     } on DioException catch (e) {
//       print(e.error);
//     } catch (e) {
//       print(e);
//     }
//
//     return meals;
//   }
// Future<List<MealsbyCat>?> CallByCat() async {
//   List<MealsbyCat> meals = [];
//   final result = await _dio.get('filter.php?c=Seafood');
//   try {
//     if (result.statusCode == 200) {
//       List<dynamic> m = result.data['meals'];
//       meals = m.map((e) => MealsbyCat.fromJson(e)).toList();
//     }
//   } on DioException catch (e) {
//     print(e.error);
//   } catch (e) {
//     print(e);
//   }
//
//   return meals;
// }