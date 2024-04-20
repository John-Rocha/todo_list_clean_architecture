import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_clean_architecture/src/core/exceptions/auth_exception.dart';
import 'package:todo_list_clean_architecture/src/models/user_model.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';
import 'package:todo_list_clean_architecture/src/services/database/user_database.dart';

class AuthServiceImpl implements AuthService {
  final _auth = FirebaseAuth.instance;
  final UserDatabase _userDatabase;

  AuthServiceImpl({required UserDatabase userDatabase})
      : _userDatabase = userDatabase;

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
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
      final user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        final latestUser = currentUser;

        // Save user data in Firestore
        if (latestUser != null) {
          final user = UserModel(
            id: latestUser.uid,
            name: name,
            email: email,
            photoUrl: 'photoUrl',
          );
          await _userDatabase.createUser(user);
        }

        return latestUser;
      }
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao criar usuário', error: e, stackTrace: s);
      handleFirebaseAuthError(e);
    }
    return null;
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
  User? get currentUser => _auth.currentUser;
}
