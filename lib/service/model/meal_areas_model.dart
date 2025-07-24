class MealsArea {
  String? strArea;

  MealsArea({this.strArea});

  MealsArea.fromJson(Map<String, dynamic> json) {
    strArea = json['strArea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strArea'] = strArea;
    return data;
  }

  @override
  String toString(){
    return '$strArea';
  }
}
