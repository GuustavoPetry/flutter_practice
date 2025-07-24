import 'package:flutter/material.dart';
import 'package:utilidades/src/controllers/alunos_controller.dart';
import 'package:utilidades/src/models/aluno_model.dart';

class AlunosView extends StatefulWidget {
  const AlunosView({super.key});

  @override
  State<AlunosView> createState() => _AlunosViewState();
}

class _AlunosViewState extends State<AlunosView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _turmaController = TextEditingController();
  final controller = AlunosController();

  bool enviarFormulario(String action, String? idAluno) {
    if (_formKey.currentState!.validate()) {
      final nome = _nomeController.text.trim();
      final idade = int.tryParse(_idadeController.text.trim()) ?? 0;
      final turma = _turmaController.text.trim();

      if (action == "add") {
        controller.adicionarAluno(
          AlunoModel(id: "", nome: nome, idade: idade, turma: turma),
        );
      } else {
        controller.atualizarAluno(
          AlunoModel(id: idAluno!, nome: nome, idade: idade, turma: turma),
        );
      }
      return true;
    }
    return false;
  }

  void _abrirDialog({AlunoModel? aluno}) {
    String tituloDialog = "Cadastrar Aluno";
    String action = "add";
    if (aluno != null) {
      _nomeController.text = aluno.nome;
      _idadeController.text = aluno.idade.toString();
      _turmaController.text = aluno.turma;
      tituloDialog = "Editar Aluno";
      action = "edit";
    } else {
      _nomeController.clear();
      _idadeController.clear();
      _turmaController.clear();
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(tituloDialog),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                controller: _nomeController,
                validator: (v) => v!.isEmpty ? "Informe um Nome" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Idade"),
                keyboardType: TextInputType.number,
                controller: _idadeController,
                validator: (v) => v!.isEmpty ? "Informe a Idade" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Turma"),
                controller: _turmaController,
                validator: (v) => v!.isEmpty ? "Informe a Turma" : null,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.close),
          ),
          ElevatedButton(
            onPressed: () => {
              if (enviarFormulario(action, aluno?.id))
                {Navigator.pop(context)}
              else
                {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Erro ao Salvar"))),
                },
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.save), SizedBox(width: 5), Text("Salvar")],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: StreamBuilder<List<AlunoModel>>(
          stream: controller.getAlunos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Nenhum Dado Encontrado"));
            }

            final alunos = snapshot.data!;

            return ListView.builder(
              itemCount: alunos.length,
              itemBuilder: (context, index) {
                final aluno = alunos[index];

                return ListTile(
                  title: Text(aluno.nome),
                  subtitle: Text(
                    "Idade: ${aluno.idade} | Turma: ${aluno.turma}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _abrirDialog(aluno: aluno),
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => controller.deletarAluno(aluno.id),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
