import 'package:todo_list_clean_architecture/src/models/user_model.dart';

abstract class UserDatabaseService {
  Future<void> createUser(UserModel user);
  Future<void> updateUser(String uid, UserModel user);
  Future<void> deleteUser(String uid);
  Future<UserModel?> getUser(String uid);
}
