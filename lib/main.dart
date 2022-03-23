import 'package:flutter/material.dart';
import 'package:onepay/auth/update_phone.dart';
import 'package:onepay/auth/login_page.dart';
import 'package:onepay/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => const LoginPage(),
    '/home': (context) => const Home(),
    '/otp': (context) => const UpdatePhonePage()
  }));
}
