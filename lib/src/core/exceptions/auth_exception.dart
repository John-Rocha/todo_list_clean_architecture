import 'package:firebase_auth/firebase_auth.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return 'AuthException: $message';
  }
}

void handleFirebaseAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      throw AuthException('E-mail já está em uso');
    case 'weak-password':
      throw AuthException('Senha fraca');
    case 'user-not-found':
      throw AuthException('Usuário não encontrado');
    case 'wrong-password':
      throw AuthException('Senha incorreta');
    case 'user-disabled':
      throw AuthException('Usuário desabilitado');
    case 'too-many-requests':
      throw AuthException('Muitas tentativas. Tente novamente mais tarde');
    case 'operation-not-allowed':
      throw AuthException('Operação não permitida');
    default:
      throw AuthException('Erro desconhecido');
  }
}
