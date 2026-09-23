import 'package:preppal/service/data/api_service.dart';
import 'package:preppal/service/model/ai_recipes_model.dart';
import 'package:preppal/service/model/food_fact_model.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/meals_by_id.dart';
import 'package:preppal/service/model/other_recipes_model.dart';

class PrepPalRepository {
  final ApiService apiService;

  PrepPalRepository({required this.apiService});

  Future<List<MealsCat>?> CatCall() async {
    return await apiService.CatCall();
  }

  Future<List<MealsbyCat>?> InsideCat(String category) async {
    return await apiService.CallByCatInsdie(category);
  }

  Future<List<MealsById>?> MealbyId(String category) async {
    return await apiService.GetMealsById(category);
  }

  Future<List<MealsById>?> RandomMeal() async {
    return await apiService.GetRandomMeal();
  }
  Future<List<OtherRecipes>?> OtherRecipesCall() async {
    return await apiService.OtherRecipesCall();
  }
  Future<List<AiRecipeModel>?> AiRecipesGet(String query) async {
    return await apiService.AiRecipesGet(query);
  }
  Future<List<NutritionProduct>?> FoodFactsGet(String query) async {
    return await apiService.FoodFactsGet(query);
  }
  // Future<String> TranslateService(String toLang,String text) async {
  //   return await apiService.TranslateService(toLang, text);
  // }
  // List<MealsById> addFavouriteList(MealsById meal){
  //   List<MealsById>meals=[];
  //   meals.add(meal);
  //   return  meals;
  // }

}
