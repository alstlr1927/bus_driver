import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  String rememeberEmail = 'rememberEmail';

  Future<String> getRememberEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('$rememeberEmail') ?? '';
  }

  Future<bool> setRememberEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('$rememeberEmail', email);
  }
}
