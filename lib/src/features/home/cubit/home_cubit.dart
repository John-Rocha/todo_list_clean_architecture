import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required AuthService authService})
      : _authService = authService,
        super(HomeInitialState());

  final AuthService _authService;

  Future<void> updateDisplayName(String newDisplayName) async {
    emit(HomeLoadingState());
    try {
      final user = _authService.currentUser;
      if (user != null) {
        await user.updateDisplayName(newDisplayName);
        emit(HomeLoadedState(user: user));
      }
    } catch (e, s) {
      log('Erro ao atualizar nome', error: e, stackTrace: s);
      emit(HomeErrorState(message: 'Erro ao atualizar nome do usuário'));
    }
  }
}
