import 'package:flutter/material.dart';

class LoginFirebaseView extends StatefulWidget {
  const LoginFirebaseView({super.key});

  @override
  State<LoginFirebaseView> createState() => _LoginFirebaseViewState();
}

class _LoginFirebaseViewState extends State<LoginFirebaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login com Firebase")),
      body: Padding(padding: EdgeInsets.all(16)),
    );
  }
}
