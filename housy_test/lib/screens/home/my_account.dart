import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/components/widgets/default_button.dart';
import 'package:housy_test/components/widgets/loading.dart';
import 'package:housy_test/helpers/globals.dart';
import 'package:housy_test/helpers/size_config.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  String lastName;
  String address;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

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
        : StreamBuilder(
            stream: firestore.collection("users").doc(curruser.uid).snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Loading();
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Edit Profile',
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
                            Text(
                              "Edit your details",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.06),
                            SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      initialValue: snapshot.data['first_name'],
                                      onChanged: (value) {
                                        setState(() {
                                          firstName = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          addError(error: kFirstNamelNullError);
                                          return kFirstNamelNullError;
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: "First Name",
                                        hintText: "Enter your first name",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: Icon(Icons.person),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(30)),
                                    TextFormField(
                                      initialValue: snapshot.data['last_name'],
                                      onChanged: (value) {
                                        setState(() {
                                          lastName = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          addError(error: kLastNamelNullError);
                                          return kLastNamelNullError;
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: "Last Name",
                                        hintText: "Enter your last name",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: Icon(Icons.person),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(30)),
                                    TextFormField(
                                      initialValue: snapshot.data['address'],
                                      onChanged: (value) {
                                        setState(() {
                                          address = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          addError(error: kAddressNullError);
                                          return kAddressNullError;
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: "Address",
                                        hintText: "Enter your Address",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: Icon(Icons.shop),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(30)),
                                    DefaultButton(
                                      text: "Update",
                                      press: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          await updateData(
                                              firstName != null
                                                  ? firstName
                                                  : snapshot.data['first_name'],
                                              lastName != null
                                                  ? lastName
                                                  : snapshot.data['last_name'],
                                              address != null
                                                  ? address
                                                  : snapshot.data['address']);
                                          setState(() {
                                            loading = false;
                                          });
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
            });
  }

  Future<void> updateData(String updatedFirstName, String updatedLastName,
      String updatedAddress) async {
    await firestore.collection("users").doc(curruser.uid).update({
      "first_name": updatedFirstName,
      "last_name": updatedLastName,
      "address": updatedAddress
    });
  }
}
