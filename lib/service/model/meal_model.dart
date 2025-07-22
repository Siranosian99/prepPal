class MealsModel {
  String? idIngredient;
  String? strIngredient;
  String? strDescription;
  Null strType;

  MealsModel(
      {this.idIngredient,
        this.strIngredient,
        this.strDescription,
        this.strType});

  MealsModel.fromJson(Map<String, dynamic> json) {
    idIngredient = json['idIngredient'];
    strIngredient = json['strIngredient'];
    strDescription = json['strDescription'];
    strType = json['strType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idIngredient'] = this.idIngredient;
    data['strIngredient'] = this.strIngredient;
    data['strDescription'] = this.strDescription;
    data['strType'] = this.strType;
    return data;
  }
}
