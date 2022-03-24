import 'package:flutter/material.dart';
import 'package:onepay/auth/register.dart';
import 'package:onepay/auth/verify.dart';
import 'package:onepay/auth/login.dart';
import 'package:onepay/auth/welcome.dart';
import 'package:onepay/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onepay/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
          backgroundColor: Colors.white, primaryColor: Colors.black87),
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.start: (context) => const Welcome(),
        Routes.verifyNumber: (context) => const VerifyPhonePage(),
        Routes.login: (context) => const LoginPage(),
        Routes.register: (context) => const Register(),
        Routes.home: (context) => const Home(),
        // '/otp': (context) => const UpdatePhonePage()
      }));
}
