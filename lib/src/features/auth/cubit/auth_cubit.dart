import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthService authService})
      : _authService = authService,
        super(AuthInitialState());

  final AuthService _authService;

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoadingState());
    try {
      await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      emit(AuthLoadedState(FirebaseAuth.instance.currentUser!));
    } catch (e, s) {
      log('Erro ao criar usuário', error: e, stackTrace: s);
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthLoadedState(FirebaseAuth.instance.currentUser!));
    } catch (e, s) {
      log('Erro ao fazer login', error: e, stackTrace: s);
      emit(AuthErrorState(e.toString()));
    }
  }
}
