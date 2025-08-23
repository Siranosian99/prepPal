import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/service/data/api_service.dart';
import 'package:preppal/service/model/meals_by_id.dart';

import '../widgets/container_detailed.dart'; // Assume this defines AppTexts.about

class DetailedItemScreen extends StatefulWidget {
  String mealId;
  String imgLink;
  String mealName;

  DetailedItemScreen({
    super.key,
    required this.mealId,
    required this.imgLink,
    required this.mealName,
  });

  @override
  State<DetailedItemScreen> createState() => _DetailedItemScreenState();
}

class _DetailedItemScreenState extends State<DetailedItemScreen>
    with TickerProviderStateMixin {
  List<MealsById> meals = [];

  late final AnimationController _animationController;

  // Dummy data
  @override
  void initState() {
    BlocProvider.of<PrepPalCubit>(context).getMealById(widget.mealId);
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is MealIdLoaded) {
            meals = state.meal;
            return meals.isEmpty
                ? Center(
                  child: Lottie.asset(
                    'assets/lottie/plant_loader.json',
                    repeat: true,
                    frameRate: FrameRate(120),
                    controller: _animationController,
                    width: 100,
                    height: 100,
                  ),
                )
                : Column(
                  children: [
                    // Image with food name and heart icon
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          child: Image.network(
                            widget.imgLink,
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.mealName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black54,
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<PrepPalCubit>().addFavouriteList(
                                    meals[0],
                                    context,
                                  );
                                  print('added');
                                },
                                icon: Icon(Icons.favorite),
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Main container below image
                    Expanded(
                      child: ContainerDetailed(
                        onTap: () {},
                        link: meals[0].strYoutube ?? 'There is No Link',
                        ingredinet:
                            meals[0].strIngredient?.join('') ??
                            "No ingredients available",
                        tags: meals[0].strTags ?? "OOPS there is No Tags",
                        country: meals[0].strArea ?? "OOPS",
                        about: meals[0].strInstructions.toString(),
                      ),
                    ),
                  ],
                );
          }
          return Center(
            child: Lottie.asset(
              'assets/lottie/plant_loader.json',
              repeat: true,
              frameRate: FrameRate(120),
              controller: _animationController,
              width: 100,
              height: 100,
            ),
          );
        },
      ),
    );
  }
}
