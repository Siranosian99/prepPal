import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<MealsById> mls=[];
  late ApiService _apiService;
  @override
  void initState() {
    calldata();
    super.initState();
  }

  Future<void>calldata()async{
    mls= await BlocProvider.of<PrepPalCubit>(context).favList;
    setState(() {
      mls;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.favourite), centerTitle: true,
      actions: [
        IconButton(onPressed: (){
          print("Printing mls:${mls[0]}");
        }, icon: Icon(Icons.print))
      ],),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          false
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
                  itemBuilder: (context,index)=>Container(
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
                  separatorBuilder: (context,index)=>SizedBox(height:10,),
                  itemCount: 2,
                ),
              ),
        ],
      ),
    );
  }
}
