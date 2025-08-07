import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preppal/consts/texts.dart';

import '../widgets/guide_icon.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppTexts.recipes),
        actions: [IconButton(onPressed: () {}, icon: (Icon(Icons.search)))],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => GuideIcon(onTap:(){
          context.goNamed('recipes');
        },),
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemCount: 1,
      ),
    );
  }
}
