import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/navigation/navigation_mixin.dart';
import 'package:preppal/service/data/api_service.dart';
import 'package:preppal/service/model/meal_model.dart';

import '../widgets/category_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with NavigatorMixin{
  PageController _pageController = PageController();
  List<MealsModel> meals=[];
  late ApiService _apiService;
  @override
  void initState() {
    callData();
    super.initState();
  }
  Future<List<MealsModel>>callData()async{
    meals=await _apiService.('i')?? [];
    return meals;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(AppTexts.prepPal),
        actions: [IconButton(onPressed: () {
        }, icon: (Icon(Icons.search)))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) =>
                 Image.network('https://picsum.photos/200',scale: 1,)),
            ),
            SizedBox(height: 25),
            Text(AppTexts.explorer,textAlign: TextAlign.center,style:TextStyle(
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 15),
            SizedBox(
                height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CategoryIcon(txt:meals[index].idIngredient.toString(),scale: 22,),
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemCount: meals.length,
              ),
            ),
            Text(AppTexts.trending,textAlign: TextAlign.center,style:TextStyle(
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 15),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CategoryIcon(txt:meals[index].idIngredient.toString(),scale: 12,),
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemCount: meals.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
