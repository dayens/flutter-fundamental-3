import 'package:flutter/material.dart';
import 'package:flutter_fundamental_3/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';
import '../provider/database_provider.dart';
import '../utils/result_state.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.restaurant.length,
              itemBuilder: (context, index) {
                return CardRestaurant(restaurant: provider.restaurant[index]);
              },
            );
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}
