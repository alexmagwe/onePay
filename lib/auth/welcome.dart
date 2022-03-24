import 'package:flutter/material.dart';
import 'package:onepay/utils/routes.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    void _navigate(String route) {
      Navigator.pushNamed(context, route);
    }

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                    child: Text('Lets get started',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45))),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () => _navigate(Routes.login),
                    child: Text('Login')),
                ElevatedButton(
                    onPressed: () => _navigate(Routes.register),
                    child: Text('Register'))
              ],
            )));
  }
}
