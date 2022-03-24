import 'package:flutter/material.dart';
import 'package:onepay/navigation/drawer.dart';
import 'package:onepay/utils/routes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('OnePay')),
        drawer: const AppDrawer(),
        floatingActionButton: FloatingActionButton(
            onPressed: () => {Navigator.pushNamed(context, Routes.home)},
            child: const Icon(Icons.add)),
        body: const Center(child: Text('onePay')));
  }
}
