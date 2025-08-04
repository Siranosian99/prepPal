import 'package:preppal/service/data/api_service.dart';
import 'package:preppal/service/model/meals_by_cat.dart';

import 'model/meal_cat_model.dart';

class PrepPalRepository {
  final ApiService apiService;

  PrepPalRepository({required this.apiService});

  Future<List<MealsCat>?> CatCall() async {
    return await apiService.CatCall();
  }
  Future<List<MealsbyCat>?> InsideCat(String category) async {
    return await apiService.CallByCatInsdie(category);
  }
}
