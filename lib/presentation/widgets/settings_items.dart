import 'package:flutter/material.dart';

class SettingsItems extends StatelessWidget {
  final String txt;
  final IconData icon;
  final VoidCallback onTap;
   SettingsItems({super.key,required this.txt,required this.icon,required this.onTap});

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
