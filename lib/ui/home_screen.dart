import 'package:flutter/material.dart';
import 'package:flutter_fundamental_3/ui/restaurant_list_page.dart';
import 'package:flutter_fundamental_3/widgets/platform_widget.dart';
import 'bookmark_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  List<Widget> _listWidget = [
    RestaurantListPage(),
    BookmarkPage(),
  ];

  void _onBottomNavTaped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant)),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmarks)),
  ];

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

  Widget _buildIos(BuildContext context) {
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
      iosBuilder: _buildIos,
    );
  }
}
