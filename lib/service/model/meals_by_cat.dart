import 'package:hive_flutter/adapters.dart';
part 'meals_by_cat.g.dart';

@HiveType(typeId:1)
class MealsbyCat {
  @HiveField(0)
  String? strMeal;
  @HiveField(1)
  String? strMealThumb;
  @HiveField(2)
  String? idMeal;

  MealsbyCat({this.strMeal, this.strMealThumb, this.idMeal});

  MealsbyCat.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strMeal'] = strMeal;
    data['strMealThumb'] = strMealThumb;
    data['idMeal'] = idMeal;
    return data;
  }
  @override
  String toString(){
    return '$strMeal,$strMealThumb,$idMeal';
  }
}
