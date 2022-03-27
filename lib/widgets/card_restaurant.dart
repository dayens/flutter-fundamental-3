import 'package:flutter/material.dart';
import 'package:flutter_fundamental_3/provider/database_provider.dart';
import 'package:provider/provider.dart';
import '../data/model/restaurant.dart';
import '../ui/detail_screen.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  static const String _baseUrlImage = 'https://restaurant-api.dicoding.dev/images/small/';

  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailScreen.routeName,
                    arguments: restaurant);
              },
              child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Image.network(_baseUrlImage + restaurant.pictureId),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              restaurant.name,
                              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              restaurant.city,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Column(
                              children: [
                                ListTile(
                                  trailing: isBookmarked
                                      ? IconButton(
                                    icon: Icon(Icons.bookmark),
                                    color: Theme.of(context).accentColor,
                                    onPressed: () => provider.removeRestaurant(restaurant.id),
                                  )
                                      : IconButton(
                                    icon: Icon(Icons.bookmark_border),
                                    color: Theme.of(context).accentColor,
                                    onPressed: () => provider.addRestaurant(restaurant),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    const Icon(Icons.star_rate, color: Colors.orange, size: 16,),
                                    Text(restaurant.rating)
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
