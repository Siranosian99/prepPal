import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  void dispose() {
    super.dispose();
    _queryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.aiTitle)),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          final isLoading = state is AiRecipesLoad && state.isLoading;
          return Column(
            children: [
              Expanded(
                child:
                    state is AiRecipesLoad
                        ? ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),

                              title: Text(
                                state.aiRecipes[index].name ?? '',
                                style: const TextStyle(
                                  fontFamily: 'sans-serif',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                  letterSpacing: 0.2,
                                ),
                              ),

                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontFamily: 'sans-serif',
                                      color: Colors.black87,
                                      fontSize: 14,
                                      height: 1.6,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Ingredients: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            state.aiRecipes[index].ingredients
                                                ?.join(', ') ??
                                            '',
                                      ),

                                      const TextSpan(
                                        text: '\n\nSteps:\n',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),

                                      TextSpan(
                                        text:
                                            state.aiRecipes[index].steps?.join(
                                              '\n',
                                            ) ??
                                            '',
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              trailing: Text(
                                state.aiRecipes[index].difficulty ?? '',
                                style: const TextStyle(
                                  fontFamily: 'sans-serif',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 12);
                          },
                          itemCount: state.aiRecipes.length,
                        )
                        : const Center(child: Text('What can I cook today?')),
              ),
              TextFormField(
                enabled: isLoading,
                controller: _queryController,
                maxLines: 4,
                minLines: 1,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: AppTexts.txtHintAi,
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16, right: 8, bottom: 12),
                    child: Icon(Icons.restaurant_menu_rounded, size: 22),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      onPressed: () async {
                        await context.read<PrepPalCubit>().AiRecipesGet(
                          _queryController.text,
                        );
                        _queryController.clear();
                      },
                      icon:
                          isLoading
                              ? Icon(Icons.stop_circle_outlined)
                              : Icon(Icons.arrow_upward_rounded),
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
        },
      ),
    );
  }
}

//
//Lottie.asset(
//               'assets/lottie/loading_food.json',
//               repeat: true,
//               frameRate: FrameRate(120),
//               controller: _animationController,
//               height: 100,
//               width: 100,
//             ),
