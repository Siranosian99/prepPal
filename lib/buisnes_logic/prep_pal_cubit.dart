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

  Future<void> getAllCatagories() async {
    try {
      // Fetch data from API
      cat = await repository.CatCall() ?? [];
      seaFood=await repository.InsideCat("SeaFood")?? [];
      random = await repository.RandomMeal() ?? [];
      //
      // // Save insideCat to Hive
      // var mbox = Hive.box<MealsbyCat>('SeaFood');
      // await mbox.clear(); // Optional: clear old data
      // await mbox.addAll(insideCat);
      var cbox = Hive.box<MealsCat>('category');
      await cbox.clear(); // Optional: clear old data
      await cbox.addAll(cat);
      emit(CatLoaded(cat: cat, random: random,seaFood:seaFood));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getMealById(String id) async {
    meal = await repository.MealbyId(id) ?? [];
    var mbox = Hive.box<MealsById>('byId');
    await mbox.clear();
    await mbox.addAll(meal);
    emit(MealIdLoaded(meal: meal ?? []));
  }

  Future<void> getOtherRecipes() async {
    recipes = await repository.OtherRecipesCall() ?? [];
    emit(OtherRecipesLoad(recipes: recipes ?? []));
  }

  Future<void> getInCatagory(String category) async {
    insideCat = await repository.InsideCat(category) ?? [];
    emit(InsideCatLoad(insideCat: insideCat));
  }

  // Future<void>getRandomMeal()async {
  //   meal=await repository.RandomMeal() ?? [];
  //   emit(MealIdLoaded(meal: meal ?? []));
  // }
}
