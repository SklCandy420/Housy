import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateManagement {
  static String uid;
  static SharedPreferences prefs;
  static init() async {
    uid = FirebaseAuth.instance.currentUser.uid;
    prefs = await SharedPreferences.getInstance();
  }
}
