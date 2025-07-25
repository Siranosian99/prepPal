import 'package:flutter/material.dart';
class InsideCatIcon extends StatelessWidget {
  final String imgLink;
  const InsideCatIcon({super.key,required this.imgLink});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(12),
      decoration:BoxDecoration(borderRadius:BorderRadius.circular(12)),
      child:
        Stack(
          alignment:Alignment.bottomCenter,
          children: [
            Image.network(imgLink),
            Container(

              decoration:BoxDecoration(borderRadius: BorderRadius.only(bottomLeft:Radius.circular(12),bottomRight:Radius.circular(12)),  color:Colors.red,),
              height: 50,
              width: double.infinity,

            )
          ],
        ),
    );
  }
}
