import 'package:go_router/go_router.dart';
import 'package:preppal/screens/detailed_item_screen.dart';
import 'package:preppal/screens/favourite.dart';
import 'package:preppal/screens/guide_screen.dart';
import 'package:preppal/screens/home_screen.dart';
import 'package:preppal/screens/inside_cat.dart';
import 'package:preppal/screens/item_screen.dart';
import 'package:preppal/screens/main_screen.dart';
import 'package:preppal/screens/personel_screen.dart';
import 'package:preppal/utilites/bottom_nav_bar.dart';

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
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/guide',
          name: 'guide',
          builder: (context, state) => GuideScreen(),
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
            return DetailedItemScreen(
                index:extra?['index'],
                mealName: extra?['mealName'],
                imgLink:extra?['imgLink'],
                mealId: extra?['mealId']);
          },
        ),
      ],
    ),
  ],
);
