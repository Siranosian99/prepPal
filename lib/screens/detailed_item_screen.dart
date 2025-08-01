import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/service/data/api_service.dart';
import 'package:preppal/service/model/meals_by_id.dart';

import '../widgets/container_detailed.dart'; // Assume this defines AppTexts.about

class DetailedItemScreen extends StatefulWidget {
  int index;
  String mealId;
  String imgLink;
  String mealName;
  DetailedItemScreen({super.key,required this.mealId,required this.imgLink,required this.mealName,required this.index});

  @override
  State<DetailedItemScreen> createState() => _DetailedItemScreenState();
}

class _DetailedItemScreenState extends State<DetailedItemScreen> {
  List<MealsById> meals = [];
  late final ApiService _apiService;

  // Dummy data
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<List<MealsById>?> fetchData() async {
    _apiService = ApiService();
    meals = await _apiService.GetMealsById(widget.mealId) ?? [];
    setState(() {
      meals;
    });
    print(meals);
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Image with food name and heart icon
          Stack(
            children: [
              Image.network(
              widget.imgLink,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                     widget.mealName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print(meals[0].strInstructions.toString()?? '');
                        // print(meals[].strInstructions?? '');
                      },
                      icon: Icon(Icons.favorite_border),
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Main container below image

        ],
      ),
    );
  }
}


