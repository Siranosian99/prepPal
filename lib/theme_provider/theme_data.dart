import 'package:flutter/material.dart';

class ThemesData {

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.green,
    iconTheme: IconThemeData(color: Colors.green),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
    ),
    dividerColor:Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.green),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      elevation: 0,
    ),

  );


  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.green,
    iconTheme: IconThemeData(color: Colors.green),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
    ),
    dividerColor:Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.green),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      elevation: 0,
    ),
  );
}
