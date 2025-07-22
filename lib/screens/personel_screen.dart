import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/widgets/settings_items.dart';

class PersonelScreen extends StatefulWidget {
  const PersonelScreen({super.key});

  @override
  State<PersonelScreen> createState() => _PersonelScreenState();
}

class _PersonelScreenState extends State<PersonelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(AppTexts.settings),
        centerTitle:true,
      ),
      body:Column(
        children: [
          SizedBox(height: 25,),
          SettingsItems(txt: AppTexts.signIn, icon: Icons.login),
          Divider(
            color: Colors.grey,
            thickness: 1,
            height: 10, // space above/below
          ),
          SettingsItems(txt: AppTexts.vegt, icon: Icons.nature),
          Divider(
            color: Colors.grey,
            thickness: 1,
            height: 10, // space above/below
          ),
          SettingsItems(txt: AppTexts.feed, icon:Icons.feedback_outlined),
          Divider(
            color: Colors.grey,
            thickness: 1,
            height: 10, // space above/below
          ),
          SettingsItems(txt: AppTexts.themes, icon:Icons.switch_left_rounded),
          Divider(
            color: Colors.grey,
            thickness: 1,
            height: 10, // space above/below
          ),
        ],
      ),
    );
  }
}
