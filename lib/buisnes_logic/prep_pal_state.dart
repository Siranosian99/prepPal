part of 'prep_pal_cubit.dart';

@immutable
sealed class PrepPalState {}

final class PrepPalInitial extends PrepPalState {}

final class CatLoaded extends PrepPalState {
  late List<MealsbyCat> meal;
  late List<MealsById> random;
  late List<MealsCat> cat;
  late List<MealsbyCat> seaFood;
  CatLoaded({required this.cat,required this.random,required this.seaFood});
}
final class  CatError extends PrepPalState {}
final class MealIdLoaded extends PrepPalState {
  late List<MealsById> meal;
  // late List<MealsById> favList;
  MealIdLoaded({required this.meal});
}
final class  MealIdError extends PrepPalState {}
final class OtherRecipesLoad extends PrepPalState {
  late List<OtherRecipes> recipes;
  OtherRecipesLoad({required this.recipes});
}
final class  OtherRecipesError extends PrepPalState {}
final class InsideCatLoad extends PrepPalState{
  late List<MealsbyCat> insideCat;
  InsideCatLoad({required this.insideCat});
}
final class InsideCatError extends PrepPalState{
}
final class FavLoad extends PrepPalState{
  late List<MealsById> favList;
  FavLoad({required this.favList});
}
final class FavError extends PrepPalState{
}

final class AiRecipesLoad extends PrepPalState{
  late List<AiRecipeModel> aiRecipes;
  AiRecipesLoad({required this.aiRecipes});
}
final class AiRecipesError extends PrepPalState{
  final String message;
  AiRecipesError({required this.message});
}