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
  int? cholesterolContent;
  int? sodiumContent;
  double? carbohydrateContent;
  double? fiberContent;
  double? sugarContent;
  double? proteinContent;
  int? recipeServings;
  List<String>? recipeInstructions;

  OtherRecipes(
      {this.id,
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
        this.recipeInstructions});

  OtherRecipes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipeId = json['RecipeId'];
    name = json['Name'];
    cookTime = json['CookTime'];
    prepTime = json['PrepTime'];
    totalTime = json['TotalTime'];
    description = json['Description'];
    images = json['Images'].cast<String>();
    recipeCategory = json['RecipeCategory'];
    keywords = json['Keywords'].cast<String>();
    recipeIngredientParts = json['RecipeIngredientParts'].cast<String>();
    calories = json['Calories'];
    fatContent = json['FatContent'];
    saturatedFatContent = json['SaturatedFatContent'];
    cholesterolContent = json['CholesterolContent'];
    sodiumContent = json['SodiumContent'];
    carbohydrateContent = json['CarbohydrateContent'];
    fiberContent = json['FiberContent'];
    sugarContent = json['SugarContent'];
    proteinContent = json['ProteinContent'];
    recipeServings = json['RecipeServings'];
    recipeInstructions = json['RecipeInstructions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['RecipeId'] = this.recipeId;
    data['Name'] = this.name;
    data['CookTime'] = this.cookTime;
    data['PrepTime'] = this.prepTime;
    data['TotalTime'] = this.totalTime;
    data['Description'] = this.description;
    data['Images'] = this.images;
    data['RecipeCategory'] = this.recipeCategory;
    data['Keywords'] = this.keywords;
    data['RecipeIngredientParts'] = this.recipeIngredientParts;
    data['Calories'] = this.calories;
    data['FatContent'] = this.fatContent;
    data['SaturatedFatContent'] = this.saturatedFatContent;
    data['CholesterolContent'] = this.cholesterolContent;
    data['SodiumContent'] = this.sodiumContent;
    data['CarbohydrateContent'] = this.carbohydrateContent;
    data['FiberContent'] = this.fiberContent;
    data['SugarContent'] = this.sugarContent;
    data['ProteinContent'] = this.proteinContent;
    data['RecipeServings'] = this.recipeServings;
    data['RecipeInstructions'] = this.recipeInstructions;
    return data;
  }
}
