part of 'prep_pal_cubit.dart';

@immutable
sealed class PrepPalState {}

final class PrepPalInitial extends PrepPalState {}

final class CatLoaded extends PrepPalState {
  late final List<MealsbyCat> meal;
  late final List<MealsById> random;
  late final List<MealsCat> cat;
  late final List<MealsbyCat> seaFood;

  CatLoaded({required this.cat, required this.random, required this.seaFood});
}

final class CatError extends PrepPalState {}

final class MealIdLoaded extends PrepPalState {
  late final List<MealsById> meal;

  // late List<MealsById> favList;
  MealIdLoaded({required this.meal});
}

final class MealIdError extends PrepPalState {}

final class InsideCatLoad extends PrepPalState {
  late final List<MealsbyCat> insideCat;

  InsideCatLoad({required this.insideCat});
}

final class InsideCatError extends PrepPalState {}

final class FavLoad extends PrepPalState {
  late final List<MealsById> favList;

  FavLoad({required this.favList});
}

final class FavError extends PrepPalState {}

final class AiRecipesLoad extends PrepPalState {
  late final List<AiRecipeModel> aiRecipes;
  final bool isLoading;

  AiRecipesLoad({required this.aiRecipes, required this.isLoading});
}

final class AiRecipesError extends PrepPalState {
  final String message;

  AiRecipesError({required this.message});
}

final class AiRecipesLoading extends PrepPalState {}

final class FoodFactsLoad extends PrepPalState {
  late final List<NutritionProduct> products;
  final bool isLoading;

  FoodFactsLoad({required this.products, required this.isLoading});
}

final class FoodFactsLoading extends PrepPalState {}

final class FoodFactsError extends PrepPalState {
  final String message;

  FoodFactsError({required this.message});
}
