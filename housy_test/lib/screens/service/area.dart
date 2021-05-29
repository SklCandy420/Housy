import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/components/widgets/default_button.dart';
import 'package:housy_test/components/widgets/loading.dart';
import 'package:housy_test/helpers/size_config.dart';
import 'package:housy_test/screens/service/type.dart';
import 'package:housy_test/states/state_management.dart';

class Area extends StatefulWidget {
  @override
  _AreaState createState() => _AreaState();
}

class _AreaState extends State<Area> {
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
                            value: 0.4,
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
                      "Which areas do you\nneed help with?",
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
                          'Bedroom',
                          'Living Room',
                          'Kitchen',
                          'Bathroom',
                        ],
                        checked: _checked,
                        onSelected: (List<String> _selected) => setState(() {
                          _isButtonEnabled = true;
                          if (_selected.length > 1) {
                            StateManagement.qprefs
                                .setString("area", _selected[1]);
                            _selected.removeAt(0);
                          } else {
                            StateManagement.qprefs
                                .setString("area", _selected[0]);
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
                                    builder: (context) => HomeType(),
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
