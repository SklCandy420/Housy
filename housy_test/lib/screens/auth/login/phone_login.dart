import 'package:flutter/material.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/components/widgets/default_button.dart';
import 'package:housy_test/helpers/size_config.dart';
import 'package:housy_test/screens/auth/login/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Phone extends StatefulWidget {
  static String routeName = "/phone";
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ksecondaryColor,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Image.asset(
                    "assets/logo.jpg",
                    alignment: Alignment.center,
                    height: 140,
                    width: 800,
                    fit: BoxFit.contain,
                  ),
                  NumberForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NumberForm extends StatefulWidget {
  @override
  _NumberFormState createState() => _NumberFormState();
}

class _NumberFormState extends State<NumberForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final _contactController = TextEditingController();

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Send OTP",
            press: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              if (_formKey.currentState.validate()) {
                pref.setString("phone", _contactController.text);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return OTPScreen('+91-${_contactController.text}');
                    },
                  ),
                );
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(17)),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _contactController,
      validator: (value) {
        String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
        RegExp regExp = new RegExp(pattern);
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return kPhoneNumberNullError;
        } else if (!regExp.hasMatch(value)) {
          addError(error: kPhoneValidNumberError);
          return kPhoneValidNumberError;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        prefixText: "+91",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone_android),
      ),
    );
  }
}
