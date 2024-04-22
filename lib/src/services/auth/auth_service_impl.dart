import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_list_clean_architecture/src/core/exceptions/auth_exception.dart';
import 'package:todo_list_clean_architecture/src/models/user_model.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';
import 'package:todo_list_clean_architecture/src/services/database/user_database_service.dart';

class AuthServiceImpl implements AuthService {
  final _auth = FirebaseAuth.instance;
  final UserDatabaseService _userDatabase;

  AuthServiceImpl({required UserDatabaseService userDatabase})
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
    File? image,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        await signIn(email: email, password: password);

        //handle image upload
        final imageName = '${user.uid}.jpg';
        final imageUrl = await _uploadImage(image, imageName);

        // Update user profile
        await user.updateDisplayName(name);
        await user.updatePhotoURL(imageUrl);
        await user.reload();

        // Save user data in Firestore
        final userModel = UserModel(
          id: user.uid,
          name: name,
          email: email,
          imageUrl: imageUrl,
        );
        await _userDatabase.createUser(userModel);

        return user;
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

  Future<String?> _uploadImage(File? image, String imageName) async {
    if (image == null) {
      return null;
    }

    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('images').child(imageName);
    await ref.putFile(image);
    return ref.getDownloadURL();
  }
}
