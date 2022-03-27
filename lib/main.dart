import 'package:flutter/material.dart';
import 'package:flutter_fundamental_3/provider/restaurant_provider.dart';
import 'package:flutter_fundamental_3/ui/home_screen.dart';
import 'package:provider/provider.dart';

import 'data/api_service/api_service.dart';

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
        // ChangeNotifierProvider<SearchRestaurantProvider>(
        //   create: (_) => SearchRestaurantProvider(apiService: ApiService()),
        // )
      ],
      child: MaterialApp(
        title: 'Flutter Fundamental 2',
        theme: ThemeData(),
        home: HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          // SearchScreen.routeName: (context) => SearchScreen(),
          // DetailScreen.routeName: (context) => DetailScreen(
          //     restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant
          // ),
        },
      ),
    );
  }
}