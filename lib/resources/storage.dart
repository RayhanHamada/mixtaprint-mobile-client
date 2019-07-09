import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'app.dart';
import 'auth.dart';

class Storage
{
  static final FirebaseStorage storage = FirebaseStorage.instance;
  
  static Future<void> uploadToStorage(File file) async
  {
    await Auth.auth.currentUser().then((user) async {
      storage.ref().child('users/users_consumen/${user.uid}/${file.path.split('/').last}').putFile(file);
    });
  }
}
