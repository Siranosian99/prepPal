import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/texts.dart';

class GuideIcon extends StatelessWidget {
  const GuideIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment:Alignment.bottomLeft,
            children: [
              Image(image: AssetImage('assets/images/guide/health_and_nutrition.jpg')),
              Container(
                  padding:EdgeInsets.only(left: 20.0,bottom: 2),
                  decoration:BoxDecoration(borderRadius:BorderRadius.circular(1),color:Colors.grey[700]),
                  width: double.infinity,
                  height: 40,
                  child:
                  Text(
                    AppTexts.health,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ))],
          ),
        )
      ],
    );
  }
}
