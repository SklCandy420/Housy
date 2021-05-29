import 'package:flutter/material.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/helpers/globals.dart';

class ProfessionalContainer extends StatelessWidget {
  final int id;
  const ProfessionalContainer({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade100,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: '$id',
                  child: Image.asset(
                    "${proList[id].img}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(9.0),
                ),
              ),
              child: Text(
                "${proList[id].title}",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
