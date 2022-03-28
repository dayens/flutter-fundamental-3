import 'dart:convert';
import 'package:flutter_fundamental_3/data/model/restaurant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

import '../common/navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();


class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin
      ) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid
    );
    
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }

      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification (
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurants
      ) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    // var _channelDescription = "restaurant update channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId, _channelName,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true)
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics
    );

    var titleNotification = "<b>Restaurant News</b>";
    var titleNews = restaurants.restaurants[0].name;

    await flutterLocalNotificationsPlugin.show(
      0, titleNotification, titleNews, platformChannelSpecifics,
      payload: json.encode(restaurants.toJson())
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
        (String payload) async {
          var data = RestaurantResult.fromJson(json.decode(payload));
          var restaurant = data.restaurants[0];
          Navigation.intentWithData(route, restaurant);
        }
    );
  }
}