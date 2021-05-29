import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/helpers/globals.dart';
import 'package:housy_test/screens/auth/login/phone_login.dart';

Widget drawerHousy(context) {
  return Drawer(
    child: Column(
      children: [
        Expanded(
          child: Container(
            color: kPrimaryLightColor,
            child: ListView(
              children: [
                StreamBuilder(
                    stream: firestore
                        .collection("users")
                        .doc(curruser.uid)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text(' '),
                        );
                      } else {
                        var docs = snapshot.data;
                        return DrawerHeader(
                          decoration: BoxDecoration(color: ksecondaryColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${docs['first_name']} ${docs['last_name']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                ListTile(
                  hoverColor: ksecondaryColor,
                  leading: Icon(
                    Icons.logout,
                    color: kPrimaryColor,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    signOut(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void signOut(context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kPrimaryLightColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            'Sign Out',
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: 25.0,
                fontWeight: FontWeight.w500),
          ),
          content: Text(
            'Are You Sure You Want To Logout?',
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes',
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1)),
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => Phone()),
                    (Route<dynamic> route) => false);
                await FirebaseAuth.instance.signOut();
              },
            ),
            TextButton(
              child: Text('No',
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1)),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
