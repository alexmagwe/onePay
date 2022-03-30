import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onepay/navigation/drawer.dart';
import 'package:onepay/schema/user.dart';
import 'package:onepay/utils/routes.dart';

import '../utils/authentication.dart';
import '../utils/constants.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(title: const Text('OnePay')),
        drawer: const AppDrawer(),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              dynamic res =
                  await Navigator.pushNamed(context, Routes.addTagWithId);
              if (res) {
                Authentication.customSnackBar(
                    content: 'added tag succesfully',
                    type: MessageTypes.success);
              }
            },
            child: const Icon(Icons.add)),
        body: Center(child: Text(user.displayName!)));
  }
}
