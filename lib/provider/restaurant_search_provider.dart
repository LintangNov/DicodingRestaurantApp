import '../data/api/api_service.dart';
import '../data/model/restaurant_list.dart';
import '../static/result_state.dart';
import 'package:flutter/foundation.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService _apiService;
  RestaurantSearchProvider(this._apiService);

  ResultState<RestaurantListResponse> _state = ResultStateInitial();
  ResultState<RestaurantListResponse> get state => _state;

  String _query = "";
  String get query => _query;


  Future<void> fetchSearchRestaurant(String query) async {
    try {
      _query = query;

      if (query.isEmpty) {
        _state = ResultStateInitial();
        notifyListeners();
        return;
      }
      _state = ResultStateLoading();
      notifyListeners();

      final result = await _apiService.searchRestaurants(query);

      if (result.restaurants.isEmpty){
        _state = ResultStateError("Restoran tidak ditemukan");
      } else {
        _state = ResultStateSuccess(result);
      }
      notifyListeners();
    } catch (e) {
      _state = ResultStateError("Gagal memuat pencarian restoran: $e");
      notifyListeners();
    }
  }

  void clearSearch() {
    _query = "";
    _state = ResultStateInitial();
    notifyListeners();
  }
}