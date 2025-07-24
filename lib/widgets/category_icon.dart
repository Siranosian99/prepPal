import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';

class CategoryIcon extends StatelessWidget {
  double scale;
  String imgLink;
  String txt;
   CategoryIcon({super.key,required this.scale,required this.txt,required this.imgLink});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(imgLink,scale: scale,),
        Text(txt,maxLines: 1,overflow:TextOverflow.ellipsis ,)
      ],
    );
  }
}
