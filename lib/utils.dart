import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static saveTaken(String mytoken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', mytoken);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mitoken = await prefs.getString('token');
    return mitoken;
  }
}
