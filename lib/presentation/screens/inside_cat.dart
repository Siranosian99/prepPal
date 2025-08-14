import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:preppal/service/data/api_service.dart';

import '../../buisnes_logic/prep_pal_cubit.dart';
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
    _callCubit();
    super.initState();
  }

  void _callCubit() {
    BlocProvider.of<PrepPalCubit>(context).getInCatagory(widget.category);
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
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is InsideCatLoad) {
            meals = state.insideCat;
            if(meals.isEmpty){Center(child: CircularProgressIndicator());}
           return ListView.separated(
                  itemBuilder: (context, index) {
                    final meal =
                        isSearching ? filteredMeals[index] : meals[index];
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          "detailed",
                          extra: {
                            'imgLink': meal.strMealThumb,
                            'mealId': meal.idMeal,
                            'mealName': meal.strMeal,
                          },
                        );
                      },
                      child: InsideCatIcon(
                        imgLink: meal.strMealThumb.toString(),
                        txt: meal.strMeal.toString(),
                      ),
                    );
                  },
              separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: isSearching ? filteredMeals.length : meals.length,
                );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
