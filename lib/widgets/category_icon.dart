import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/foods/banana_pancakes.jpg',scale: 21,),
        Text(AppTexts.breakf)
      ],
    );
  }
}
