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

