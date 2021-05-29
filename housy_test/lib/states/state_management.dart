import 'package:shared_preferences/shared_preferences.dart';

class StateManagement {
  static SharedPreferences qprefs;

  static init() async {
    qprefs = await SharedPreferences.getInstance();
  }
}
