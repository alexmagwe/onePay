import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onepay/utils/google_signin_button.dart';
import 'package:onepay/utils/routes.dart';
import '../utils/authentication.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: const <Widget>[
                  Icon(
                    FontAwesomeIcons.boltLightning,
                    color: Colors.white,
                    size: 70.0,
                  ),
                  SizedBox(height: 40),
                  Center(
                      child: Text('onePay',
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 48,
                          )))
                ]),
                SizedBox(height: 10),
                Center(
                    child: Text('Pay for anything with a simple tap',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ))),
                // ElevatedButton(
                //     onPressed: () =>
                //         Navigator.pushNamed(context, Routes.register),
                //     child: Padding(
                //         padding: EdgeInsets.symmetric(
                //             vertical: 20, horizontal: 10),
                //         child: Text('Sign in with Phone Number'))),
                SizedBox(height: 40),
                GoogleSignInButton(),
              ],
            )));
  }
}
