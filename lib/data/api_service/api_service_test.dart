import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import '../model/restaurant.dart';

class ApiServiceTest {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String list = 'list';
  static const String _throw = 'Failed load data';

  final Client client;

  ApiServiceTest({required this.client});

  Future<RestaurantResult> listRestaurant() async {
    final response = await client.get(Uri.parse(baseUrl + list));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }
}