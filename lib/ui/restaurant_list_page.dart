import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/restaurant_provider.dart';
import '../utils/result_state.dart';
import '../widgets/card_restaurant.dart';
import '../widgets/platform_widget.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildList(context),
    );
  }

  Widget _buildList (BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (state.state == ResultState.hasData) {
            return Scaffold(
              body: ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return CardRestaurant(restaurant: restaurant);
                },
              ),
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.error){
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        }
      },
    );
  }
}
