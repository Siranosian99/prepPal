import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';

import '../widgets/container_detailed.dart';

class DetailedItemScreen extends StatefulWidget {
  final String mealId;
  final String imgLink;
  final String mealName;

  const DetailedItemScreen({
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
  final String asset = 'assets/lottie/plant_loader.json';
  bool isLoading = false;
  late final AnimationController _animationController;

  // Dummy data
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    context.read<PrepPalCubit>().getMealById(widget.mealId);
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
      appBar: AppBar(),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is MealIdLoaded) {
            if (state.meal.isEmpty) {
              return Center(
                child: Lottie.asset(
                  asset,
                  repeat: true,
                  frameRate: const FrameRate(120),
                  controller: _animationController,
                  width: 100,
                  height: 100,
                ),
              );
            }
            final data = state.meal[0];

            return Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
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
                              style: const TextStyle(
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
                                data,
                                context,
                              );
                            },
                            icon: const Icon(Icons.favorite),
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
                    mealId: data.idMeal,
                    name: "Let's Make ${data.strMeal}",
                    link: data.strYoutube ?? 'There is No Link',
                    ingredinet:
                        data.strIngredient?.join('') ??
                        "No ingredients available",
                    tags: data.strTags ?? "OOPS there is No Tags",
                    country: data.strArea ?? "OOPS",
                    about: data.strInstructions.toString(),
                    mealName: data.strMeal,
                    imgLink: data.strMealThumb,
                    isLoading: isLoading,
                    onLoadingChange: (value) {
                      setState(() {
                        isLoading = value;
                      });
                    },
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Lottie.asset(
              asset,
              repeat: true,
              frameRate: const FrameRate(120),
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
