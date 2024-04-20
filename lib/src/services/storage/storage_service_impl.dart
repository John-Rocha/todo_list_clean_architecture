import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_list_clean_architecture/src/services/storage/storage_service.dart';

class StorageServiceImpl implements StorageService {
  @override
  Future<String?> uploadImage(File? image, String imageName) async {
    if (image == null) {
      return null;
    }

    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('images').child(imageName);
    await ref.putFile(image).whenComplete(() {});
    return ref.getDownloadURL();
  }
}
