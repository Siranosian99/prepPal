import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LanguageSelect extends StatefulWidget {
  @override
  _LanguageSelectState createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  String? selectedLang = "en"; // default value
  final box= Hive.box('language');
  final List<Map<String, String>> languages = [
    {"code": "en", "name": "English"},
    {"code": "ar", "name": "Arabic"},
    {"code": "hy", "name": "Armenian"},
    {"code": "es", "name": "Spanish"},
    {"code": "de", "name": "German"},
    {"code": "tr", "name": "Turkish"},
  ];

  @override
  Widget build(BuildContext context) {
    return  DropdownButton<String>(
      value: selectedLang,
      items: languages.map((lang) {
        return DropdownMenuItem<String>(
          value: lang["code"],
          child: Text(lang["name"]!),
        );
      }).toList(),
      onChanged: (value) async{
        setState(() {
          selectedLang = value;
        });
        box.put('language', value);
      },
    );
  }
}


//  void saveThemeData() {
//     box.put('isDarkMode', isDark);
//     notifyListeners();
//   }
//   void loadThemeMode() {
//    isDark= box.get('isDarkMode', defaultValue: false);
//    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }
//   var box = Hive.box('themes');
//   bool isDark = false;