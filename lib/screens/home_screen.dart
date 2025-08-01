import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/navigation/navigation_mixin.dart';
import 'package:preppal/service/data/api_service.dart';
import 'package:preppal/service/model/meal_areas_model.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meal_items_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';

import '../widgets/category_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with NavigatorMixin {
  final PageController _pageController = PageController();
  List<MealsModel> meals = [];
  List<MealsCat> mlsCat = [];
  List<MealsbyCat> mlsByCt = [];
  late ApiService _apiService;

  @override
  void initState() {
    callData();
    super.initState();
  }

  Future<void> callData() async {
    _apiService = ApiService();
    // meals=await _apiService.ItemsCall()?? [];
    mlsByCt = await _apiService.CallByCat() ?? [];
    mlsCat = await _apiService.CatCall() ?? [];
    // mlsAr=await _apiService.ArCall()??[];
    setState(() {
      meals;
    });
    print(meals);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.prepPal),
        actions: [IconButton(onPressed: () {}, icon: (Icon(Icons.search)))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                itemBuilder:
                    (context, index) =>
                        Image.network('https://picsum.photos/200', scale: 1),
              ),
            ),
            SizedBox(height: 25),
            Text(
              AppTexts.explorer,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) => GestureDetector(
                      onTap: (){
                        context.pushNamed('inside',extra:{
                          'category':mlsCat[index].strCategory
                        });
                      },
                      child: CategoryIcon(
                        imgLink: mlsCat[index].strCategoryThumb.toString(),
                        txt: mlsCat[index].strCategory.toString(),
                        scale: 3.4,
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemCount: mlsCat.length,
              ),
            ),
            Text(
              AppTexts.trending,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) => GestureDetector(
                      onTap: (){
                        context.pushNamed("detailed",extra:{
                          'imgLink':mlsByCt[index].strMealThumb,
                          'mealId':mlsByCt[index].idMeal,
                          'mealName':mlsByCt[index].strMeal
                        });
                      },
                      child: CategoryIcon(
                        imgLink: mlsByCt[index].strMealThumb.toString(),
                        txt: mlsByCt[index].strMeal.toString(),
                        scale: 4,
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemCount: mlsByCt.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
