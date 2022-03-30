import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onepay/utils/authentication.dart';
import 'package:onepay/utils/flutterfire.dart';

import '../../utils/constants.dart';

class AddTagId extends StatefulWidget {
  const AddTagId({Key? key}) : super(key: key);

  @override
  State<AddTagId> createState() => _AddTagIdState();
}

class _AddTagIdState extends State<AddTagId> {
  final TextEditingController _id = TextEditingController();
  final int maxLength = 8;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('Enter Tag Id '),
                ),
                SizedBox(height: 20),
                TextFormField(
                  autofocus: true,
                  controller: _id,
                  decoration: InputDecoration(
                      hintText: 'Id found on the tag', labelText: 'Tag id'),
                  maxLength: 8,
                  validator: (String? val) {
                    return (val != null && val.length < 8) ? 'too short' : null;
                  },
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.cyan[300]),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          bool res = await FlutterFire.addTag(user!, _id.text);
                          Navigator.of(context).pop(res);
                        }))
              ],
            )),
          )),
    );
  }
}
