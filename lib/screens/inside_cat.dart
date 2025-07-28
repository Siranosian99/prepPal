import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/service/data/api_service.dart';
import 'package:preppal/service/model/meal_areas_model.dart';

import '../service/model/meals_by_cat.dart';
import '../widgets/inside_cat_icon.dart';

class InsideCat extends StatefulWidget {
  final String category;

  const InsideCat({super.key, required this.category});

  @override
  State<InsideCat> createState() => _InsideCatState();
}

class _InsideCatState extends State<InsideCat> {
  late final ApiService _apiService;
  List<MealsbyCat> meals = [];

  @override
  void initState() {
    callData();
    super.initState();
  }

  Future<void> callData() async {
    _apiService = ApiService();
    meals = await _apiService.CallByCatInsdie(widget.category) ?? [];
    print("Thisss is Meals Maan:$meals");
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text(AppTexts.breakf),
      centerTitle: true,),
      body: meals.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
        itemBuilder: (context, index) => InsideCatIcon(
          imgLink: meals[index].strMealThumb.toString(),
          txt: meals[index].strMeal.toString()
        ),
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemCount: meals.length,
      ),
    );
  }

}
