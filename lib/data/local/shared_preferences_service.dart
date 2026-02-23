import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String _keyDarkTheme = "DARK_THEME";
  static const String _keyDailyReminder = "DAILY_REMINDER";

  Future<void> saveThemeSetting(bool isDark) async {
    try {
      await _preferences.setBool(_keyDarkTheme, isDark);
    } catch (e) {
      throw Exception("Failed to save theme preference");
    }
  }

  Future<void> saveReminderSetting(bool isReminderActive) async {
    try {
      await _preferences.setBool(_keyDailyReminder, isReminderActive);
    } catch (e) {
      throw Exception("Failed to save reminder preference");
    }
  }

  bool getReminderSetting() => _preferences.getBool(_keyDailyReminder) ?? false;

  bool getThemeSetting() => _preferences.getBool(_keyDarkTheme) ?? false;
}
