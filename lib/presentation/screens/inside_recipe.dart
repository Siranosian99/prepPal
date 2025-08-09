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
  String noRecipeLogo="https://noreciperequired.ca/wp-content/uploads/2024/01/no-recipe-required-logo.jpg";
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
        appBar: AppBar(title: Text('Recipe Detail')),
        body: BlocBuilder<PrepPalCubit, PrepPalState>(
            builder: (context, state) {
              if (state is OtherRecipesByNameLoad) {
                recipes = state.recipesByName;
                return ListView.separated(itemBuilder: (context,index)=>Column(
                  children: [
                    Stack(children: [
                      Image.network( recipes[index].images != null && recipes[index].images!.isNotEmpty && recipes[index].images![0] != null
                          ? recipes[index].images![0].toString()
                          : noRecipeLogo,)
                    ],),
                  ],
                ),
                    separatorBuilder: (context,index)=>Divider(height: 200,),
                    itemCount: recipes.length);
              }
              return Center(child: CircularProgressIndicator(),);
            }));
  }
}

