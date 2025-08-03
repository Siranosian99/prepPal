import 'package:flutter/material.dart';

class SettingsItems extends StatelessWidget {
  final String txt;
  final IconData icon;
  VoidCallback? onTap;
   SettingsItems({super.key,required this.txt,required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text(txt),
        leading: Icon(icon),
      ),
    );
  }
}
