import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:housy_test/helpers/size_config.dart';
import 'package:housy_test/screens/intro/splash.dart';
import 'package:housy_test/screens/network.dart';
import 'package:housy_test/services/authServices/authServices.dart';
import 'package:housy_test/services/connectivity/connectivity_state.dart';
import 'package:housy_test/states/state_management.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await StateManagement.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init1(constraints, orientation);
              return MaterialApp(
                title: 'Housy Test',
                theme: ThemeData(
                  // This is the theme of your application.
                  //
                  // Try running your application with "flutter run". You'll see the
                  // application has a blue toolbar. Then, without quitting the app, try
                  // changing the primarySwatch below to Colors.green and then invoke
                  // "hot reload" (press "r" in the console where you ran "flutter run",
                  // or simply save your changes to "hot reload" in a Flutter IDE).
                  // Notice that the counter didn't reset back to zero; the application
                  // is not restarted.
                  primarySwatch: Colors.lightBlue,
                ),
                debugShowCheckedModeBanner: false,
                home: StreamBuilder<ConnectivityStatus>(
                  stream:
                      ConnectivityService().connectionStatusController.stream,
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    return snapshot.data != null &&
                            snapshot.data != ConnectivityStatus.Offline
                        ? StreamBuilder<bool>(
                            stream: getConnectionStatus().asStream(),
                            builder: (context, snapshot1) =>
                                snapshot1.data == true
                                    ? SplashScreen()
                                    : NoNetwork(),
                          )
                        : NoNetwork();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ignore: missing_return
Future<bool> getConnectionStatus() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print(result);
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}
