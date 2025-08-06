import 'package:flutter/material.dart';
import 'package:preppal/routes.dart';
import 'package:preppal/theme_provider/theme_data.dart';
import 'package:preppal/theme_provider/theme_state.dart';
import 'package:provider/provider.dart';

void main() {
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

