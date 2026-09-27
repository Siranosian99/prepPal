import 'package:hive/hive.dart';
part 'meals_by_id.g.dart';
@HiveType(typeId: 2)
class MealsById {
  @HiveField(0)
  String? idMeal;
  @HiveField(1)
  String? strMeal;
  @HiveField(2)
  String? strMealAlternate;
  @HiveField(3)
  String? strCategory;
  @HiveField(4)
  String? strArea;
  @HiveField(5)
  String? strInstructions;
  @HiveField(6)
  String? strMealThumb;
  @HiveField(7)
  String? strTags;
  @HiveField(8)
  String? strYoutube;
  @HiveField(9)
  List<String>? strIngredient;
  @HiveField(10)
  List<String>? strMeasure;
  @HiveField(11)
  String? strSource;
  MealsById({
    this.idMeal,
    this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strIngredient,
    this.strMeasure,
    this.strSource,
  });

  MealsById.fromJson(Map<String, dynamic> json) {
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strMealAlternate = json['strMealAlternate'];
    strCategory = json['strCategory'];
    strArea = json['strArea'];
    strInstructions = json['strInstructions'];
    strMealThumb = json['strMealThumb'];
    strTags = json['strTags'];
    strYoutube = json['strYoutube'];
    strIngredient = json['strIngredient'];
    strMeasure = json['strMeasure'];
    strSource = json['strSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMeal'] = idMeal;
    data['strMeal'] = strMeal;
    data['strMealAlternate'] = strMealAlternate;
    data['strCategory'] = strCategory;
    data['strArea'] = strArea;
    data['strInstructions'] = strInstructions;
    data['strMealThumb'] = strMealThumb;
    data['strTags'] = strTags;
    data['strYoutube'] = strYoutube;
    data['strIngredient'] = strIngredient;
    data['strMeasure'] = strMeasure;
    data['strSource'] = strSource;
    return data;
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MealsById && other.idMeal == idMeal;
  }

  @override
  int get hashCode => idMeal.hashCode;
  @override
  String toString() {
    return '$idMeal,$strMeal,$strMealAlternate,$strCategory,$strArea,$strInstructions,$strMealThumb,$strTags,$strYoutube,$strIngredient,$strMeasure,$strSource';
  }
}
