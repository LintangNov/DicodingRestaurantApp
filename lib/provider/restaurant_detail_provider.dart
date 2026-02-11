import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant_detail.dart';
import '../static/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService _apiService;
  RestaurantDetailProvider(this._apiService);

  ResultState<RestaurantDetailResponse> _state = ResultStateInitial();
  ResultState<RestaurantDetailResponse> get state => _state;


  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultStateLoading();
      notifyListeners();

      final result = await _apiService.getRestaurantDetail(id);

      _state = ResultStateSuccess(result);
      notifyListeners();
    } catch (e) {
      _state = ResultStateError(e.toString());
      notifyListeners();
    }
  }

  Future<bool> postReview(String id, String name, String review) async{
    try {
      final isSuccess = await _apiService.postReview(id, name, review);
      if(isSuccess){
        fetchRestaurantDetail(id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Gagal menyimpan review: $e");
      return false;
    }
  }
}