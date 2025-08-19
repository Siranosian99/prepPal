import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:preppal/buisnes_logic/prep_pal_cubit.dart';
import 'package:preppal/consts/texts.dart';
import 'package:preppal/service/data/api_service.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/meals_by_id.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with TickerProviderStateMixin {
  List<MealsById> mls = [];
  late final AnimationController _animationController;
  late ApiService _apiService;

  @override
  void initState() {
    _callCubit();
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
    super.initState();
  }

  void _callCubit(){
    var myBox =Hive.box<MealsById>('save');
    mls = myBox.values.toList();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.favourite),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.print),
          ),
        ],
      ),
      body: BlocBuilder<PrepPalCubit, PrepPalState>(
        builder: (context, state) {
          if (state is FavLoad) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mls.isEmpty
                    ? Center(
                      child: Column(
                        children: [
                          Image.asset('assets/images/logo/empty.png'),
                          Text(
                            AppTexts.empty,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            AppTexts.noFood,
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    )
                    : Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(12),
                        itemBuilder:
                            (context, index) => Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: ListTile(
                                leading: Image.network(
                                  'https://picsum.photos/200/300',
                                ),
                                title: Text(mls[0].idMeal.toString()),
                                subtitle: Text("this is Sub"),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite),
                                ),
                              ),
                            ),
                        separatorBuilder:
                            (context, index) => SizedBox(height: 10),
                        itemCount: 2,
                      ),
                    ),
              ],
            );
          }
          return Center(
            child: Lottie.asset(
              'assets/lottie/walk_loader.json',
              repeat: true,
              frameRate: FrameRate(120),
              controller: _animationController,
              height: 100,
              width: 100,
            ),
          );
        },
      ),
    );
  }
}
