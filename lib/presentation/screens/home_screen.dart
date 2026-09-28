import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/meals_by_id.dart';
import 'package:preppal/core/utils/navigation_mixin.dart';

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
  int _pageIndex = 1;
  final int _lastIndex = 6;
  int? result;
  final bool _isScrolling = true;

  @override
  void initState() {
    _callCubit();
    _pageController = PageController();

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _startAutoScroll();
    super.initState();
  }

  void _callCubit() {
    context.read<PrepPalCubit>().getAllCatagories();
  }

  void _startAutoScroll() async {
    while (_isScrolling && mounted) {
      await Future.delayed(const Duration(seconds: 4));

      if (!_pageController.hasClients) continue;

      _pageController.animateToPage(
        _pageIndex,
        duration: const Duration(seconds: 4),
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
      appBar: AppBar(
        title: Text(AppTexts.prepPal),
      ),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is CatLoaded) {
            final data= state.random;
            final category=state.cat;
            final byCategory=state.seaFood;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      SizedBox(
                        height: 200,
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          // default starts at index 0
                          children: [
                            GestureDetector(
                              onTap: () async {
                                context.pushNamed(
                                  "detailed",
                                  extra: {
                                    'imgLink': data[0].strMealThumb,
                                    'mealId': data[0].idMeal,
                                    'mealName': data[0].strMeal,
                                  },
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(21),
                                child: Image.network(
                                  data[0].strMealThumb ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          data[0].strMeal.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            shadows: [
                              const Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.green,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    AppTexts.explorer,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:
                          (context, index) => GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                'inside',
                                extra: {'category': category[index].strCategory},
                              );
                            },
                            child: CategoryIcon(
                              imgLink:
                              category[index].strCategoryThumb.toString(),
                              txt: category[index].strCategory.toString(),
                              scale: 3.4,
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(width: 20),
                      itemCount: category.length,
                    ),
                  ),
                  Text(
                    AppTexts.trending,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
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
                                  'imgLink': byCategory[index].strMealThumb,
                                  'mealId': byCategory[index].idMeal,
                                  'mealName': byCategory[index].strMeal,
                                },
                              );
                            },
                            child: CategoryIcon(
                              imgLink: byCategory[index].strMealThumb.toString(),
                              txt: byCategory[index].strMeal.toString(),
                              scale: 4,
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(width: 20),
                      itemCount: byCategory.length,
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
              frameRate: const FrameRate(120),
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
