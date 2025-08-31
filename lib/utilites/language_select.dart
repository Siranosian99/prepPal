import 'package:flutter/material.dart';

class LanguageSelect extends StatefulWidget {
  @override
  _LanguageSelectState createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  String? selectedLang = "splash_screen"; // default value

  final List<Map<String, String>> languages = [
    {"code": "splash_screen", "name": "English"},
    {"code": "ar", "name": "Arabic"},
    {"code": "hy", "name": "Armenian"},
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
      onChanged: (value) {
        setState(() {
          selectedLang = value;
        });
      },
    );
  }
}
