import 'package:flutter/material.dart';
import '../consts/texts.dart';

class ContainerDetailed extends StatelessWidget {
  String about;
   ContainerDetailed({
    super.key,
    required this.about
  });


  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        width: double.infinity,
        height:665,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text(textAlign: TextAlign.start,
             AppTexts.about,style:TextStyle(
               fontSize:20,
               fontWeight: FontWeight.bold
           ),),
            SizedBox(height: 10,),
            Text(textAlign: TextAlign.start,
              about,style:TextStyle(
                  fontSize:15,
                  fontWeight: FontWeight.w400
              ),),
            Divider(color:Colors.black,),
            Text(textAlign: TextAlign.start,
              AppTexts.ingredients,style:TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.bold
              ),),
            SizedBox(height: 10,),
            Text(textAlign: TextAlign.start,
              about,style:TextStyle(
                  fontSize:15,
                  fontWeight: FontWeight.w400
              ),),
            Divider(color:Colors.black,),
            ElevatedButton(
              onPressed: () {
                // Add your logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // background color
                foregroundColor: Colors.white, // text color
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Add to Shopping List',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        )
      ),
    );
  }
}
