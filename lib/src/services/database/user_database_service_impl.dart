import 'package:todo_list_clean_architecture/src/models/user_model.dart';
import 'package:todo_list_clean_architecture/src/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseServiceImpl implements UserDatabaseService {
  final _db = FirebaseFirestore.instance;

  @override
  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  @override
  Future<void> deleteUser(String uid) async {
    await _db.collection('users').doc(uid).delete();
  }

  @override
  Future<UserModel?> getUser(String uid) async {
    final snapshot = await _db.collection('users').doc(uid).get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      return UserModel.fromMap(data);
    } else {
      return null;
    }
  }

  @override
  Future<void> updateUser(String uid, UserModel user) async {
    await _db.collection('users').doc(uid).update(user.toMap());
  }
}
