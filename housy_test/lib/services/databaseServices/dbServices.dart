import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housy_test/helpers/globals.dart';
import 'package:housy_test/models/user.dart';

class DataBaseServices {
  Future<bool> searchUser() async {
    DocumentSnapshot _userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(curruser.uid)
        .get();
    return _userDoc.exists;
  }


  addUserData(Map<String, dynamic> payload) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(curruser.uid)
        .set(payload, SetOptions(merge: true));
  }
}
