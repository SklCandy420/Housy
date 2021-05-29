import 'package:housy_test/screens/service/time.dart';
import 'package:housy_test/states/state_management.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/components/widgets/default_button.dart';
import 'package:housy_test/components/widgets/loading.dart';
import 'package:housy_test/helpers/size_config.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeCalendarPage extends StatefulWidget {
  @override
  _HomeCalendarPageState createState() => _HomeCalendarPageState();
}

class _HomeCalendarPageState extends State<HomeCalendarPage> {
  CalendarController _controller;
  bool _loading = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

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
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        height: getProportionateScreenHeight(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: LinearProgressIndicator(
                            value: 0.1,
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
                      "When would you like \nthis pro to start?",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TableCalendar(
                            initialCalendarFormat: CalendarFormat.month,
                            calendarStyle: CalendarStyle(
                                todayColor: Colors.blue,
                                selectedColor: Theme.of(context).primaryColor,
                                todayStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                    color: Colors.white)),
                            headerStyle: HeaderStyle(
                              centerHeaderTitle: true,
                              formatButtonDecoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(22.0),
                              ),
                              formatButtonTextStyle:
                                  TextStyle(color: Colors.white),
                              formatButtonShowsNext: false,
                            ),
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            onDaySelected: (date, event1, event2) {
                              setState(() {
                                _isButtonEnabled = true;
                              });
                              StateManagement.qprefs.setString(
                                  "date",
                                  DateFormat('dd-MM-yyyy')
                                      .format(date)
                                      .toString());
                            },
                            builders: CalendarBuilders(
                              selectedDayBuilder: (context, date, events) =>
                                  Container(
                                      margin: const EdgeInsets.all(5.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: Text(
                                        date.day.toString(),
                                        style: TextStyle(color: Colors.white),
                                      )),
                              todayDayBuilder: (context, date, events) =>
                                  Container(
                                      margin: const EdgeInsets.all(5.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: Text(
                                        date.day.toString(),
                                        style: TextStyle(color: Colors.white),
                                      )),
                            ),
                            calendarController: _controller,
                          )
                        ],
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
                                    builder: (context) => Time(),
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
