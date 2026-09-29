import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:preppal/consts/texts.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider/theme_state.dart';
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
      appBar: AppBar(title: Text(AppTexts.settings), centerTitle: true),
      body: Column(
        children: [
          SettingsItems(onTap: () {}, txt: AppTexts.report, icon: Icons.report),
          const Divider(
            thickness: 1,
            height: 10,
          ),
          SettingsItems(
            txt: AppTexts.themes,
            icon: Icons.switch_left_rounded,
            onTap: () {
              themeProvider.themeSwitch();
            },
          ),
          const Divider(
            thickness: 1,
            height: 10, 
          ),
          SettingsItems(
            txt: AppTexts.toolFunction,
            icon: Icons.data_exploration,
            onTap: () {
              context.goNamed("tool");
            },
          ),
        ],
      ),
    );
  }
}


