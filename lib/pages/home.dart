import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('onePay')));
  }
}
