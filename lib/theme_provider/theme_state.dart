import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  var box = Hive.box('themes');
  bool isDark = false;

  ThemeProvider(){
    isDark;
  }

  void themeSwitch() {
    isDark = !isDark;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    saveThemeData();
    print(isDark);
    notifyListeners();
  }
  void saveThemeData() {
    // Save bool
    box.put('isDarkMode', isDark);
    notifyListeners();
  }
  void loadThemeMode() {
    var box = Hive.box('themes').get('isDarkMode', defaultValue: false);;
    notifyListeners();
  }


}
