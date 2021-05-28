import 'package:firebase_auth/firebase_auth.dart';
import 'package:housy_test/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserData _userFromFirebaseUser(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  Stream<UserData> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
}
