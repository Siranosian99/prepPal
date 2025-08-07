import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';
import 'package:preppal/service/model/other_recipes_model.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  List<OtherRecipes> recipes = [];

  @override
  void initState() {
    BlocProvider.of<PrepPalCubit>(context).getOtherRecipes();
    print("this is:$recipes");
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(recipes[0].name ?? 'Recipe Detail')),
        body: BlocBuilder<PrepPalCubit, PrepPalState>(
            builder: (context, state) {
              if (state is OtherRecipesLoad) {
                recipes=state.recipes;
                return Column(
                  children: [],
                );
              }
              return Center(child: CircularProgressIndicator(),);
            }));}
            }

