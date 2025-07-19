import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';

import '../widgets/category_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.prepPal),
        actions: [IconButton(onPressed: () {}, icon: (Icon(Icons.search)))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // PageView.builder(
            //   controller: _pageController,
            //     itemCount: 3,
            //     itemBuilder: (context, index) =>
            //    Image)
            SizedBox(height: 200),
            Text(AppTexts.explorer,textAlign: TextAlign.center,),
            SizedBox(height: 15),
            SizedBox(
                height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CategoryIcon(),
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemCount: 5,
              ),
            ),
            Text(AppTexts.trending,textAlign: TextAlign.center,),
            SizedBox(height: 15),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CategoryIcon(),
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
