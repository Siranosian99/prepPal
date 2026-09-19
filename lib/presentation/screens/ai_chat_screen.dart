import 'package:flutter/material.dart';
import 'package:preppal/consts/texts.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _queryController=TextEditingController();
  final recipes = [
    {
      'name': 'Creamy Garlic Pasta',
      'duration': 25,
      'difficulty': 'Easy',
      'category': 'Pasta',
    },
    {
      'name': 'Spicy Chicken Tacos',
      'duration': 30,
      'difficulty': 'Medium',
      'category': 'Mexican',
    },
    {
      'name': 'Margherita Pizza',
      'duration': 45,
      'difficulty': 'Medium',
      'category': 'Italian',
    },
    {
      'name': 'Classic Caesar Salad',
      'duration': 15,
      'difficulty': 'Easy',
      'category': 'Salad',
    },
    {
      'name': 'Beef Teriyaki Bowl',
      'duration': 35,
      'difficulty': 'Medium',
      'category': 'Asian',
    },
    {
      'name': 'Chocolate Pancakes',
      'duration': 20,
      'difficulty': 'Easy',
      'category': 'Breakfast',
    },
    {
      'name': 'Creamy Tomato Soup',
      'duration': 30,
      'difficulty': 'Easy',
      'category': 'Soup',
    },
    {
      'name': 'Grilled Salmon',
      'duration': 25,
      'difficulty': 'Medium',
      'category': 'Seafood',
    },
    {
      'name': 'Chicken Alfredo',
      'duration': 40,
      'difficulty': 'Medium',
      'category': 'Pasta',
    },
    {
      'name': 'Berry Cheesecake',
      'duration': 60,
      'difficulty': 'Hard',
      'category': 'Dessert',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.aiTitle),
      ),
      body: Expanded(
        child: Column(

          children: [
            Expanded(
              child: ListView.separated(itemBuilder: (context,index){
                return ListTile(
                  title: Text(recipes[index]['name'] as String),
                  subtitle: Text(recipes[index]['category'] as String),
                  trailing:Text(recipes[index]['difficulty'] as String),
                );
              }, separatorBuilder: (context,index){
                return SizedBox(width: 12,);
              }, itemCount: recipes.length),
            ),
            TextFormField(
              controller: _queryController,
              maxLines: 4,
              minLines: 1,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: AppTexts.txtHintAi,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 8,
                    bottom: 12,
                  ),
                  child: Icon(
                    Icons.restaurant_menu_rounded,
                    size: 22,
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_upward_rounded,
                    ),
                  ),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
