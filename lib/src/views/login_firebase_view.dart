import 'package:flutter/material.dart';
import 'package:utilidades/src/controllers/usuario_firebase_controller.dart';

class LoginFirebaseView extends StatefulWidget {
  const LoginFirebaseView({super.key});

  @override
  State<LoginFirebaseView> createState() => _LoginFirebaseViewState();
}

class _LoginFirebaseViewState extends State<LoginFirebaseView> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? erro;

  final controller = UsuarioFirebaseController();

  void _abrirCadastro() {
    Navigator.pushNamed(context, "/register-firebase");
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final usuario = await controller.autenticar(
        emailController.text,
        senhaController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (!mounted) return;

      if (usuario != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login Efetuado com Sucesso")));
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        setState(() {
          erro = "Credenciais Inválidas";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login com Firebase")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (erro != null) ...[
                Text(erro!, style: TextStyle(color: Colors.red)),
                SizedBox(height: 20),
              ],
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                controller: emailController,
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe o E-mail" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
                controller: senhaController,
                validator: (value) =>
                    value == null || value.length < 6 ? "Senha Inválida" : null,
              ),
              SizedBox(height: 20),
              // Botão ou Loading
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(onPressed: _login, child: Text("Entrar")),
              SizedBox(height: 30),
              TextButton(
                onPressed: _abrirCadastro,
                child: Text("Criar uma Conta"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
