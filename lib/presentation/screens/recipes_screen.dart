import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';

import '../../service/model/food_fact_model.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _searchProduct() {
    final query = _searchController.text.trim();

    if (query.isEmpty) return;

    context.read<PrepPalCubit>().FoodFactGet(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Nutrition'),
      ),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          return IconButton(onPressed: ()async{
            await   context.read<PrepPalCubit>().FoodFactGet("chicken");
          }, icon: Icon(Icons.send));

        },
      ),
    );
  }
}

// Center(
//               child: Lottie.asset(
//                 'assets/lottie/loader.json',
//                 repeat: true,
//                 frameRate: FrameRate(120),
//                 controller: _animationController,
//                 height: 100,
//                 width: 100,
//               ),
//             );


//Widget content;
//
//           if (state is FoodFactsLoad) {
//             final List<NutritionProduct> products = state.products;
//             if (products.isEmpty) {
//               content = const Center(
//                 child: Text('No products found'),
//               );
//             } else {
//               content = ListView.separated(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: products.length,
//                 separatorBuilder: (_, __) =>
//                 const SizedBox(height: 10),
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text(
//                         product.name ?? 'Unknown product',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       subtitle: Text(
//                         product.brand ?? 'Unknown brand',
//                       ),
//                       trailing: Text(
//                         '${product.calories ?? 0} kcal',
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           } else {
//             content = Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.restaurant_menu_outlined,
//                     size: 64,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Discover Nutrition',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Search for a food to explore its\nnutrition information.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 15,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           return Column(
//             children: [
//               Expanded(
//                 child: content,
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: TextFormField(
//                   controller: _searchController,
//                   textInputAction: TextInputAction.search,
//                   onFieldSubmitted: (_) {
//                     _searchProduct();
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Search food...',
//                     prefixIcon: const Icon(Icons.search),
//                     suffixIcon: IconButton(
//                       onPressed: ()async{
//                       await   context.read<PrepPalCubit>().FoodFactGet(_searchController.text);
//                       },
//                       icon: const Icon(Icons.arrow_forward),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );