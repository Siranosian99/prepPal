import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/repository.dart';

part 'prep_pal_state.dart';

class PrepPalCubit extends Cubit<PrepPalState> {
  PrepPalCubit(this.repository) : super(PrepPalInitial());

  final PrepPalRepository repository;
  List<MealsCat> cat=[];
  List<MealsbyCat> insideCat=[];

  Future<void>getAllCatagories(String category)async {
    cat=await repository.CatCall() ?? [];
    insideCat= await repository.InsideCat(category) ?? [];
    emit(CatLoaded(cat: cat, insideCat: insideCat));
  }

}
