import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/service/model/meals_by_id.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _callCubit();
    super.initState();
  }

  void _callCubit(){
    context.read<PrepPalCubit>().loadFavourites();
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
        title: Text(AppTexts.favourite),
        centerTitle: true,
      ),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is FavLoad) {
           state.favList;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state.favList.isEmpty
                    ? Center(
                      child: Column(
                        children: [
                          Image.asset('assets/images/logo/empty.png'),
                          Text(
                            AppTexts.empty,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            AppTexts.noFood,
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    )
                    : Expanded(
                      child: ListView.separated(
                        itemBuilder:
                            (context, index) {
                            final data=   state.favList[index];
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      "detailed",
                                      extra: {
                                        'imgLink': data.strMealThumb,
                                        'mealId':data.idMeal,
                                        'mealName': data.strMeal,
                                      },
                                    );
                                  },
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius:BorderRadius.circular(10),
                                      child: Image.network(
                                        data.strMealThumb.toString(),
                                      ),
                                    ),
                                    title: Text(data.strMeal.toString()),
                                    trailing: IconButton(
                                      onPressed: () {
                                        context.read<PrepPalCubit>().removeFavouriteList(index);
                                      },
                                      icon: const Icon(Icons.favorite),
                                    ),
                                  ),
                                ),
                              );
                            } ,
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 10),
                        itemCount:   state.favList.length,
                      ),
                    ),
              ],
            );
          }
          return Center(
            child: Lottie.asset(
              'assets/lottie/walk_loader.json',
              repeat: true,
              frameRate: const FrameRate(120),
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
