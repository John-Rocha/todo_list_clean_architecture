import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_clean_architecture/src/core/exceptions/auth_exception.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao fazer login', error: e, stackTrace: s);
      handleFirebaseAuthError(e);
    }
    return null;
  }

  @override
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao criar usuário', error: e, stackTrace: s);
      handleFirebaseAuthError(e);
    }
    return null;
  }

  @override
  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;
}
