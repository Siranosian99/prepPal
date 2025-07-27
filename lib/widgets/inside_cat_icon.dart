import 'package:flutter/material.dart';

class InsideCatIcon extends StatelessWidget {
  final String imgLink;
  final String txt;

  const InsideCatIcon({super.key, required this.imgLink, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(imgLink),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: Colors.red,
            ),
            height: 50,
            width: double.infinity,
            child:Column(children: [
              Text(txt),
            ],),
          ),
        ],
      ),
    );
  }
}
