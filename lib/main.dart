import 'package:flutter/material.dart';
import 'package:flutter_fundamental_3/data/db/database_helper.dart';
import 'package:flutter_fundamental_3/provider/database_provider.dart';
import 'package:flutter_fundamental_3/provider/restaurant_provider.dart';
import 'package:flutter_fundamental_3/provider/search_provider.dart';
import 'package:flutter_fundamental_3/ui/detail_screen.dart';
import 'package:flutter_fundamental_3/ui/home_screen.dart';
import 'package:flutter_fundamental_3/ui/search_screen.dart';
import 'package:provider/provider.dart';

import 'data/api_service/api_service.dart';
import 'data/model/restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
         ChangeNotifierProvider<SearchProvider>(
           create: (_) => SearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Fundamental 2',
        theme: ThemeData(),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
          DetailScreen.routeName: (context) => DetailScreen(
              restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant
          ),
        },
      ),
    );
  }
}