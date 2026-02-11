import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screen/widget/error_state_widget.dart';
import '../provider/restaurant_search_provider.dart';
import '../provider/favorite_provider.dart';
import '../static/result_state.dart';
import 'home_screen_widgets.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search_screen';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<RestaurantSearchProvider>();
    _searchController.text = provider.query;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Consumer<RestaurantSearchProvider>(
                builder: (context, searchProvider, _) {
                  return Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search restaurants...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          suffixIcon: searchProvider.query.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    searchProvider.clearSearch();
                                  },
                                )
                              : null,
                        ),
                        onChanged: (query) {
                          searchProvider.fetchSearchRestaurant(query);
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
          ),

          Consumer2<RestaurantSearchProvider, FavoriteProvider>(
            builder: (context, searchProvider, favoriteProvider, child) {
              final state = searchProvider.state;

              if (state is ResultStateLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false, 
                  child: Center(child: CircularProgressIndicator()),
                );
                
              } else if (state is ResultStateSuccess) {
                final restaurants = (state as ResultStateSuccess).data.restaurants;

                if (restaurants.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildMessage(
                      context,
                      Icons.search_off,
                      "Can't find any restaurants matching your search.",
                    ),
                  );
                }

                
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return buildRestaurantItem(
                          context,
                          restaurants[index],
                          favoriteProvider,
                        );
                      },
                      childCount: restaurants.length,
                    ),
                  ),
                );
                
              } else if (state is ResultStateError) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorStateWidget(
                    message: (state as ResultStateError).error,
                    onRetry: () {
                      final query = context.read<RestaurantSearchProvider>().query;
                      if (query.isNotEmpty) {
                        context
                            .read<RestaurantSearchProvider>()
                            .fetchSearchRestaurant(query);
                      }
                    },
                  ),
                );
                
              } else {
                return SliverFillRemaining(
                  hasScrollBody: false, 
                  child: _buildMessage(
                    context,
                    Icons.restaurant,
                    "Start typing to search for restaurants.",
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
  Widget _buildMessage(BuildContext context, IconData icon, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
