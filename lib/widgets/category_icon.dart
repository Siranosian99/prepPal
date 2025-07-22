import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';

class CategoryIcon extends StatelessWidget {
  double scale;
  String txt;
   CategoryIcon({super.key,required this.scale,required this.txt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/foods/banana_pancakes.jpg',scale: scale,),
        Text(txt)
      ],
    );
  }
}
