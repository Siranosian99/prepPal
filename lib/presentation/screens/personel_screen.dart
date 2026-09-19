import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';
import 'package:provider/provider.dart';

import '../../core/theme_provider/theme_state.dart';
import '../widgets/settings_items.dart';

class PersonelScreen extends StatefulWidget {
  const PersonelScreen({super.key});

  @override
  State<PersonelScreen> createState() => _PersonelScreenState();
}

class _PersonelScreenState extends State<PersonelScreen> {


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar:AppBar(
        title:Text(AppTexts.settings),
        centerTitle:true,
      ),
      body:Column(
        children: [
          // SizedBox(height: 25,),
          // SettingsItems(txt: AppTexts.signIn, icon: Icons.login),
          // Divider(
          //   thickness: 1,
          //   height: 10, // space above/below
          // ),
          // SettingsItems(txt: AppTexts.vegt, icon: Icons.nature),
          // Divider(
          //   thickness: 1,
          //   height: 10, // space above/below
          // ),
          SettingsItems(onTap:(){
            print(themeProvider.isDark);
          },txt: AppTexts.report, icon:Icons.report),
          Divider(

            thickness: 1,
            height: 10, // space above/below
          ),
          SettingsItems(txt: AppTexts.themes, icon:Icons.switch_left_rounded,onTap: (){
          themeProvider.themeSwitch();
          },),
          // Switch(
          //   value: themeProvider.isDark,
          //   onChanged: (_) {
          //     themeProvider.themeSwitch();
          //   },
          // ),

          Divider(
            thickness: 1,
            height: 10, // space above/below
          ),
        ],
      ),
    );
  }
}
