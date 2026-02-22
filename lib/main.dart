import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/sqlite_service.dart';
import 'package:restaurant_app/provider/home_category_provider.dart';
import 'package:restaurant_app/screen/favorite_screen.dart';
import 'common/styles.dart';
import 'provider/restaurant_detail_provider.dart';
import 'provider/restaurant_list_provider.dart';
import 'provider/restaurant_search_provider.dart';
import 'provider/favorite_provider.dart';
import 'data/api/api_service.dart';
import 'screen/home_screen.dart';
import 'screen/search_screen.dart';
import 'screen/detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => SqliteService()),
        Provider(create: (_) => ApiService()),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantSearchProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(context.read<SqliteService>()),
        ),
        ChangeNotifierProvider(create: (context) => HomeCategoryProvider()),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          FavoriteScreen.routeName: (context) => const FavoriteScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == DetailScreen.routeName) {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) {
                return DetailScreen(restaurantId: args);
              },
            );
          }
          return null;
        },
      ),
    );
  }
}
