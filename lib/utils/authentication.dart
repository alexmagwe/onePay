import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onepay/auth/welcome.dart';
import 'package:onepay/pages/home.dart';
import 'package:onepay/schema/user.dart';
import 'package:onepay/utils/constants.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    // UserSchema userSchema = UserSchema.fromJson(user);
    if (user != null) {
      print('schema $user');
      var userSchema = UserSchema.fromJson(user);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }
    return firebaseApp;
  }

  static SnackBar customSnackBar(
      {required String content, MessageTypes type = MessageTypes.error}) {
    return SnackBar(
      duration: Duration(seconds: 10),
      backgroundColor:
          type == MessageTypes.error ? Colors.black : Colors.green[700],
      content: Text(
        content,
        style: type == MessageTypes.error
            ? TextStyle(color: Colors.redAccent, letterSpacing: 0.5)
            : TextStyle(color: Colors.white, letterSpacing: 0.5),
      ),
    );
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(content: e.toString()),
        );
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                content:
                    'The account already exists with a different credential',
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                content:
                    'Error occurred while accessing credentials. Try again.',
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'Error occurred using Google Sign In. Try again.',
            ),
          );
        }
      }
    }

    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Welcome()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  ///after otp has been entered
  static void linkWithPhone({context, verificationId, smsCode}) async {
    CollectionReference firestore =
        FirebaseFirestore.instance.collection(users);
    User? user = FirebaseAuth.instance.currentUser;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await FirebaseAuth.instance.currentUser!.updatePhoneNumber(credential);
      print('what we are saving:$credential');
      // UserSchema _u = UserSchema.fromJson(user);

      await firestore
          .doc(user?.uid)
          .set({email: user?.email, name: user?.displayName});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Phone number linked succesfully',
        ),
      );
    } catch (error) {
      Navigator.pop(context, error);
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: error.toString(),
        ),
      );
    }
  }
}
