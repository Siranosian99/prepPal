import 'package:flutter/material.dart';

import '../widgets/inside_cat_icon.dart';

class InsideCat extends StatefulWidget {
  const InsideCat({super.key});

  @override
  State<InsideCat> createState() => _InsideCatState();
}

class _InsideCatState extends State<InsideCat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.separated(itemBuilder: (context,index)=>, separatorBuilder: (context,index)=>, itemCount: itemCount)
    );
  }
}
