import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User?> signIn({
    required String email,
    required String password,
  });
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
    File? image,
  });
  Future<void> signOut();

  User? get currentUser;
}
