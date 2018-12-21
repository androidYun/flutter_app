import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static const String _ACCESS_TOKEN_KEY = "ACCESS_TOKEN_KEY";

  factory SpUtils() => _getInstance();

  static SpUtils get instance => _getInstance();

  static SpUtils _instance;

  SpUtils._internal();

  static SpUtils _getInstance() {
    if (_instance == null) {
      _instance = SpUtils._internal();
    }
    return _instance;
  }

  /*
   *设置仓库id
   */
  Future<String> getAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(_ACCESS_TOKEN_KEY);
  }

  setAccessToken(String accessToken) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(_ACCESS_TOKEN_KEY, accessToken);
  }
}
