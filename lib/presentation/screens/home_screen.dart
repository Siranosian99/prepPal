import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/meals_by_id.dart';
import 'package:preppal/utilites/navigation_mixin.dart';

import '../../buisnes_logic/prep_pal_cubit.dart';
import '../widgets/category_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with NavigatorMixin, TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;
  List<MealsCat> mlsCat = [];
  List<MealsbyCat> mlsByCt = [];
  List<MealsById> random = [];
  int _pageIndex = 1;
  int _lastIndex = 6;
  int? result;
  bool _isScrolling = true;

  @override
  void initState() {
    _hiveData();
    _callCubit();
    _pageController = PageController();

    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _startAutoScroll();
    super.initState();
  }

  void _callCubit() {
    BlocProvider.of<PrepPalCubit>(context).getAllCatagories();
  }

  void _hiveData() {
    var myBox = Hive.box<MealsCat>('category');
    var myBoxx = Hive.box<MealsbyCat>('SeaFood');
    print("------------$mlsByCt");
    mlsCat = myBox.values.toList();
    mlsByCt = myBoxx.values.toList();
    setState(() {
      mlsCat;
      mlsByCt;
    });
  }

  void _startAutoScroll() async {
    while (_isScrolling && mounted) {
      await Future.delayed(Duration(seconds: 4));

      if (!_pageController.hasClients) continue;

      _pageController.animateToPage(
        _pageIndex,
        duration: Duration(seconds: 4),
        curve: Curves.easeOut,
      );
      _callCubit();
      if (!mounted) break;
      _pageIndex = (_pageIndex + 1) % _lastIndex;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.prepPal)),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is CatLoaded) {
            random = state.random;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      // default starts at index 0
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.goNamed(
                              "detailed",
                              extra: {
                                'imgLink': random[0].strMealThumb,
                                'mealId': random[0].idMeal,
                                'mealName': random[0].strMeal,
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(21),
                            child: Image.network(
                              random[0].strMealThumb ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
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
                            onTap: () {
                              context.pushNamed(
                                'inside',
                                extra: {'category': mlsCat[index].strCategory},
                              );
                            },
                            child: CategoryIcon(
                              imgLink:
                                  mlsCat[index].strCategoryThumb.toString(),
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
                            onTap: () {
                              context.pushNamed(
                                "detailed",
                                extra: {
                                  'imgLink': mlsByCt[index].strMealThumb,
                                  'mealId': mlsByCt[index].idMeal,
                                  'mealName': mlsByCt[index].strMeal,
                                },
                              );
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
            );
          }
          return Center(
            child: Lottie.asset(
              'assets/lottie/loading_food.json',
              repeat: true,
              frameRate: FrameRate(120),
              controller: _animationController,
              height: 100,
              width: 100,
            ),
          );
        },
      ),
    );
  }
}
