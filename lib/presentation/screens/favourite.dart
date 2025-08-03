import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(AppTexts.favourite),
        centerTitle: true,
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          true ? Center(
            child: Column(
              children: [
                Image.asset('assets/images/logo/empty.png'),
                Text(AppTexts.empty,style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),),
                Text(AppTexts.noFood,style:TextStyle(
                  color:Colors.grey[500]
                ),)
              ],
            ),
          ):Text('data'),
        ],
      ),
    );
  }
}
