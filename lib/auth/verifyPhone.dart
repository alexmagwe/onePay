import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onepay/utils/constants.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import '../utils/authentication.dart';

class VerifyPhonePage extends StatefulWidget {
  final String verificationId;
  const VerifyPhonePage({Key? key, required this.verificationId})
      : super(key: key);

  @override
  VerifyPhoneState createState() => VerifyPhoneState();
}

class VerifyPhoneState extends State<VerifyPhonePage> {
  TextEditingController phoneController = TextEditingController();
  late dynamic _verificationId;
  // @override
  // void dispose() {
  //   phoneController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    _verificationId = widget.verificationId;
    return Scaffold(
        // backgroundColor: Colors.white,
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
                color: Colors.white60,
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
              otpFieldStyle: OtpFieldStyle(
                  borderColor: Colors.white70,
                  enabledBorderColor: Colors.white70),
              style: TextStyle(
                fontSize: 16,
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: _verificationId, smsCode: pin);
                Navigator.of(context).pop(credential);
                // Authentication.linkWithPhone(
                // context: context,
                // phoneNumber:phoneNumber
                // verificationId: _verificationId,
                // smsCode: pin);
              },
            ),
          ],
        ),
      ),
    )));
  }
}
