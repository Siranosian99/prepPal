part of 'prep_pal_cubit.dart';

@immutable
sealed class PrepPalState {}

final class PrepPalInitial extends PrepPalState {}

final class CatLoaded extends PrepPalState {
  late List<MealsCat> cat;
  late List<MealsbyCat> insideCat;
  CatLoaded({required this.cat,required this.insideCat});
}
final class  CatError extends PrepPalState {}
final class MealIdLoaded extends PrepPalState {
  late List<MealsById> meal;
  MealIdLoaded({required this.meal});
}
final class  MealIdError extends PrepPalState {}
final class RandomLoad extends PrepPalState {
  late List<MealsById> meal;
  RandomLoad({required this.meal});
}

final class  RandomError extends PrepPalState {}