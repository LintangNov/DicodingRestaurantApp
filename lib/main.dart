import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/styles.dart';
import 'provider/restaurant_detail_provider.dart';
import 'provider/restaurant_list_provider.dart';
import 'provider/restaurant_search_provider.dart';
import 'data/api/api_service.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_)=> ApiService()),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiService>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
      ),
      );
    
  }
}