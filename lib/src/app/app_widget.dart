import 'package:flutter/material.dart';
import 'package:utilidades/src/animations/splash_app.dart';
import 'package:utilidades/src/app/routes.dart';
import 'package:utilidades/src/views/login_firebase_view.dart';
import 'package:utilidades/src/views/login_view.dart';
import 'package:utilidades/src/views/register_firebase_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Utilidades",
      initialRoute: "/splash",
      routes: {
        "/login": (context) => const LoginView(),
        "/login-firebase": (context) => const LoginFirebaseView(),
        "/register-firebase": (context) => const RegisterFirebaseView(),
        "/splash": (context) => const SplashApp(),
        ...generateRoutes(),
      },
    );
  }
}
