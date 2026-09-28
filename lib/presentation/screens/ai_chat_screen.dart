import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preppal/consts/texts.dart';

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
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorData = Theme.of(context).textTheme.bodyMedium?.color;
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
                            final data = state.aiRecipes[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),

                              title: Text(
                                data.name ?? '',
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
                                      TextSpan(
                                        text: 'Ingredients: ',
                                        style: TextStyle(
                                          color: colorData,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        style: TextStyle(color: colorData),
                                        text:
                                            data.ingredients?.join(', ') ?? '',
                                      ),

                                      TextSpan(
                                        text: '\n\nSteps:\n',
                                        style: TextStyle(
                                          color: colorData,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),

                                      TextSpan(
                                        style: TextStyle(color: colorData),
                                        text: data.steps?.join('\n') ?? '',
                                      ),
                                      const TextSpan(text: '\n'),
                                      TextSpan(
                                        text: 'Difficulty: ',
                                        style: TextStyle(color: colorData),
                                      ),
                                      TextSpan(
                                        style: TextStyle(color: colorData),
                                        text: data.difficulty ?? 'Unknown',
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              trailing: IconButton(
                                onPressed: () async {
                                  final text = '''
                                                 ${data.name ?? ''}
                                                  Ingredients:
                                                 ${data.ingredients?.join('\n') ?? ''}
                                                     Steps:
                                                 ${data.steps?.join('\n') ?? ''}
                                                 ''';

                                  await Clipboard.setData(
                                    ClipboardData(text: text),
                                  );

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Recipe copied!'),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.copy),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 12);
                          },
                          itemCount: state.aiRecipes.length,
                        )
                        : Center(child: Text(AppTexts.whatCook)),
              ),

              if (isLoading)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        size: 18,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'AI is thinking...',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: !isLoading,
                  controller: _queryController,
                  onChanged: (_) {
                    setState(() {});
                  },
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
                      padding: EdgeInsets.only(left: 16, right: 8, bottom: 12),
                      child: Icon(Icons.restaurant_menu_rounded, size: 22),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        onPressed:_queryController.text.isEmpty? null: () async {
                          await context.read<PrepPalCubit>().AiRecipesGet(
                            _queryController.text,
                          );
                          _queryController.clear();
                        },
                        icon:
                            isLoading
                                ? const Icon(Icons.stop_circle_outlined)
                                : const Icon(Icons.arrow_upward_rounded),
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
              ),
            ],
          );
        },
      ),
    );
  }
}
