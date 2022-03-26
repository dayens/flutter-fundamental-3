import '../model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';
  static const String _throw = 'Failed load data';

  Future<RestaurantResult> listRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  // Future<DetailResult> detailRestaurant(String id) async {
  //   final response = await http.get(Uri.parse(_baseUrl + _detail + '$id'));
  //   if (response.statusCode == 200) {
  //     return DetailResult.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception(_throw);
  //   }
  // }
  //
  // Future<RestaurantSearch> searchRestaurant(String query) async {
  //   final response =
  //   await http.get(Uri.parse(_baseUrl + _search + query));
  //   if (response.statusCode == 200) {
  //     return RestaurantSearch.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception(_throw);
  //   }
  // }
}