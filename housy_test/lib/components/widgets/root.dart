import 'package:flutter/material.dart';
import 'package:housy_test/models/user.dart';
import 'package:housy_test/screens/auth/login/phone_login.dart';
import 'package:housy_test/screens/auth/register/register_screen.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    if (user != null) {
      return InitProfile();
    } else {
      return Phone();
    }
  }
}
