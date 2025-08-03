part of 'prep_pal_cubit.dart';

@immutable
sealed class PrepPalState {}

final class PrepPalInitial extends PrepPalState {}

final class PrepPalLoaded extends PrepPalState {
  late List<MealsCat> cat;

  PrepPalLoaded({required this.cat});
}
final class PrepPalError extends PrepPalState {}
