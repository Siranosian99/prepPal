import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';

class CategoryIcon extends StatelessWidget {
  double scale;
   CategoryIcon({super.key,required this.scale});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/foods/banana_pancakes.jpg',scale: scale,),
        Text(AppTexts.breakf)
      ],
    );
  }
}
