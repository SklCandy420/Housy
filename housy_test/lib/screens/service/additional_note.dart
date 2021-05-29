import 'package:flutter/material.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/components/widgets/default_button.dart';
import 'package:housy_test/components/widgets/loading.dart';
import 'package:housy_test/helpers/globals.dart';
import 'package:housy_test/helpers/size_config.dart';
import 'package:housy_test/screens/professionals/professional.dart';
import 'package:housy_test/states/state_management.dart';

class AdditionalNotes extends StatefulWidget {
  @override
  _AdditionalNotesState createState() => _AdditionalNotesState();
}

class _AdditionalNotesState extends State<AdditionalNotes> {
  bool _loading = false;
  String des;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        height: getProportionateScreenHeight(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: LinearProgressIndicator(
                            value: 0.5,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                kPrimaryColor),
                            backgroundColor: Color(0xffD6D6D6),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Text(
                      "What other info. would you like to pass along?",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(50),
                    ),
                    SingleChildScrollView(
                      child: TextField(
                        onChanged: (val) {
                          des = val;
                          StateManagement.qprefs.setString("description", des);
                        },
                        autocorrect: true,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Describe the task in more detail",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30.0),
                      width: double.infinity,
                      child: DefaultButton(
                        text: "CONTINUE",
                        press: () async {
                          setState(() {
                            _loading = true;
                          });
                          await saveprefData();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfessionalScreen(),
                            ),
                          );
                          setState(() {
                            _loading = false;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> saveprefData() async {
    try {
      await firestore
          .collection("users")
          .doc(curruser.uid)
          .collection("services")
          .doc(StateManagement.qprefs.getString("category"))
          .set({
        "category": StateManagement.qprefs.getString("category"),
        "date": StateManagement.qprefs.getString("date"),
        "time": StateManagement.qprefs.getString("time"),
        "help": StateManagement.qprefs.getString("help"),
        "area": StateManagement.qprefs.getString("area"),
        "type": StateManagement.qprefs.getString("type"),
        "description": StateManagement.qprefs.getString("des")
      });
    } catch (e) {
      print(e);
    }
  }
}
