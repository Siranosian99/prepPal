import 'package:go_router/go_router.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';
import 'package:preppal/presentation/screens/detailed_item_screen.dart';
import 'package:preppal/presentation/screens/favourite.dart';
import 'package:preppal/presentation/screens/guide_screen.dart';
import 'package:preppal/presentation/screens/home_screen.dart';
import 'package:preppal/presentation/screens/inside_cat.dart';
import 'package:preppal/presentation/screens/inside_recipe.dart';
import 'package:preppal/presentation/screens/personel_screen.dart';
import 'package:preppal/service/data/api_service.dart';
import 'package:preppal/service/repository.dart';
import 'package:preppal/utilites/bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return BottomNavBar(child: child); // Contains bottom nav
      },
      routes: [
        GoRoute(
          path: '/',
          name: '/',
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
          path: '/guide',
          name: 'guide',
          builder: (context, state) {
            return BlocProvider(
              create:
                  (context) =>
                      PrepPalCubit(PrepPalRepository(apiService: ApiService())),
              child: GuideScreen(),
            );
          },
        ),
        GoRoute(
          path: '/inside',
          name: 'inside',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return InsideCat(category: extra?['category']);
          },
        ),
        GoRoute(
          path: '/fav',
          name: 'fav',
          builder: (context, state) => FavouriteScreen(),
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
          path: '/recipes',
          name: 'recipes',
          builder: (context, state) {
            return BlocProvider(
              create:
                  (context) =>
                      PrepPalCubit(PrepPalRepository(apiService: ApiService())),
              child: RecipeDetailScreen(),
            );
          },
        ),
      ],
    ),
  ],
);
