import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:preppal/routes.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/meals_by_id.dart';
import 'package:preppal/theme_provider/theme_data.dart';
import 'package:preppal/theme_provider/theme_state.dart';
import 'package:preppal/utilites/hive_init.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MealsbyCatAdapter());
  Hive.registerAdapter(MealsCatAdapter());
  Hive.registerAdapter(MealsByIdAdapter());
  await Hive.openBox('themes');
  await Hive.openBox<MealsCat>('category');
  await Hive.openBox<MealsById>('byId');
  await Hive.openBox<MealsbyCat>('SeaFood');
  await Hive.openBox<MealsbyCat>('inCat');
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Meal Planner',
      themeMode: themeProvider.themeMode,
      theme: ThemesData.lightTheme,
      darkTheme: ThemesData.darkTheme,
      routerConfig: router,
    );
  }
}

