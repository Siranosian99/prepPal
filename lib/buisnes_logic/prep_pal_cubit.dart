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
  
  List<MealsCat> getAllCatagories(){
    repository.CatCall().then((cat){
      emit(PrepPalLoaded(cat: cat?? []));
      this.cat=cat?? [];
    });
    
 return cat;
  }
}
