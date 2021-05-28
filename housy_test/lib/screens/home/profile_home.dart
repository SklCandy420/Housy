import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/screens/home/home.dart';
import 'package:housy_test/screens/home/my_account.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[Home(), Account()];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentBackPressTime;
    return Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: _selectedIndex != 1
              ? AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/logo.jpg',
                        height: 42,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Housy Test',
                        style: TextStyle(
                          letterSpacing: 0.2,
                        ),
                      )
                    ],
                  ),
                  backgroundColor: kPrimaryColor,
                  elevation: 0,
                )
              : null,
          backgroundColor: Colors.transparent,
          body: WillPopScope(
            onWillPop: () {
              DateTime now = DateTime.now();
              if (currentBackPressTime == null ||
                  now.difference(currentBackPressTime) > Duration(seconds: 2)) {
                currentBackPressTime = now;
                Fluttertoast.showToast(
                    msg: "Press Back Again To Exit App",
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    gravity: ToastGravity.CENTER);
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
          bottomNavigationBar: Container(
            height: 55,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(.1),
              )
            ]),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                child: GNav(
                  gap: 6,
                  activeColor: Colors.white,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  duration: Duration(milliseconds: 100),
                  tabBackgroundColor: kPrimaryColor,
                  tabs: [
                    GButton(
                      icon: Icons.home_rounded,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.account_circle_rounded,
                      text: 'Account',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(
                      () {
                        _selectedIndex = index;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
