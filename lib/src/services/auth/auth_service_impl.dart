import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password, required String name}) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }
}
