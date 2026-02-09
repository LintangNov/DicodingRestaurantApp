import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant_list.dart';
import '../static/result_state.dart';

class RestaurantListProvider extends ChangeNotifier{
  final ApiService _apiService;
  RestaurantListProvider(this._apiService);

  ResultState<RestaurantListResponse> _state = ResultStateInitial();
  ResultState<RestaurantListResponse> get state => _state;

  Future<void> fetchRestaurantList() async{
    try {
      _state = ResultStateLoading();
      notifyListeners();

      final result = await _apiService.getRestaurantList();

      if(result.restaurants.isEmpty){
        _state = ResultStateError("Data restoran tidak ditemukan");

      } else {
        _state = ResultStateSuccess(result);
      }
      notifyListeners();
    } catch (e){
      _state = ResultStateError(e.toString());
      notifyListeners();
    }
  }
}