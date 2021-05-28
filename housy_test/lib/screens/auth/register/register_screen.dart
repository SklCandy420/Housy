import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/components/widgets/default_button.dart';
import 'package:housy_test/components/widgets/loading.dart';
import 'package:housy_test/helpers/size_config.dart';
import 'package:housy_test/screens/home.dart';
import 'package:housy_test/services/databaseServices/dbServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitProfile extends StatefulWidget {
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
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => Register()));
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: _loading ? Loading() : Container(),
      ),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  DataBaseServices _services = new DataBaseServices();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _addressController = TextEditingController();
  bool loading = false;

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
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Register',
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
                        Text("Registration Form", style: headingStyle),
                        Text(
                          "Complete your details",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.06),
                        SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                buildFirstNameFormField(),
                                SizedBox(
                                    height: getProportionateScreenHeight(30)),
                                buildLastNameFormField(),
                                SizedBox(
                                    height: getProportionateScreenHeight(30)),
                                buildAddressFormField(),
                                SizedBox(
                                    height: getProportionateScreenHeight(30)),
                                DefaultButton(
                                  text: "continue",
                                  press: () {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      saveData();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: _addressController,
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return kAddressNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Address",
        hintText: "Enter your Address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.shop),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: _firstnameController,
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kFirstNamelNullError);
          return kFirstNamelNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: _lastnameController,
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kLastNamelNullError);
          return kLastNamelNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> _payload = {
      'first_name': _firstnameController.text,
      'last_name': _lastnameController.text,
      'address': _addressController.text,
      'phone_no': pref.getString("phone"),
    };
    await _services.addUserData(_payload);
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => Home()));
  }
}
