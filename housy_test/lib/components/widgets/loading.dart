import 'package:flutter/material.dart';
import 'package:housy_test/components/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryLightColor,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.purpleAccent,
        ),
      ),
    );
  }
}
