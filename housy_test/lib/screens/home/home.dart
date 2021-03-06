import 'package:flutter/material.dart';
import 'package:housy_test/helpers/globals.dart';
import 'package:housy_test/screens/home/category_container.dart';
import 'package:housy_test/screens/service/calendar.dart';
import 'package:housy_test/states/state_management.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 11,
            ),
            Text(
              "Preferences",
              style: Theme.of(context).textTheme.headline4.apply(
                    fontWeightDelta: 2,
                    color: Colors.black,
                  ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 600,
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: .7),
                itemCount: catList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        StateManagement.qprefs
                            .setString("category", catList[index].title);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomeCalendarPage(),
                          ),
                        );
                      },
                      child: CategoryContainer(id: index));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
