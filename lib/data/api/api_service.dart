import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/restaurant_list.dart';
import 'dart:io';
import '../model/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";


  Future<T> _handleRequest<T>(Future<T> Function() request) async{
    try{
      return await request();
    } on SocketException{
      throw Exception('Internet connection error');
    } on FormatException{
      throw Exception('Data format error');
    } catch(e){
      throw Exception('Unexpected error: $e');
    }
  }
  Future<RestaurantListResponse> getRestaurantList() async {
    return _handleRequest(() async {
      final response = await http.get(Uri.parse("$_baseUrl/list"));

      if(response.statusCode == 200){
        return RestaurantListResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurant list');
      }
    });
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async{
    return _handleRequest(() async{
      final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

      if(response.statusCode == 200){
        return RestaurantDetailResponse.fromJson(json.decode(response.body));
      } else if(response.statusCode == 404){
        throw Exception('Restaurant not found');
      } else {
        throw Exception('Failed to load restaurant detail (status code: ${response.statusCode})');
      }
    });
  }

  Future<RestaurantListResponse> searchRestaurants(String query) async{
    return _handleRequest(() async {
      final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

      if (response.statusCode == 200) {
        return RestaurantListResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Search failed (status code: ${response.statusCode})');
      }
    });
  }

  Future<bool> postReview(String id, String name, String review) async{
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/review"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "id": id,
          "name": name,
          "review": review,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to post review (status code: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('Failed: No internet connection.');
    } catch (e) {
      throw Exception('An error occurred while posting the review.');
    }
  }
}