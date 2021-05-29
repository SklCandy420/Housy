import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/components/widgets/default_button.dart';
import 'package:housy_test/components/widgets/loading.dart';
import 'package:housy_test/helpers/size_config.dart';
import 'package:housy_test/screens/service/additional_note.dart';
import 'package:housy_test/states/state_management.dart';

class HomeType extends StatefulWidget {
  @override
  _HomeTypeState createState() => _HomeTypeState();
}

class _HomeTypeState extends State<HomeType> {
  List<String> _checked = [];
  bool _loading = false;
  bool _isButtonEnabled = false;

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
                      "Is this home or buisness?",
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
                      child: CheckboxGroup(
                        labels: <String>[
                          'Home',
                          'Buisness',
                        ],
                        checked: _checked,
                        onSelected: (List<String> _selected) => setState(() {
                          _isButtonEnabled = true;
                          if (_selected.length > 1) {
                            StateManagement.qprefs
                                .setString("type", _selected[1]);
                            _selected.removeAt(0);
                          } else {
                            StateManagement.qprefs
                                .setString("type", _selected[0]);
                          }
                          _checked = _selected;
                        }),
                      ),
                    ),
                    _isButtonEnabled
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 30.0),
                            width: double.infinity,
                            child: DefaultButton(
                              text: "CONTINUE",
                              press: () async {
                                setState(() {
                                  _loading = true;
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AdditionalNotes(),
                                  ),
                                );
                                setState(() {
                                  _loading = false;
                                });
                              },
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          );
  }
}
