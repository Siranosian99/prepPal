import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/service/model/other_recipes_model.dart';

import '../widgets/guide_icon.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  List<OtherRecipes> recipes=[];
  @override
  void initState() {
    BlocProvider.of<PrepPalCubit>(context).getOtherRecipes();print(recipes.length);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppTexts.recipes),
        actions: [IconButton(onPressed: () {}, icon: (Icon(Icons.search)))],
      ),
      body:BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is OtherRecipesLoad) {
            recipes=state.recipes;
            return GestureDetector(
              // onTap: onTap,
              child: ListView.separated(itemBuilder: (context,index)=>Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(23),
                        //   child: Image.network(recipes[index].images![0].toString())
                        // ),
                        Container(
                          padding: EdgeInsets.only(left: 20.0, bottom: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(23),
                              bottomRight: Radius.circular(23),
                            ),
                            color: Colors.grey[700],
                          ),
                          width: double.infinity,
                          height: 40,
                          child: Text(
                           "${ recipes[index].name.toString()} $index",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),separatorBuilder: (context,index)=>SizedBox(height: 10,), itemCount: recipes.length)
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}
