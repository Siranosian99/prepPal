class MealsModel {
  String? idIngredient;
  String? strIngredient;
  String? strDescription;
  String? strType;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idIngredient'] = idIngredient;
    data['strIngredient'] = strIngredient;
    data['strDescription'] = strDescription;
    data['strType'] = strType;
    return data;
  }


  @override
  String toString(){
    return '$idIngredient , $strIngredient,$strDescription,strType';
  }
  }
