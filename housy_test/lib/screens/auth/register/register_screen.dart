import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/screens/auth/register/components/body.dart';
import 'package:housy_test/screens/home.dart';
import 'package:housy_test/services/databaseServices/dbServices.dart';

class InitProfile extends StatefulWidget {
  static String routeName = "/profile";
  @override
  _InitProfileState createState() => _InitProfileState();
}

class _InitProfileState extends State<InitProfile>
    with AfterLayoutMixin<InitProfile> {
  DataBaseServices _services = new DataBaseServices();
  bool _loading = true;
  Future checkFirstSeen() async {
    _services.searchUser().then((value) {
      setState(() {
        _loading = false;
      });
      if (value == true) {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => Home()));
      } else {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (context) => CompleteProfileScreen()));
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: _loading ? CircularProgressIndicator() : Container(),
      ),
    );
  }
}

class CompleteProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
