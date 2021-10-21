import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._privateConstructor();

  static Prefs instance = Prefs._privateConstructor();
  Future<bool> setUid(String uid) async {
    var pref = await SharedPreferences.getInstance();
    return await pref.setString("uid", uid);
  }

  Future<String?> getUid() async {
    var pref = await SharedPreferences.getInstance();
    return await pref.getString("uid");
  }
}
