import 'package:flutter/material.dart';
import 'package:restaurant_app/data/local/shared_preferences_service.dart';

class SettingProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  SettingProvider(this._service){
    _getThemeSetting();
    _getReminderSetting();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isReminderActive = false;
  bool get isReminderActive => _isReminderActive;

  void _getThemeSetting(){
    _isDarkTheme = _service.getThemeSetting();
    notifyListeners();
  }

  void _getReminderSetting(){
    _isReminderActive = _service.getReminderSetting();
    notifyListeners();
  }

  void enabledarkTheme(bool value)async{
    await _service.saveThemeSetting(value);
    _isDarkTheme = value;
    notifyListeners();
  }

  void enableDailyReminder(bool value) async {
    await _service.saveReminderSetting(value);
    _isReminderActive = value;
    notifyListeners();
    
  }
}