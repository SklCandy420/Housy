import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:housy_test/components/widgets/root.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Image.asset(
        'assets/logo.jpg',
      ),
      splashIconSize: 400,
      nextScreen: Root(),
      splashTransition: SplashTransition.sizeTransition,
      backgroundColor: Colors.lightBlue.shade300,
    );
  }
}
