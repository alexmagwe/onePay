import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onepay/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final controller = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? _googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth?.accessToken,
      idToken: _googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(user);
      Navigator.pushReplacementNamed(context, Routes.home);
    } catch (err) {
      //print(err)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
        child: Column(children: [
          ElevatedButton(
              onPressed: () => signInWithGoogle(),
              child: const Text('Sign in')),
        ]));
  }
}
