import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/screen/detail_screen.dart';
import 'package:restaurant_app/screen/search_screen.dart';
import '../provider/restaurant_list_provider.dart';
import '../static/result_state.dart';
import '../common/styles.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [const Text("Restaurant")]),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
            icon: const Icon(Icons.search),
          ),
        ],
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  leading: Hero(
                    tag: restaurant.pictureId,
                    child: Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4,),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.city,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                      ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(width: 4,),
                          Text("${restaurant.rating}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )
                    ],
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
            return const Center(child: Text("Memuat data....."));
          }
        },
      ),
    );
  }
}
