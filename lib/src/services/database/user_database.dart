import 'package:todo_list_clean_architecture/src/models/user_model.dart';

abstract class UserDatabase {
  Future<void> createUser(String uid, String email, String name);
  Future<void> updateUser(String uid, UserModel user);
  Future<void> deleteUser(String uid);
  Future<UserModel?> getUser(String uid);
}
