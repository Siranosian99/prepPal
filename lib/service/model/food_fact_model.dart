class NutritionProduct {
  String? name;
  String? brand;
  double? calories;

  NutritionProduct({
    this.name,
    this.brand,
    this.calories,
  });

  NutritionProduct.fromJson(Map<String, dynamic> json) {
    name = json['product_name'];
    brand = json['brands'];
    calories = json['nutriments']?['energy-kcal_100g'];
  }
}