import 'package:flutter/material.dart';
import 'package:utilidades/src/models/aluno_model.dart';

class AlunosView extends StatefulWidget {
  const AlunosView({super.key});

  @override
  State<AlunosView> createState() => _AlunosViewState();
}

class _AlunosViewState extends State<AlunosView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: StreamBuilder<List<AlunoModel>>(
        stream: ,
      ),
    );
  }
}