// Autenticação e cadastro usando Firebase
class UsuarioFirebaseModel {
  final String uid; // equivalente ao "id"
  final String nome;
  final String email;

  UsuarioFirebaseModel({
    required this.uid,
    required this.nome,
    required this.email
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "nome": nome,
      "email": email
    };
  }

  factory UsuarioFirebaseModel.fromMap(Map<String, dynamic> map) {
    return UsuarioFirebaseModel(
      uid: map["uid"], 
      nome: map["nome"], 
      email: map["email"]
    );
  }
}