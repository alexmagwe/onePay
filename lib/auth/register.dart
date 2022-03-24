import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onepay/auth/verify.dart';

import '../utils/routes.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String country_code = '+254';

  Future getOTP(
    String number,
  ) async {
    final phoneNumber = country_code + number;
    FirebaseAuthException res = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VerifyPhonePage(phoneNumber: phoneNumber)));
    final snackBar = SnackBar(
      content: Text(res.message ?? "error occured"),
    );
// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                Text(
                    'Add your phone number,we\'ll send you a verification code to know you\'re real',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 20),
                TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Phone Number",
                        prefix: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text('+254',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))))),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => getOTP(_phoneController.text),
                        child: Text('Send')))
              ],
            ),
          ),
        )));
    ;
  }
}
