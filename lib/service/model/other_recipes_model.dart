class OtherRecipes {
  String? id;
  String? recipeId;
  String? name;
  String? cookTime;
  String? prepTime;
  String? totalTime;
  String? description;
  List<String>? images;
  String? recipeCategory;
  List<String>? keywords;
  List<String>? recipeIngredientParts;
  double? calories;
  double? fatContent;
  double? saturatedFatContent;
  double? cholesterolContent;
  double? sodiumContent;
  double? carbohydrateContent;
  double? fiberContent;
  double? sugarContent;
  double? proteinContent;
  int? recipeServings;
  List<String>? recipeInstructions;

  OtherRecipes({
    this.id,
    this.recipeId,
    this.name,
    this.cookTime,
    this.prepTime,
    this.totalTime,
    this.description,
    this.images,
    this.recipeCategory,
    this.keywords,
    this.recipeIngredientParts,
    this.calories,
    this.fatContent,
    this.saturatedFatContent,
    this.cholesterolContent,
    this.sodiumContent,
    this.carbohydrateContent,
    this.fiberContent,
    this.sugarContent,
    this.proteinContent,
    this.recipeServings,
    this.recipeInstructions,
  });

  OtherRecipes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipeId = json['RecipeId'];
    name = json['Name'];
    cookTime = json['CookTime'];
    prepTime = json['PrepTime'];
    totalTime = json['TotalTime'];
    description = json['Description'];
    images = json['Images']?.cast<String>();
    recipeCategory = json['RecipeCategory'];
    keywords = json['Keywords']?.cast<String>();
    recipeIngredientParts = json['RecipeIngredientParts']?.cast<String>();
    calories = (json['Calories'] as num?)?.toDouble();
    fatContent = (json['FatContent'] as num?)?.toDouble();
    saturatedFatContent = (json['SaturatedFatContent'] as num?)?.toDouble();
    cholesterolContent = (json['CholesterolContent'] as num?)?.toDouble();
    sodiumContent = (json['SodiumContent'] as num?)?.toDouble();
    carbohydrateContent = (json['CarbohydrateContent'] as num?)?.toDouble();
    fiberContent = (json['FiberContent'] as num?)?.toDouble();
    sugarContent = (json['SugarContent'] as num?)?.toDouble();
    proteinContent = (json['ProteinContent'] as num?)?.toDouble();
    recipeServings = json['RecipeServings'];
    recipeInstructions = json['RecipeInstructions']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['RecipeId'] = recipeId;
    data['Name'] = name;
    data['CookTime'] = cookTime;
    data['PrepTime'] = prepTime;
    data['TotalTime'] = totalTime;
    data['Description'] = description;
    data['Images'] = images;
    data['RecipeCategory'] = recipeCategory;
    data['Keywords'] = keywords;
    data['RecipeIngredientParts'] = recipeIngredientParts;
    data['Calories'] = calories;
    data['FatContent'] = fatContent;
    data['SaturatedFatContent'] = saturatedFatContent;
    data['CholesterolContent'] = cholesterolContent;
    data['SodiumContent'] = sodiumContent;
    data['CarbohydrateContent'] = carbohydrateContent;
    data['FiberContent'] = fiberContent;
    data['SugarContent'] = sugarContent;
    data['ProteinContent'] = proteinContent;
    data['RecipeServings'] = recipeServings;
    data['RecipeInstructions'] = recipeInstructions;
    return data;
  }

  @override
  String toString() {
    return '''
OtherRecipes(
  id: $id,
  recipeId: $recipeId,
  name: $name,
  cookTime: $cookTime,
  prepTime: $prepTime,
  totalTime: $totalTime,
  description: $description,
  images: $images,
  recipeCategory: $recipeCategory,
  keywords: $keywords,
  recipeIngredientParts: $recipeIngredientParts,
  calories: $calories,
  fatContent: $fatContent,
  saturatedFatContent: $saturatedFatContent,
  cholesterolContent: $cholesterolContent,
  sodiumContent: $sodiumContent,
  carbohydrateContent: $carbohydrateContent,
  fiberContent: $fiberContent,
  sugarContent: $sugarContent,
  proteinContent: $proteinContent,
  recipeServings: $recipeServings,
  recipeInstructions: $recipeInstructions
)
''';
  }
}
