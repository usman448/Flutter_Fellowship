
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // Keys — ye strings exactly same rehni chahiye
  static const _keyDarkMode       = 'isDarkMode';
  static const _keyFavorites      = 'favoriteIds';
  static const _keyCompactCards   = 'compactCards';
  static const _keyDefaultCat     = 'defaultCategory';
  static const _keyNotifications  = 'cookingNotifications';

  // ─── Theme ───────────────────────────────────────────
  static Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, isDark);
  }

  static Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDarkMode) ?? true; // default: dark
  }

  // ─── Favorites ───────────────────────────────────────
  static Future<void> saveFavorites(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyFavorites, ids);
  }

  static Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyFavorites) ?? [];
  }

  // ─── Compact Cards ───────────────────────────────────
  static Future<void> saveCompactCards(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyCompactCards, value);
  }

  static Future<bool> loadCompactCards() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyCompactCards) ?? false;
  }

  // ─── Default Category ────────────────────────────────
  static Future<void> saveDefaultCategory(String cat) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyDefaultCat, cat);
  }

  static Future<String> loadDefaultCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDefaultCat) ?? 'Lunch';
  }

  // ─── Notifications ───────────────────────────────────
  static Future<void> saveNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNotifications, value);
  }

  static Future<bool> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyNotifications) ?? true;
  }
}