import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/restaurant_list_provider.dart';
import '../static/result_state.dart';
import '';

class HomeScreen extends StatefulWidget {

  static const routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();

    Future.microtask((){
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant App"),
        actions: [
          IconButton(
            onPressed: (){

            }, 
            icon: const Icon(Icons.search),
            ),
        ],
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, child){
          final state = provider.state;

          if (state is ResultStateLoading) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (state is ResultStateError){
            return Center(child: Text("Error: ${(state as ResultStateError).error}"));
          } else if (state is ResultStateSuccess){
            final restaurants = (state as ResultStateSuccess).data.restaurants;

            // disini builder
          }
        },),
    );
  }
}