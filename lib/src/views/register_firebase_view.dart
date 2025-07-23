import 'package:flutter/material.dart';
import 'package:utilidades/src/controllers/usuario_firebase_controller.dart';

class RegisterFirebaseView extends StatefulWidget {
  const RegisterFirebaseView({super.key});

  @override
  State<RegisterFirebaseView> createState() => _RegisterFirebaseViewState();
}

class _RegisterFirebaseViewState extends State<RegisterFirebaseView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final controller = UsuarioFirebaseController();
  bool isLoading = false;
  String? erro;

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final usuario = await controller.cadastrar(
        _nomeController.text,
        _emailController.text,
        _senhaController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (!mounted) return;

      if (usuario != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Usuário Cadastrado com Sucesso")),
        );
        Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));
      } else {
        setState(() {
          erro = "Cadastro não realizado!";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro Firebase")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Se condição verdadeira as reticências indicam que irá continuar a escrita da lista de Widgets
              if (erro != null) ...[
                Text(erro!, style: TextStyle(color: Colors.red)),
                SizedBox(height: 20),
              ],
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                controller: _nomeController,
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe seu Nome" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "E-mail"),
                controller: _emailController,
                validator: (value) => value == null || value.isEmpty
                    ? "Informe seu e-mail"
                    : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
                controller: _senhaController,
                validator: (value) => value == null || value.length < 6
                    ? "Senha Muito Curta"
                    : null,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _cadastrar,
                      child: Text("Cadastrar"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
