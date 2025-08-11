import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:preppal/service/data/api_service.dart';
import '../../service/model/meals_by_cat.dart';
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
  List<MealsbyCat> filteredMeals = [];
  bool isSearching=false;

  @override
  void initState() {
    callData();
    super.initState();
  }

  Future<void> callData() async {
    _apiService = ApiService();
    meals = await _apiService.CallByCatInsdie(widget.category) ??[];
    setState(() {
      meals;
    });
  }

  void searchFilter(String e){
    filteredMeals=meals.where((e)=>meals.contains(e)).toList();
    isSearching=true;
    setState(() {
    });
    print(filteredMeals);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text(widget.category),
      actions: [
        IconButton(onPressed: (){
          searchFilter('Apam balik');
        }, icon: Icon(Icons.search,color:Colors.green,))
      ],
      centerTitle: true,),
      body: meals.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
        itemBuilder: (context, index) => GestureDetector(
          onTap:(){
            context.pushNamed("detailed",extra:{
              'imgLink':isSearching ?filteredMeals:meals[index].strMealThumb,
              'mealId':isSearching ?filteredMeals:meals[index].idMeal,
              'mealName':isSearching ?filteredMeals:meals[index].strMeal
            });

          },
          child: InsideCatIcon(
            imgLink: meals[index].strMealThumb.toString(),
            txt: meals[index].strMeal.toString()
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemCount: meals.length,
      ),
    );
  }

}
