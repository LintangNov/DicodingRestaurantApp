import 'package:flutter/foundation.dart';
import '../data/local/sqlite_service.dart';
import '../data/model/restaurant_list.dart';

class FavoriteProvider extends ChangeNotifier{
  final SqliteService _sqliteService;
  
  FavoriteProvider(this._sqliteService);

  String _message = "";
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  Set<String> _favoriteIds = {};

  Future<void> loadAllFavorites() async {
    try{
      _favorites = await _sqliteService.getAllItems();
      _favoriteIds = _favorites.map((e) => e.id).toSet();
      notifyListeners();
    } catch (e){
      _message = "Gagal memuat data favorit";
      notifyListeners();
    }
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  Future<void> toggleFavorite(Restaurant restaurant) async{
    try{
      final isExist = _favoriteIds.contains(restaurant.id);

      if(isExist){
        await _sqliteService.removeItem(restaurant.id);
        _message = 'Dihapus dari favorit';
      } else {
        await _sqliteService.insertItem(restaurant);
        _message = 'Ditambahkan ke favorit';
      }

      await loadAllFavorites();
    } catch (e){
      _message = isFavorite(restaurant.id)? 'Gagal menghapus dari favorit':'Gagal menambahkan ke favorit';
      notifyListeners();
    }
  }
}