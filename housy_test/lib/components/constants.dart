import 'package:flutter/material.dart';
import 'package:housy_test/helpers/size_config.dart';

const MaterialColor kPrimaryColor = const MaterialColor(
  0xff001D79,
  const <int, Color>{
    50: const Color(0xff001D79),
    100: const Color(0xff001D79),
    200: const Color(0xff001D79),
    300: const Color(0xff001D79),
    400: const Color(0xff001D79),
    500: const Color(0xff001D79),
    600: const Color(0xff001D79),
    700: const Color(0xff001D79),
    800: const Color(0xff001D79),
    900: const Color(0xff001D79),
  },
);
const kPrimaryLightColor = Color(0xFFF2F3F7);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xff001D79), Colors.lightBlue],
);
const kOnBoardGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Colors.white, Color(0xFFE5E2FF)],
);
final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.w500,
  color: Colors.black,
  height: 1.5,
);

const String kFirstNamelNullError = "Please Enter your first name";
const String kLastNamelNullError = "Please Enter your last name";
const String kAddressNullError = "Please Enter your Address";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kPhoneValidNumberError = "Please Enter valid phone number";
