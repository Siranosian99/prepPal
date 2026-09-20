import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:preppal/service/model/ai_recipes_model.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/meals_by_id.dart';
import 'package:preppal/service/model/other_recipes_model.dart';
import 'package:preppal/service/repository/repository.dart';

part 'prep_pal_state.dart';

class PrepPalCubit extends Cubit<PrepPalState> {
  PrepPalCubit(this.repository) : super(PrepPalInitial());

  final PrepPalRepository repository;
  List<MealsCat> cat = [];
  List<MealsbyCat> insideCat = [];
  List<MealsbyCat> seaFood = [];
  List<MealsById> meal = [];
  List<MealsById> random = [];
  List<OtherRecipes> recipes = [];
  List<OtherRecipes> recipesByName = [];
  List<MealsById> favList = [];
  List<AiRecipeModel> aiRecipes = [];

  Future<void> getAllCatagories() async {
    try {
      // Fetch data from API
      cat = await repository.CatCall() ?? [];
      seaFood = await repository.InsideCat("SeaFood") ?? [];
      random = await repository.RandomMeal() ?? [];

      emit(CatLoaded(cat: cat, random: random, seaFood: seaFood));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getMealById(String id) async {
    meal = await repository.MealbyId(id) ?? [];
    emit(MealIdLoaded(meal: meal));
  }

  Future<void> getOtherRecipes() async {
    recipes = await repository.OtherRecipesCall() ?? [];
    emit(OtherRecipesLoad(recipes: recipes));
  }

  Future<void> getInCatagory(String category) async {
    insideCat = await repository.InsideCat(category) ?? [];
    emit(InsideCatLoad(insideCat: insideCat));
  }

  Future<void> addFavouriteList(MealsById meal, BuildContext ctx) async {
    var inbox = Hive.box<MealsById>('save');
    favList = inbox.values.toList();
    if (favList.any((item) => item.idMeal == meal.idMeal)) {
      ScaffoldMessenger.of(
        ctx,
      ).showSnackBar(SnackBar(content: Text("Item recently favourites!")));
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

  Future<void> AiRecipesGet(String query) async {
    try {
      aiRecipes = await repository.AiRecipesGet(query) ?? [];
      emit(AiRecipesLoad(aiRecipes: aiRecipes));
    } catch (e) {
      emit(
          AiRecipesError(
            message: e.toString(),
          ));
    }
  }

  // Future<void> translateText(String toLang,String text)async{
  //   await repository.TranslateService(toLang, text);
  // }

  // Future<void>getRandomMeal()async {
  //   meal=await repository.RandomMeal() ?? [];
  //   emit(MealIdLoaded(meal: meal ?? []));
  // }
}
