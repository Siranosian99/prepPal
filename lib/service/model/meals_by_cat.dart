class MealsbyCat {
  String? strMeal;
  String? strMealThumb;
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
