import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/favorite_provider.dart';
import 'home_screen_widgets.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite_screen';
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState(){
    super.initState();
    Future.microtask((){
      context.read<FavoriteProvider>().loadAllFavorites();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Restaurants"),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child){
          final favorites = provider.favorites;

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border, size: 80, color: Colors.grey,),
                  const SizedBox(height: 16,),
                  Text(
                    "You don't have any favorites yet",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ), 
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: favorites.length,
            itemBuilder: (context, index){
              final restaurant = favorites[index];
              return buildRestaurantItem(context, restaurant, provider);
            },
          );
        }
        ),
    );
  }
}