import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/notification_service.dart';
import 'package:restaurant_app/data/local/shared_preferences_service.dart';
import 'package:restaurant_app/data/local/sqlite_service.dart';
import 'package:restaurant_app/data/local/workmanager_service.dart';
import 'package:restaurant_app/provider/home_category_provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/screen/favorite_screen.dart';
import 'package:restaurant_app/screen/setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/styles.dart';
import 'provider/restaurant_detail_provider.dart';
import 'provider/restaurant_list_provider.dart';
import 'provider/restaurant_search_provider.dart';
import 'provider/favorite_provider.dart';
import 'provider/description_provider.dart';
import 'data/api/api_service.dart';
import 'screen/home_screen.dart';
import 'screen/search_screen.dart';
import 'screen/detail_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  await WorkmanagerService().init();
  await NotificationService().init();
  runApp(MyApp(preferences: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => SqliteService()),
        Provider(create: (_) => ApiService()),
        Provider(create: (_) => SharedPreferencesService(preferences)),
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
        ChangeNotifierProvider(
          create: (context) =>
              SettingProvider(context.read<SharedPreferencesService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => DescriptionProvider()
        ),
      ],
      child: Consumer<SettingProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Restaurant App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: provider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            initialRoute: HomeScreen.routeName,
            routes: {
              HomeScreen.routeName: (context) => const HomeScreen(),
              SearchScreen.routeName: (context) => const SearchScreen(),
              FavoriteScreen.routeName: (context) => const FavoriteScreen(),
              SettingScreen.routeName: (context) => const SettingScreen(),
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
          );
        },
      ),
    );
  }
}
