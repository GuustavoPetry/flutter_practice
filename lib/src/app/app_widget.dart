import 'package:flutter/material.dart';
import 'package:utilidades/src/app/routes.dart';
import 'package:utilidades/src/views/login_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Utilidades",
      initialRoute: "/home",
      routes: {
        "/login": (context) => LoginView(),
        ...generateRoutes()
      },
    );
  }
}