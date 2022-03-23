import 'package:flutter/material.dart';

class UpdatePhonePage extends StatefulWidget {
  const UpdatePhonePage({Key? key}) : super(key: key);

  @override
  UpdatePhoneState createState() => UpdatePhoneState();
}

class UpdatePhoneState extends State<UpdatePhonePage> {
  TextEditingController phoneController = TextEditingController();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void handlePress() {
    print(phoneController.text);
    // send stk
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 80, 50, 0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        hintText: "Phone Number",
                        prefix: Padding(
                            padding: EdgeInsets.all(5), child: Text('+254')))),
                ElevatedButton(
                    onPressed: handlePress, child: const Text('Update')),
              ],
            ),
          ),
        )));
  }
}
