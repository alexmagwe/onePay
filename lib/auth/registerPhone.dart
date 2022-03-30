import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onepay/auth/verifyPhone.dart';
import 'package:onepay/pages/home.dart';
import 'package:onepay/utils/flutterfire.dart';
import '../utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onepay/utils/constants.dart' as c;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _sending = false;
  static const String countryCode = '+254';
//after otp has been sent
  void codeSent(dynamic verificationId, resendToken) async {
    PhoneAuthCredential res = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VerifyPhonePage(verificationId: verificationId)));

    bool _res =
        await FlutterFire.addUser(_auth.currentUser!, _phoneController.text);
    if (_res) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      Authentication.customSnackBar(
          content: 'Signed in sucessfully', type: c.MessageTypes.success),
    );
  }

  Future verifyNumber(phoneNumber) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (id) async {});
  }

  void verificationCompleted(credential) async {
    print('credential $credential');
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      User currUser = _auth.currentUser!;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference users = firestore.collection(c.users);

      try {
        // await _auth.currentUser!.linkWithCredential(credential);
        await users.doc(currUser.uid).set({
          'email': currUser.email,
          'phoneNumber': _phoneController.text,
          'name': currUser.displayName
        });
      } catch (err) {
        Authentication.customSnackBar(content: err.toString());
      }
      // Navigator.pushReplacementNamed(context, Routes.home);
    } on FirebaseAuthException catch (error, _) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: error.message!,
        ),
      );
    }
  }

  void verificationFailed(FirebaseAuthException error) async {
    // Navigator.pop(context, error);
    ScaffoldMessenger.of(context).showSnackBar(
      Authentication.customSnackBar(
        content: error.message!,
      ),
    );
  }

  Future getOTP() async {
    if (_sending) {
      final phoneNumber = countryCode + _phoneController.text;
      try {
        await verifyNumber(phoneNumber);
      } on FirebaseAuthException catch (error) {
        Authentication.customSnackBar(
          content: error.message!,
        );
        setState(() {
          _sending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () =>
        //         {Navigator.pushNamed(context, Routes.verifyNumber)},
        //     child: const Icon(Icons.arrow_right_alt_rounded)),
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.fromLTRB(50, 80, 50, 0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Add your phone number, we will send you a verification code ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
            SizedBox(height: 20),
            TextFormField(
                autofocus: true,
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  prefix: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text('+254',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Phone Number",
                )),
            SizedBox(height: 20),
            _sending == true
                ? CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _sending = true;
                          });

                          getOTP();
                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Text('Send')))),
          ],
        ),
      ),
    )));
  }
}
