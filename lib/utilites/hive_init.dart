import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/meals_by_id.dart';

import '../service/model/meal_cat_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MealsbyCatAdapter());
  Hive.registerAdapter(MealsCatAdapter());
  Hive.registerAdapter(MealsByIdAdapter());

  await Hive.openBox('themes');
  await Hive.openBox<MealsCat>('category');
  await Hive.openBox<MealsById>('byId');
  await Hive.openBox<MealsbyCat>('SeaFood');

}
