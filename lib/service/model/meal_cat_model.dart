import 'package:hive/hive.dart';
part 'meal_cat_model.g.dart';
@HiveType(typeId: 0)
class MealsCat {
  @HiveField(0)
  String? idCategory;
  @HiveField(1)
  String? strCategory;
  @HiveField(2)
  String? strCategoryThumb;
  @HiveField(3)
  String? strCategoryDescription;

  MealsCat(
      {this.idCategory,
        this.strCategory,
        this.strCategoryThumb,
        this.strCategoryDescription});

  MealsCat.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCategory'] = idCategory;
    data['strCategory'] = strCategory;
    data['strCategoryThumb'] = strCategoryThumb;
    data['strCategoryDescription'] = strCategoryDescription;
    return data;
  }
  @override
  String toString(){
    return '$idCategory,$strCategory ,$strCategoryThumb, $strCategoryDescription';
  }
}


