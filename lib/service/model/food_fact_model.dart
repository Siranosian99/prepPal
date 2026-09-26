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
    final productName = json['product_name'];
    final brands = json['brands'];

    name = productName is String ? productName : null;
    brand = brands is String ? brands : null;

    final nutriments = json['nutriments'];

    if (nutriments is Map) {
      final kcal = nutriments['energy-kcal_100g'];

      if (kcal is num) {
        calories = kcal.toDouble();
      }
    }
  }

  @override
  String toString() {
    return 'NutritionProduct('
        'name: $name, '
        'brand: $brand, '
        'calories: $calories'
        ')';
  }
}
// class NutritionProduct {
//   String? name;
//   String? brand;
//   double? calories;
//
//   NutritionProduct({this.name, this.brand, this.calories});
//
//   NutritionProduct.fromJson(Map<String, dynamic> json) {
//     name = json['product_name'];
//     brand = json['brands'];
//     calories = (json['nutriments']?['energy-kcal_100g'] as num?)?.toDouble();
//   }
//
//   @override
//   String toString() {
//     return 'NutritionProduct(name: $name, brand: $brand, calories: $calories)';
//   }
// }
