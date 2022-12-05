import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/models/post_model.dart';
import 'package:facebook_clone/others/constants/constants.dart';
import 'package:facebook_clone/others/repository/firebase_repository.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PostRepository {
  final FirebaseFirestore firestore;

  PostRepository({required this.firestore});

  Future<void> uploadPost(BuildContext context, String description, File? file,
      String uid, String name, String lastName, String profImage) async {
    try {
      String photoUrl = Constants.emptyPost;

      if (file != null) {
        photoUrl = await CommonFirebaseStorageRepository(
                firebaseStorage: FirebaseStorage.instance,
                auth: FirebaseAuth.instance)
            .storeFileToFirebase('posts', file, true);
      }

      String postId = const Uuid().v1();

      PostModel post = PostModel(
          description: description,
          uid: uid,
          name: name,
          lastName: lastName,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      firestore.collection('posts').doc(postId).set(post.toJson());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
