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
  TextEditingController _filter = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    callData();
    super.initState();
  }

  Future<void> callData() async {
    _apiService = ApiService();
    meals = await _apiService.CallByCatInsdie(widget.category) ?? [];
    setState(() {
      meals;
    });
  }

  void switchBool() {
    setState(() {
      isSearching = !isSearching;
    });
  }

  void searchFilter(String query) {
    if (query.isNotEmpty) {
      filteredMeals =
          meals
              .where(
                (meal) =>
                    meal.strMeal != null &&
                    meal.strMeal!.contains(query.toLowerCase()),
              )
              .toList();
      setState(() {
        filteredMeals;
      });
    } else {
      setState(() {
        filteredMeals = meals;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            isSearching
                ? TextFormField(
                  decoration: InputDecoration(hintText: "Search..."),
                  onChanged: searchFilter,
                )
                : Text(widget.category),
        actions: [
          IconButton(
            onPressed: () {
              switchBool();
              _filter.clear();
              filteredMeals.clear;
              filteredMeals = meals;
            },
            icon: Icon(isSearching ? Icons.close : Icons.search),
          ),
        ],
      ),
      body:
          meals.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                itemBuilder:
                    (context, index) => GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          "detailed",
                          extra: {
                            'imgLink':
                                isSearching
                                    ? filteredMeals[index].strMealThumb
                                    : meals[index].strMealThumb,
                            'mealId':
                                isSearching
                                    ? filteredMeals[index].idMeal
                                    : meals[index].idMeal,
                            'mealName':
                                isSearching
                                    ? filteredMeals[index].strMeal
                                    : meals[index].strMeal,
                          },
                        );
                      },
                      child: InsideCatIcon(
                        imgLink:
                            isSearching
                                ? filteredMeals[index].strMealThumb.toString()
                                : meals[index].strMealThumb.toString(),
                        txt:
                            isSearching
                                ? filteredMeals[index].strMeal.toString()
                                : meals[index].strMeal.toString(),
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemCount: isSearching ? filteredMeals.length : meals.length,
              ),
    );
  }
}
