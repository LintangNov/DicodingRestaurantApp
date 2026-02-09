import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/screen/detail_screen.dart';
import 'package:restaurant_app/screen/search_screen.dart';
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
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant App"),
        actions: [IconButton(onPressed: () {
          Navigator.pushNamed(context, SearchScreen.routeName);
        }, icon: const Icon(Icons.search))],
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, child) {
          final state = provider.state;

          if (state is ResultStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResultStateError) {
            return Center(
              child: Text("Error: ${(state as ResultStateError).error}"),
            );
          } else if (state is ResultStateSuccess) {
            final restaurants = (state as ResultStateSuccess).data.restaurants;

            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return ListTile(
                  title: Text(restaurant.name),
                  subtitle: Text(restaurant.city),
                  leading: Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                    width: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, error, StackTrace) =>
                        const Icon(Icons.error),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailScreen.routeName,
                      arguments: restaurant.id,
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text("Memuat data....."),);
          }
        },
      ),
    );
  }
}
