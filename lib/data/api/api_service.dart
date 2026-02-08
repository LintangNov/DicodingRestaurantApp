import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/restaurant_list.dart';
import '../model/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));

    } else {
      throw Exception('Gagal memuat daftar restoran');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async{
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

    if(response.statusCode == 200){
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat detail restoran');
    }
  }

  Future<RestaurantListResponse> searchRestaurants(String query) async{
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if(response.statusCode ==200){
      return RestaurantListResponse.fromJson(json.decode((response.body)));
    } else{
      throw Exception('Gagal melakukan pencarian restoran');
    }
  }

  Future<bool> postReview(String id, String name, String review) async{
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "id": id,
        "name": name,
        "review": review,
      }),
    );
    if(response.statusCode == 200||response.statusCode ==201){
      return true;
    } else{
      throw Exception('Gagal mengirim review');
    }
  }
}