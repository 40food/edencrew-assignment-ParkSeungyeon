import 'package:shared_preferences/shared_preferences.dart';

class WishStorage {
  static const _key = 'wishlist';

  Future<List<String>> getSymbols() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> saveSymbols(List<String> symbols) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, symbols);
  }
}
