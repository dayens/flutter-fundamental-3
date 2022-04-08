import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fundamental_3/data/db/database_helper.dart';
import 'package:flutter_fundamental_3/provider/database_provider.dart';
import 'package:flutter_fundamental_3/provider/restaurant_provider.dart';
import 'package:flutter_fundamental_3/provider/search_provider.dart';
import 'package:flutter_fundamental_3/ui/detail_screen.dart';
import 'package:flutter_fundamental_3/ui/home_screen.dart';
import 'package:flutter_fundamental_3/ui/search_screen.dart';
import 'package:flutter_fundamental_3/utils/background_service.dart';
import 'package:flutter_fundamental_3/utils/notification_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'common/navigation.dart';
import 'data/api_service/api_service.dart';
import 'data/model/restaurant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Fundamental 2',
        navigatorKey: navigatorKey,
        theme: ThemeData(),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          DetailScreen.routeName: (context) => DetailScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
        },
      ),
    );
  }
}
