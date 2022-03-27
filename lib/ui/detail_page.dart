import 'package:flutter/material.dart';

import '../data/model/detail_restaurant.dart';

class DetailPage extends StatelessWidget {
  static const String _urlPicture = 'https://restaurant-api.dicoding.dev/images/large/';

  final DetailRestaurant restaurant;

  DetailPage ({required this.restaurant});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16, left: 1, right: 1),
            child: Image.network(_urlPicture + restaurant.pictureId,),
          ),
          Container(
            margin: EdgeInsets.only(top: 32, left: 8, right: 8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2)
            ),
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                restaurant.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text(restaurant.city)),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16, left: 8, right: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_rate, size: 16, color: Colors.orange,),
                      Text(restaurant.rating.toString())
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8, left: 8, right: 8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2)
            ),
            padding: EdgeInsets.all(8.0),
            child: Text(restaurant.description),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.restaurant, size: 20, color: Colors.blue,),
                          Text(' Daftar Makanan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Column(
                        children: restaurant.menus.foods.map((e) =>
                            Text('- '+e.name)).toList(),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.emoji_food_beverage_rounded, size: 20, color: Colors.blue,),
                            Text(' Daftar Minuman', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Column(
                          children: restaurant.menus.drinks.map((e) =>
                              Text('- '+e.name)).toList(),
                        )
                      ]
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}