import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:preppal/service/model/ai_recipes_model.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/meals_by_id.dart';
import 'package:preppal/service/repository/repository.dart';

import '../service/model/food_fact_model.dart';

part 'prep_pal_state.dart';

class PrepPalCubit extends Cubit<PrepPalState> {
  PrepPalCubit(this.repository) : super(PrepPalInitial());

  final PrepPalRepository repository;
  List<MealsCat> cat = [];
  List<MealsbyCat> insideCat = [];
  List<MealsbyCat> seaFood = [];
  List<MealsById> meal = [];
  List<MealsById> random = [];
  List<MealsById> favList = [];
  List<AiRecipeModel> aiRecipes = [];
  List<NutritionProduct> products = [];

  Future<void> getAllCatagories() async {
    final categoryBox = Hive.box<MealsCat>('category');
    final seaFoodBox = Hive.box<MealsbyCat>('SeaFood');
    final randomBox = Hive.box<MealsById>('random');
    final localCategories = categoryBox.values.toList();
    final localSeaFood = seaFoodBox.values.toList();
    final localRandom = randomBox.values.toList();
    if (localCategories.isNotEmpty ||
        localRandom.isNotEmpty ||
        localSeaFood.isNotEmpty) {
      emit(
        CatLoaded(
          cat: localCategories,
          random: localRandom,
          seaFood: localSeaFood,
        ),
      );
    }
    try {
      cat = await repository.CatCall() ?? [];
      seaFood = await repository.InsideCat("SeaFood") ?? [];
      random = await repository.RandomMeal() ?? [];

      await categoryBox.clear();
      await categoryBox.addAll(cat);

      await seaFoodBox.clear();
      await seaFoodBox.addAll(seaFood);

      await randomBox.clear();
      await randomBox.addAll(random);
      emit(CatLoaded(cat: cat, random: random, seaFood: seaFood));

    } catch (e) {
      if (localCategories.isNotEmpty ||
          localRandom.isNotEmpty ||
          localSeaFood.isNotEmpty) {
        emit(
          CatLoaded(
            cat: localCategories,
            random: localRandom,
            seaFood: localSeaFood,
          ),
        );
      }
    }
  }

  Future<void> getMealById(String id) async {
    final insideMeal=Hive.box<MealsById>('byId');
    final localMeal=insideMeal.values.toList();
    if(localMeal.isNotEmpty){
      emit(MealIdLoaded(meal: localMeal));
    }
    try {
      meal = await repository.MealbyId(id) ?? [];
      await insideMeal.clear();
      await insideMeal.addAll(meal);
      emit(MealIdLoaded(meal: meal));
    } catch (e) {
      emit(MealIdLoaded(meal: localMeal));
    }
  }

  Future<void> getInCatagory(String category) async {
    final categoryBox = Hive.box<MealsbyCat>('inCat');
    final localCategories = categoryBox.values.toList();

    if(localCategories.isNotEmpty){
      emit(InsideCatLoad(insideCat: localCategories));
    }
    try {
      insideCat = await repository.InsideCat(category) ?? [];
      await categoryBox.clear();
      await categoryBox.addAll(insideCat);
      emit(InsideCatLoad(insideCat: insideCat));
    } catch (e) {
      emit(InsideCatLoad(insideCat: localCategories));
      // emit(InsideCatError(errorMessage: e.toString()));
    }
  }

  Future<void> addFavouriteList(MealsById meal, BuildContext ctx) async {
    var inbox = Hive.box<MealsById>('save');
    favList = inbox.values.toList();
    if (favList.any((item) => item.idMeal == meal.idMeal)) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text("Item recently favourites!")),
      );
      return;
    } else {
      favList = [...favList, meal];
      await inbox.add(meal);
    }
  }

  Future<void> removeFavouriteList(int index) async {
    var inbox = Hive.box<MealsById>('save');
    await inbox.deleteAt(index);
    favList = inbox.values.toList();
    emit(FavLoad(favList: favList));
  }

  void loadFavourites() {
    var inbox = Hive.box<MealsById>('save');
    favList = inbox.values.toList();
    emit(FavLoad(favList: favList));
  }
//ai Function
  Future<void> AiRecipesGet(String query) async {
    try {
      emit(AiRecipesLoad(aiRecipes: aiRecipes, isLoading: true));
      final result = await repository.AiRecipesGet(query) ?? [];
      aiRecipes.addAll(result);
      emit(AiRecipesLoad(aiRecipes: aiRecipes, isLoading: false));
    } catch (e) {
      emit(AiRecipesError(message: e.toString()));
    }
  }
// Nutrition Function
  Future<void> FoodFactGet(String query) async {
    products.clear();
    try {
      emit(FoodFactsLoad(products: products, isLoading: true));
      final result = await repository.FoodFactsGet(query) ?? [];
      products.addAll(result);
      emit(FoodFactsLoad(products: products, isLoading: false));
    } catch (e) {
      emit(FoodFactsError(message: e.toString()));
    }
  }
}
