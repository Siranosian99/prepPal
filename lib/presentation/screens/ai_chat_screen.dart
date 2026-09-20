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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.aiTitle)),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is AiRecipesLoad) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text( state.aiRecipes[index].name ?? ''),
                        subtitle: Text(
                          state.aiRecipes[index].steps?.join('\n') ?? '',
                        ),
                        trailing: Text(
                          state.aiRecipes[index].ingredients?.join(', ') ?? '',
                        )
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height : 12);
                    },
                    itemCount: state.aiRecipes.length,
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
                        onPressed: ()async {
                          await   context.read<PrepPalCubit>().AiRecipesGet(_queryController.text);
                        },
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
            );
          }
          return Column(
            children: [
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
                      onPressed: ()async {
                     await   context.read<PrepPalCubit>().AiRecipesGet(_queryController.text);

                      },
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
