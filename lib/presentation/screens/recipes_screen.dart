import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/service/model/other_recipes_model.dart';

import '../widgets/guide_icon.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen>
    with TickerProviderStateMixin {
  String noRecipeLogo =
      "https://noreciperequired.ca/wp-content/uploads/2024/01/no-recipe-required-logo.jpg";
  List<OtherRecipes> recipes = [];
  late final AnimationController _animationController;

  @override
  void initState() {
    BlocProvider.of<PrepPalCubit>(context).getOtherRecipes();
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppTexts.recipes),
        actions: [IconButton(onPressed: () {}, icon: (Icon(Icons.search)))],
      ),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is OtherRecipesLoad) {
            recipes = state.recipes;
            return ListView.separated(
              itemBuilder:
                  (context, index) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () {
                            context.goNamed(
                              "insideRecipe",
                              extra: {'name': recipes[0].name, 'index': index},
                            );
                            print(
                              "index is:$index"
                              "data is:${recipes[index].name}",
                            );
                          },
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(23),
                                  bottomRight: Radius.circular(23),
                                ),
                                child: Center(
                                  child: Image.network(
                                    recipes[index].images != null &&
                                            recipes[index].images!.isNotEmpty &&
                                            recipes[index].images![0] != null
                                        ? recipes[index].images![0].toString()
                                        : noRecipeLogo,

                                    filterQuality: FilterQuality.high,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (_, __, ___) => Container(
                                          height: 200,
                                          color: Colors.grey[300],
                                          child: Icon(
                                            Icons.image_not_supported,
                                            size: 48,
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20.0, bottom: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(23),
                                    bottomRight: Radius.circular(23),
                                  ),
                                  color: Colors.green,
                                ),
                                width: double.infinity,
                                height: 45,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  recipes[index].name.toString(),
                                  style: GoogleFonts.alumniSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: recipes.length,
            );
          }
          return Center(
            child: Lottie.asset(
              'assets/lottie/loader.json',
              repeat: true,
              frameRate: FrameRate(120),
              controller: _animationController,
              height: 100,
              width: 100,
            ),
          );
        },
      ),
    );
  }
}
