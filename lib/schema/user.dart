import 'package:firebase_auth/firebase_auth.dart';
import 'package:onepay/utils/constants.dart' as c;

class UserSchema {
  final String email;
  final String name;
  String phoneNumber;
  UserSchema(
      {required this.email, required this.phoneNumber, required this.name});

  Map<String, Object> toJson() {
    return {c.email: email, c.phoneNumber: phoneNumber, c.name: name};
  }

  UserSchema.fromJson(dynamic json)
      : this(
            email: json.email,
            phoneNumber: json.phoneNumber ?? '',
            name: json.displayName);
}
