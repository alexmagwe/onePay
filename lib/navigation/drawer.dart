// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:onepay/utils/routes.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _DrawerState();
}

class _DrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
            accountName: Text('Alex'),
            accountEmail: Text('alexmagwe@gmail.com')),
        ListTile(
            onTap: () => {Navigator.pushReplacementNamed(context, Routes.home)},
            leading: Icon(Icons.rss_feed_rounded),
            title: Text('My Tags')),
        ListTile(
            onTap: () =>
                {Navigator.pushReplacementNamed(context, Routes.history)},
            leading: Icon(Icons.history_rounded),
            title: Text('My Transactions')),
        ListTile(
            onTap: () =>
                {Navigator.pushReplacementNamed(context, Routes.futurePay)},
            leading: Icon(Icons.timer),
            title: Text('Future Pay')),
        ListTile(
            onTap: () =>
                {Navigator.pushReplacementNamed(context, Routes.settings)},
            leading: Icon(Icons.settings),
            title: Text('Settings')),
      ],
    ));
  }
}
