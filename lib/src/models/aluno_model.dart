class AlunoModel {
  final String id;
  final String nome;
  final int idade;
  final String turma;

  AlunoModel({
    required this.id,
    required this.nome,
    required this.idade,
    required this.turma,
  });

  factory AlunoModel.fromFireStore(
    Map<String, dynamic> data,
    String documentId,
  ) {
    return AlunoModel(
      id: documentId,
      nome: data["nome"],
      idade: data["idade"],
      turma: data["turma"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "idade": idade,
      "turma": turma
    };
  }
}
