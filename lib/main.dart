import 'package:flutter/material.dart';
import 'package:preppal/routes.dart';
import 'package:preppal/screens/favourite.dart';
import 'package:preppal/screens/guide_screen.dart';
import 'package:preppal/screens/personel_screen.dart';
import 'screens/home_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Meal Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}

