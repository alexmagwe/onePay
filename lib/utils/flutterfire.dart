import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onepay/utils/constants.dart' as c;

class FlutterFire {
  static Future<bool> addUser(User user, String phoneNumber) async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection(c.users);
    try {
      await userRef.doc(user.uid).set({phoneNumber: phoneNumber});
      return true;
    } catch (err) {
      return false;
    }
  }

  static Future<bool> addTag(User user, String id) async {
    try {
      FirebaseFirestore.instance
          .collection(c.users)
          .doc(user.uid)
          .update({c.tags: id});
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}
