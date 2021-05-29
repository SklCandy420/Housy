import 'package:flutter/material.dart';
import 'package:housy_test/helpers/globals.dart';
import 'package:housy_test/screens/professionals/professional_container.dart';

class ProfessionalScreen extends StatefulWidget {
  @override
  _ProfessionalScreenState createState() => _ProfessionalScreenState();
}

class _ProfessionalScreenState extends State<ProfessionalScreen> {
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
              "Professionals",
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
                  return ProfessionalContainer(id: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
