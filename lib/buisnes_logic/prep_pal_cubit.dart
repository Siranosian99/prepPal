import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/meals_by_id.dart';
import 'package:preppal/service/repository.dart';

part 'prep_pal_state.dart';

class PrepPalCubit extends Cubit<PrepPalState> {
  PrepPalCubit(this.repository) : super(PrepPalInitial());

  final PrepPalRepository repository;
  List<MealsCat> cat=[];
  List<MealsbyCat> insideCat=[];
  List<MealsById> meal=[];
  List<MealsById> random=[];
  Future<void>getAllCatagories(String category)async {
    cat=await repository.CatCall() ?? [];
    insideCat= await repository.InsideCat(category) ?? [];
    random=await repository.RandomMeal() ?? [];
    emit(CatLoaded(cat: cat, insideCat: insideCat,random:random));
  }
  Future<void>getMealById(String id)async {
    meal=await repository.MealbyId(id) ?? [];
    emit(MealIdLoaded(meal: meal ?? []));
  }
  // Future<void>getRandomMeal()async {
  //   meal=await repository.RandomMeal() ?? [];
  //   emit(MealIdLoaded(meal: meal ?? []));
  // }
}
