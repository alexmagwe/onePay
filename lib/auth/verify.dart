import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import '../utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneNumber {
  final String phoneNumber;
  const PhoneNumber(this.phoneNumber);
}

class VerifyPhonePage extends StatefulWidget {
  final dynamic phoneNumber;
  const VerifyPhonePage({Key? key, this.phoneNumber}) : super(key: key);

  @override
  VerifyPhoneState createState() => VerifyPhoneState();
}

class VerifyPhoneState extends State<VerifyPhonePage> {
  TextEditingController phoneController = TextEditingController();
  dynamic _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // @override
  // void dispose() {
  //   phoneController.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    super.initState();
    _verifyNumber(widget.phoneNumber);
  }

  void _verifyNumber(phoneNumber) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (id) async {});
  }

  void verificationCompleted(credential) async {
    await _auth
        .signInWithCredential(credential)
        .then((val) {
          Navigator.pushReplacementNamed(context, Routes.home);
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          setState(() {
            print(error);
          });
        });
  }

  void verificationFailed(FirebaseAuthException error) async {
    Navigator.pop(context, error);

    //show error
  }

  void codeSent(dynamic verificationId, resendToken) async {
    setState(() {
      _verificationId = verificationId;
    });
  }

  void signIn(smsCode) async {
    var credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);
    await _auth
        .signInWithCredential(credential)
        .then((val) {
          print('code result:${val}');
          Navigator.pushReplacementNamed(context, Routes.home);
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          Navigator.pop(context, error);
        });
  }

  void handlePress() {
    Navigator.pushNamed(context, '/home');
    // send stk
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
            onPressed: () => {Navigator.pushNamed(context, Routes.home)},
            child: const Icon(Icons.arrow_right_alt_rounded)),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 80, 50, 0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                OTPTextField(
                  width: MediaQuery.of(context).size.width * 0.8,
                  length: 6,
                  fieldWidth: 30,
                  style: TextStyle(fontSize: 16),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    signIn(pin);
                  },
                ),
              ],
            ),
          ),
        )));
  }
}
