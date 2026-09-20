import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/service/model/ai_recipes_model.dart';

import '../../buisnes_logic/prep_pal_cubit.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _queryController = TextEditingController();
  List<AiRecipeModel> recipes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.aiTitle)),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is AiRecipesLoad) {
             recipes = state.aiRecipes;
            return Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(recipes[index].name as String),
                          subtitle: Text(recipes[index].steps as String),
                          trailing: Text(
                              recipes[index].difficulty as String,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 12);
                      },
                      itemCount: recipes.length,
                    ),
                  ),
                  TextFormField(
                    controller: _queryController,
                    maxLines: 4,
                    minLines: 1,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: AppTexts.txtHintAi,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 8,
                          bottom: 12,
                        ),
                        child: Icon(Icons.restaurant_menu_rounded, size: 22),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_upward_rounded),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text('data'),
          );
          //Lottie.asset(
          //               'assets/lottie/loading_food.json',
          //               repeat: true,
          //               frameRate: FrameRate(120),
          //               controller: _animationController,
          //               height: 100,
          //               width: 100,
          //             ),
        },
      ),
    );
  }
}

//BlocBuilder<PrepPalCubit, PrepPalState>(
//           builder: (context, state) {
//           if (state is CatLoaded) {
//             random = state.random;
//             return Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     alignment:Alignment.bottomLeft,
//                     children: [
//                       SizedBox(
//                         height: 200,
//                         child: PageView(
//                           physics: NeverScrollableScrollPhysics(),
//                           controller: _pageController,
//                           // default starts at index 0
//                           children: [
//                             GestureDetector(
//                               onTap: () async{
//                                await context.read<PrepPalCubit>().AiRecipesGet('chicken, rice, tomato');
//                                 // context.pushNamed(
//                                 //   "detailed",
//                                 //   extra: {
//                                 //     'imgLink': random[0].strMealThumb,
//                                 //     'mealId': random[0].idMeal,
//                                 //     'mealName': random[0].strMeal,
//                                 //   },
//                                 // );
//                               },
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(21),
//                                 child: Image.network(
//                                   random[0].strMealThumb ?? '',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.indigo,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           random[0].strMeal.toString(),
//                           style: GoogleFonts.poppins(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 1.2,
//                             shadows: [
//                               Shadow(
//                                 offset: Offset(1, 1),
//                                 blurRadius: 3,
//                                 color: Colors.green,
//                               ),
//                             ],
//                           ),
//                           textAlign: TextAlign.center,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 2,
//                         ),
//                       )
//
//
//                     ],
//                   ),
//                   SizedBox(height: 25),
//                   Text(
//                     AppTexts.explorer,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 15),
//                   SizedBox(
//                     height: 120,
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder:
//                           (context, index) => GestureDetector(
//                             onTap: () {
//                               context.pushNamed(
//                                 'inside',
//                                 extra: {'category': mlsCat[index].strCategory},
//                               );
//                             },
//                             child: CategoryIcon(
//                               imgLink:
//                                   mlsCat[index].strCategoryThumb.toString(),
//                               txt: mlsCat[index].strCategory.toString(),
//                               scale: 3.4,
//                             ),
//                           ),
//                       separatorBuilder: (context, index) => SizedBox(width: 20),
//                       itemCount: mlsCat.length,
//                     ),
//                   ),
//                   Text(
//                     AppTexts.trending,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 15),
//                   SizedBox(
//                     height: 200,
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder:
//                           (context, index) => GestureDetector(
//                             onTap: () {
//                               context.pushNamed(
//                                 "detailed",
//                                 extra: {
//                                   'imgLink': mlsByCt[index].strMealThumb,
//                                   'mealId': mlsByCt[index].idMeal,
//                                   'mealName': mlsByCt[index].strMeal,
//                                 },
//                               );
//                             },
//                             child: CategoryIcon(
//                               imgLink: mlsByCt[index].strMealThumb.toString(),
//                               txt: mlsByCt[index].strMeal.toString(),
//                               scale: 4,
//                             ),
//                           ),
//                       separatorBuilder: (context, index) => SizedBox(width: 20),
//                       itemCount: mlsByCt.length,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return Center(
//             child: Lottie.asset(
//               'assets/lottie/loading_food.json',
//               repeat: true,
//               frameRate: FrameRate(120),
//               controller: _animationController,
//               height: 100,
//               width: 100,
//             ),
//           );
//         },
//       ),
