import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier{
  final Set<String> _favoriteIds = {};

  bool isFavorite(String id) {
    return _favoriteIds.contains(id);
  }

  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners(); 
  }
}