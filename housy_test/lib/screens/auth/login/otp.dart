import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housy_test/components/constants.dart';
import 'package:housy_test/components/widgets/default_button.dart';
import 'package:housy_test/helpers/size_config.dart';
import 'package:housy_test/screens/auth/register/register_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';

// ignore: must_be_immutable
class OTPScreen extends StatefulWidget {
  bool _isInit = true;
  var _contact = '';
  OTPScreen(this._contact);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  int resendToken;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: kPrimaryColor,
    borderRadius: BorderRadius.circular(10.0),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget._isInit) {
      generateOtp(widget._contact);
      widget._isInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Text(
                  "OTP Verification",
                  style: headingStyle,
                ),
                Text("We sent your code to ${widget._contact}"),
                buildTimer(),
                buildOTPForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                DefaultButton(
                  text: "Continue",
                  press: () {
                    verifyOtp();
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                GestureDetector(
                  onTap: () {
                    generateOtp(widget._contact);
                  },
                  child: Text(
                    "Resend OTP Code",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expire in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 120.0, end: 0.0),
          duration: Duration(seconds: 120),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }

  Container buildOTPForm() {
    return Container(
        padding: const EdgeInsets.all(30.0),
        child: PinPut(
          fieldsCount: 6,
          textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
          eachFieldWidth: 40.0,
          eachFieldHeight: 55.0,
          focusNode: _pinPutFocusNode,
          controller: _pinPutController,
          submittedFieldDecoration: pinPutDecoration,
          selectedFieldDecoration: pinPutDecoration,
          followingFieldDecoration: pinPutDecoration,
          pinAnimationType: PinAnimationType.slide,
          onSubmit: (text) {
            smsOTP = text;
          },
        ));
  }

  Future<void> generateOtp(String contact) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      verificationId = verId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: contact,
          codeAutoRetrievalTimeout: (String verId) {
            verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 120),
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return InitProfile();
                    },
                  ),
                );
                showMessageInSnackbar("OTP Verification Successful!");
              }
            });
          },
          verificationFailed: (FirebaseAuthException exception) {
            Navigator.pop(context, exception.message);
          });
    } catch (e) {
      handleError(e as PlatformException);
    }
  }

  Future<void> verifyOtp() async {
    if (smsOTP == null || smsOTP == '') {
      showAlertDialog(context, 'please enter 6 digit otp');
      return;
    }
    try {
      await _auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsOTP))
          .then((value) async {
        if (value.user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return InitProfile();
              },
            ),
          );
          showMessageInSnackbar("OTP Verification Successful!");
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void handleError(PlatformException error) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        showAlertDialog(context, 'Invalid Code');
        break;
      default:
        showAlertDialog(context, error.message);
        break;
    }
  }

  void showAlertDialog(BuildContext context, String message) {
    final AlertDialog alert = AlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        new TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.red[400], width: 1)),
          )),
          child: new Text(
            "Close",
            style: TextStyle(color: Colors.red[400]),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showMessageInSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.lightGreen,
    ));
  }
}
