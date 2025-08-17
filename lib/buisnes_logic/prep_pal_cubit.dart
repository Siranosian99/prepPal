import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/meals_by_id.dart';
import 'package:preppal/service/model/other_recipes_model.dart';
import 'package:preppal/service/repository.dart';

part 'prep_pal_state.dart';

class PrepPalCubit extends Cubit<PrepPalState> {
  PrepPalCubit(this.repository) : super(PrepPalInitial());

  final PrepPalRepository repository;
  List<MealsCat> cat = [];
  List<MealsbyCat> insideCat = [];
  List<MealsbyCat> seaFood=[];
  List<MealsById> meal = [];
  List<MealsById> random = [];
  List<OtherRecipes> recipes = [];
  List<OtherRecipes> recipesByName = [];
  List<MealsById> favList=[];

  Future<void> getAllCatagories() async {
    try {
      // Fetch data from API
      cat = await repository.CatCall() ?? [];
      seaFood=await repository.InsideCat("SeaFood")?? [];
      random = await repository.RandomMeal() ?? [];

      emit(CatLoaded(cat: cat, random: random,seaFood:seaFood));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getMealById(String id) async {
    meal = await repository.MealbyId(id) ?? [];
    emit(MealIdLoaded(meal: meal ?? [],favList: favList));
  }

  Future<void> getOtherRecipes() async {
    recipes = await repository.OtherRecipesCall() ?? [];
    emit(OtherRecipesLoad(recipes: recipes ?? []));
  }

  Future<void> getInCatagory(String category) async {
    insideCat = await repository.InsideCat(category) ?? [];
    emit(InsideCatLoad(insideCat: insideCat));
  }

  void addFavouriteList(MealsById meal){
    favList= repository.addFavouriteList(meal);
    emit(FavLoad(favList: favList));
  }

  // Future<void>getRandomMeal()async {
  //   meal=await repository.RandomMeal() ?? [];
  //   emit(MealIdLoaded(meal: meal ?? []));
  // }
}
