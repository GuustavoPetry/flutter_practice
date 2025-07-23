import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utilidades/src/models/usuario_firebase_model.dart';

class AuthFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UsuarioFirebaseModel?> registrarUsuario(
    String nome,
    String email,
    String senha,
  ) async {
    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      UsuarioFirebaseModel usuario = UsuarioFirebaseModel(
        uid: credentials.user!.uid,
        nome: nome,
        email: email,
      );

      await _firestore
          .collection("usuarios")
          .doc(usuario.uid)
          .set(usuario.toMap());

      return usuario;
    } catch (e) {
      print("Erro ao Registrar Usuário: $e");
      return null;
    }
  }

  Future<UsuarioFirebaseModel?> login(String email, String senha) async {
    try {
      UserCredential credentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      DocumentSnapshot snapshot = await _firestore
          .collection("usuarios")
          .doc(credentials.user!.uid)
          .get();
          
      return UsuarioFirebaseModel.fromMap(snapshot.data() as Map<String, dynamic>);

    } catch (e) {
      print("Erro ao efetuar login: $e");
      return null;
    }
  }
}
