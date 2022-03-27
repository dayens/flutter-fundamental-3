import 'package:flutter/material.dart';
import 'package:flutter_fundamental_3/provider/scheduling_provider.dart';
import 'package:flutter_fundamental_3/ui/detail_screen.dart';
import 'package:flutter_fundamental_3/ui/restaurant_list_page.dart';
import 'package:flutter_fundamental_3/ui/setting_page.dart';
import 'package:flutter_fundamental_3/utils/notification_helper.dart';
import 'package:flutter_fundamental_3/widgets/platform_widget.dart';
import 'package:provider/provider.dart';
import 'bookmark_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home_screen';


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;
  static const String _homeText = 'Home';
  static const String _bookmarksText = 'Bookmarks';
  static const String _settingsText = 'Setting';

  final NotificationHelper _notificationHelper = NotificationHelper();


  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const BookmarkPage(),
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: SettingPage(),
    ),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: _homeText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bookmarks),
      label: _bookmarksText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: _settingsText,
    ),
  ];

  void _onBottomNavTaped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTaped,
        items: _bottomNavBarItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
