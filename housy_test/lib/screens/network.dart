import 'dart:io';
import 'package:flutter/material.dart';
import 'package:housy_test/helpers/size_config.dart';

class NoNetwork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Container(
              height: getProportionateScreenHeight(300),
              width: double.infinity,
              color: Colors.deepPurple[50],
              child: Image.asset(
                "assets/noNetwork.png",
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Text(
              'Oops, No Internet Connection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            Text(
              'Make sure wifi or cellular data is',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            Text(
              'turned on and then try again',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getProportionateScreenHeight(80),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  )),
              child: Container(
                height: getProportionateScreenHeight(50),
                width: getProportionateScreenWidth(100),
                alignment: Alignment.center,
                child: Text(
                  'Close App',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              onPressed: () {
                exit(0);
              },
            )
          ],
        )),
      ),
    );
  }
}
