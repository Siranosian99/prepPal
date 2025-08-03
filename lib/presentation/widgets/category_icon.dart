import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';

class CategoryIcon extends StatelessWidget {
  double scale;
  String imgLink;
  String txt;

  CategoryIcon(
      {super.key, required this.scale, required this.txt, required this.imgLink});

  @override
  Widget build(BuildContext context) {
    final double size = scale == 3.4 ? 40 : 85;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Image.network(imgLink, scale: scale,width: size*2,height: size*2,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: size*2,
                  height: size*2,
                  color: Colors.grey[300],
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (_, __, ___) =>
                  Container(
                    width: size*2,
                    height: size*2,
                    color: Colors.red[300],
                    child: const Icon(Icons.image_not_supported, size: 48),
                  ), fit:BoxFit.cover),
        ),
        const SizedBox(height: 10),
        Text(
          txt,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}