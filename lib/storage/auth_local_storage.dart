import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  static const String keyCurrentUser = 'currentUser';

  static Future<void> saveCurrentUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(keyCurrentUser, userId);
  }

  static Future<void> removeCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(keyCurrentUser);
  }

  static Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyCurrentUser);
  }
}
