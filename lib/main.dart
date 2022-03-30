import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onepay/auth/login.dart';
import 'package:onepay/auth/registerPhone.dart';
import 'package:onepay/auth/welcome.dart';
import 'package:onepay/pages/home.dart';
import 'package:onepay/pages/tag/add_id.dart';
import 'package:onepay/pages/tag/add_qr.dart';
import 'package:onepay/utils/authentication.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:onepay/utils/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.cyan,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.circular(10)))),
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.start: (context) => const Welcome(),
        Routes.home: (context) => const Home(),
        Routes.register: (context) => const Register(),
        Routes.addTagWithId: (context) => const AddTagId(),
        Routes.addTagWithQr: (context) => const AddTagQr(),
        // Routes.home: (context) => const Home(),
        // '/otp': (context) => const UpdatePhonePage()
      }));
  FlutterNativeSplash.remove();
}
