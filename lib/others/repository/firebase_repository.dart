// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class CommonFirebaseStorageRepository {
  FirebaseStorage firebaseStorage;
  FirebaseAuth auth;
  CommonFirebaseStorageRepository(
      {required this.firebaseStorage, required this.auth});

////////////////////////////////////////////////////////////////////////////////
  Future<String> storeFileToFirebase(
      String child, File file, bool isPost) async {
    Reference ref =
        firebaseStorage.ref().child(child).child(auth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
