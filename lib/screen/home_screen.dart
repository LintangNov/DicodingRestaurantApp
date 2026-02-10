import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/home_category_provider.dart';
import 'package:restaurant_app/screen/home_screen_widgets.dart';
import '../provider/restaurant_list_provider.dart';
import '../static/result_state.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedCategoryIndex = 0;
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context),
            const SizedBox(height: 16),
            buildCategoryChips(context, _selectedCategoryIndex),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer3<HomeCategoryProvider,FavoriteProvider, RestaurantListProvider>(
                builder: (context, categoryProvider, favoriteProvider, listProvider, child) {
                  final state = listProvider.state;

                  if (state is ResultStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ResultStateError) {
                    return Center(
                      child: Text(
                        "Error: ${(state as ResultStateError).error}",
                      ),
                    );
                  } else if (state is ResultStateSuccess) {
                    final restaurants =
                        (state as ResultStateSuccess).data.restaurants;

                    final displayedRestaurants = categoryProvider.index == 1
                        ? restaurants
                            .where((r) => favoriteProvider.isFavorite(r.id))
                            .toList()
                        : restaurants;

                    if (displayedRestaurants.isEmpty && categoryProvider.index == 1) {
                      return const Center(
                        child: Text("No favorite restaurants found."),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      itemCount: displayedRestaurants.length,
                      itemBuilder: (context, index) {
                        return buildRestaurantItem(context, displayedRestaurants[index], favoriteProvider);
                      },
                    );
                  } else {
                    return const Center(child: Text("Loading data...."));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
