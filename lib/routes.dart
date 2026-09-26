import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';
import 'package:preppal/presentation/screens/ai_chat_screen.dart';
import 'package:preppal/presentation/screens/detailed_item_screen.dart';
import 'package:preppal/presentation/screens/favourite.dart';
import 'package:preppal/presentation/screens/recipes_screen.dart';
import 'package:preppal/presentation/screens/home_screen.dart';
import 'package:preppal/presentation/screens/inside_cat.dart';
import 'package:preppal/presentation/screens/personel_screen.dart';
import 'package:preppal/presentation/screens/splash_screen.dart';
import 'package:preppal/service/data/api_service.dart';
import 'package:preppal/service/repository/repository.dart';
import 'package:preppal/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return BottomNavBar(child: child); // Contains bottom nav
      },
      routes: [
        GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => SplashScreen(),
      ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) {
            return BlocProvider(
              create:
                  (context) => PrepPalCubit(
                    PrepPalRepository(apiService: ApiService())..CatCall(),
                  ),
              child: HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: '/nutrition',
          name: 'nutrition',
          builder: (context, state) {
            return BlocProvider(
              create:
                  (context) =>
                      PrepPalCubit(PrepPalRepository(apiService: ApiService())),
              child: NutritionScreen(),
            );
          },
        ),
        GoRoute(
          path: '/inside',
          name: 'inside',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return BlocProvider(
              create:
                  (context) =>
                      PrepPalCubit(PrepPalRepository(apiService: ApiService())),
              child: InsideCat(category: extra?['category']),
            );
          },
        ),
        GoRoute(
          path: '/fav',
          name: 'fav',
          builder: (context, state) {
            return BlocProvider(
              create:
                  (context) =>
                      PrepPalCubit(PrepPalRepository(apiService: ApiService())),
              child: FavouriteScreen(),
            );
          },
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => PersonelScreen(),
        ),
        GoRoute(
          path: '/detailed',
          name: 'detailed',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return BlocProvider(
              create:
                  (context) =>
                      PrepPalCubit(PrepPalRepository(apiService: ApiService())),
              child: DetailedItemScreen(
                mealName: extra?['mealName'],
                imgLink: extra?['imgLink'],
                mealId: extra?['mealId'],
              ),
            );
          },
        ),
        GoRoute(
          path: '/ai',
          name: 'ai',
          builder: (context, state) => AiChatScreen(),
        ),
        // GoRoute(
        //   path: '/recipes',
        //   name: 'recipes',
        //   builder: (context, state) {
        //     return BlocProvider(
        //       create:
        //           (context) =>
        //               PrepPalCubit(PrepPalRepository(apiService: ApiService())),
        //       child: GuideScreen(),
        //     );
        //   },
        // ),
      ],
    ),
  ],
);
