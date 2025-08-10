import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';
import 'package:preppal/service/model/other_recipes_model.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String name;
  final int index;
  const RecipeDetailScreen({super.key,required this.name,required this.index});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  String noRecipeLogo =
      "https://noreciperequired.ca/wp-content/uploads/2024/01/no-recipe-required-logo.jpg";
  List<OtherRecipes> recipes = [];

  @override
  void initState() {
    BlocProvider.of<PrepPalCubit>(context).getOtherRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe Detail')),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is OtherRecipesLoad) {
            recipes = state.recipes;
            return Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      recipes[widget.index].images != null &&
                          recipes[widget.index].images!.isNotEmpty &&
                          recipes[widget.index].images![0] != null
                          ? recipes[widget.index].images![0].toString()
                          : noRecipeLogo,
                    ),
                    Text(recipes[widget.index].name.toString())
                  ],
                ),
              ],
            );}
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
