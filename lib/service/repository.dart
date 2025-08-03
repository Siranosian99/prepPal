import 'package:preppal/service/data/api_service.dart';

import 'model/meal_cat_model.dart';

class PrepPalRepository {
  final ApiService apiService;

  PrepPalRepository({required this.apiService});

  Future<List<MealsCat>?> CatCall() async {
    List<MealsCat> meals = [];
    final data = await apiService.CatCall();

  }
}
