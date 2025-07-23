import 'package:utilidades/src/models/usuario_firebase_model.dart';
import 'package:utilidades/src/services/auth_firebase_service.dart';

class UsuarioFirebaseController {
  final AuthFirebaseService authService = AuthFirebaseService();

  Future<UsuarioFirebaseModel?> cadastrar(
    String nome,
    String email,
    String senha,
  ) {
    return authService.registrarUsuario(nome, email, senha);
  }

  Future<UsuarioFirebaseModel?> autenticar(String email, String senha) {
    return authService.login(email, senha);
  }
}
