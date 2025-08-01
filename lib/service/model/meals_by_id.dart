class MealsById {
  String? idMeal;
  String? strMeal;
  String? strMealAlternate;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strMealThumb;
  String? strTags;
  String? strYoutube;
  List<String>? strIngredient;
  List<String>? strMeasure;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idMeal'] = this.idMeal;
    data['strMeal'] = this.strMeal;
    data['strMealAlternate'] = this.strMealAlternate;
    data['strCategory'] = this.strCategory;
    data['strArea'] = this.strArea;
    data['strInstructions'] = this.strInstructions;
    data['strMealThumb'] = this.strMealThumb;
    data['strTags'] = this.strTags;
    data['strYoutube'] = this.strYoutube;
    data['strIngredient'] = this.strIngredient;
    data['strMeasure'] = this.strMeasure;
    data['strSource'] = this.strSource;
    return data;
  }

  @override
  String toString() {
    return '$idMeal,$strMeal,$strMealAlternate,$strCategory,$strArea,$strInstructions,$strMealThumb,$strTags,$strYoutube,$strIngredient,$strMeasure,$strSource';
  }
}
