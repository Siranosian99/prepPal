import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preppal/consts/texts.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                'https://www.themealdb.com/images/media/meals/ypxvwv1505333929.jpg',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                          Icons.arrow_back_sharp, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                          Icons.ios_share_outlined, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // move container upward to overlap image
          Transform.translate(
            offset: const Offset(0, -30),
            child: Container(
              alignment: AlignmentDirectional.topStart,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              width: double.infinity,
              height: 615,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Title is here",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.heart))
                ],
              ),
              SizedBox(height: 230,),
              Text("The Description is here Bro"),
              SizedBox(height:210,),
              ElevatedButton(onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize:Size(double.maxFinite,50),
                  backgroundColor:Colors.green
                ),
                child: Text(AppTexts.detail,style:TextStyle(
                  color:Colors.white
                ),),)
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}
