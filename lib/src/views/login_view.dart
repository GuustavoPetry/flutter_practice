// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:utilidades/src/controllers/login_controller.dart';
import 'package:utilidades/src/models/user_model.dart';
import 'package:utilidades/src/services/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = LoginController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = "";
  bool _isLoading = false;

  // void _handleLogin() async {
  //   final sucess = await _controller.login(
  //     _usernameController.text,
  //     _passwordController.text
  //   );

  //   if(sucess) {
  //     AuthService.login();
  //     Navigator.pushReplacementNamed(context, "/home");
  //   } else {
  //     setState(() {
  //       _message = "Credenciais Inválidas";
  //     });
  //   }
  // }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    final user = UserModel(
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final sucess = await _controller.login(user);

    setState(() {
      _isLoading = false;
    });

    if (sucess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Efetuado com sucesso")),
      );

      Navigator.pushReplacementNamed(context, "/home");
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Credenciais Inválidas")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.directional(bottom: 50),
              child: Image.asset("assets/images/utility.png", width: 200),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Usuário",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _handleLogin,
              child: _isLoading ? CircularProgressIndicator() : Text("Entrar"),
            ),
            SizedBox(height: 10),
            Text(_message, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
