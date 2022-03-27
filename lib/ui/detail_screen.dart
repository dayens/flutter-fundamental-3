import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/api_service/api_service.dart';
import '../data/model/restaurant.dart';
import '../provider/detail_provider.dart';
import '../utils/result_state.dart';
import '../widgets/platform_widget.dart';
import 'detail_page.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  DetailScreen ({required this.restaurant});
  final Restaurant restaurant;

  Widget _buildList (BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(apiService: ApiService(), resto: restaurant.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Restaurant'),
        ),
        body: Consumer<DetailProvider>(
            builder: (context, data, _) {
              if (data.state == ResultState.loading) {
                return Center(child: CircularProgressIndicator(),);
              } else if (data.state == ResultState.hasData) {
                return Scaffold(
                  body: DetailPage(restaurant: data.detailResult.restaurants),
                );
              } else if (data.state == ResultState.noData) {
                return Center(child: Text(data.message));
              } else if (data.state == ResultState.error) {
                return Center(child: Text(data.message));
              } else {
                return Center(child: Text(''));
              }
            }
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildList,
      iosBuilder: _buildList,
    );
  }
}