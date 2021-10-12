import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final _prefs = SharedPreferences.getInstance();

  static saveCredentials(
    String email,
    String password, {
    required String accessToken,
  }) async {
    final prefs = await _prefs;

    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('accessToken', accessToken);

    print("Prefs saved");
  }

  static Future<Map<String, String?>> getCredentials() async {
    final prefs = await _prefs;

    Map<String, String?> map = {};

    bool? isLoggedIn = false;

    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      map = {
        'email': prefs.getString('email'),
        'password': prefs.getString('password'),
        'accessToken': prefs.getString('accessToken'),
      };
    }

    return map;
  }

  static clear() async {
    final prefs = await _prefs;

    prefs.clear();
  }
}
