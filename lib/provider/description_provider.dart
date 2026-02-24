import 'package:flutter/foundation.dart';
class DescriptionProvider extends ChangeNotifier {
  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  void toggleReadMore(){
    _isExpanded = !_isExpanded;
    notifyListeners();

  }
  
  void reset(){
    _isExpanded = false;
    notifyListeners();
  }
}