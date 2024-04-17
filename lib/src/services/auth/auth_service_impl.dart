import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_clean_architecture/src/core/exceptions/auth_exception.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao fazer login', error: e, stackTrace: s);
      handleFirebaseAuthError(e);
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name);
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao criar usuário', error: e, stackTrace: s);
      handleFirebaseAuthError(e);
    }
  }

  @override
  Future<void> signOut() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();
  }
}
