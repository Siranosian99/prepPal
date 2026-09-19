class AiRecipeModel {
  String? name;
  List<String>? ingredients;
  int? duration;
  String? difficulty;
  List<String>? steps;

  AiRecipeModel(
      {this.name,
        this.ingredients,
        this.duration,
        this.difficulty,
        this.steps});

  AiRecipeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ingredients = json['ingredients'].cast<String>();
    duration = json['duration'];
    difficulty = json['difficulty'];
    steps = json['steps'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['ingredients'] = ingredients;
    data['duration'] = duration;
    data['difficulty'] = difficulty;
    data['steps'] = steps;
    return data;
  }
}
