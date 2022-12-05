import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/models/reels_model.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class ReelsRepository {
  final FirebaseStorage storage;
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ReelsRepository(
      {required this.storage, required this.auth, required this.firestore});

  getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  /////////////////////////////////////////////////////////////////////

  Future<String> uploadImagetoStorage(String id, String videoPath) async {
    Reference ref = storage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  /////////////////////////////////////////////////////////////////////

  compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
        videoPath, //we are saving videos with medium quality testing puropses
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  ////////////////////////////////////////////////////////////////////////

  Future<String> uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = storage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  ///////////////////////////////////////////////////////////////////////

  uploadVideo(
    String videoPath,
    BuildContext context,
  ) async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      //get id
      var allDocs = await firestore.collection('reels').get();
      int len = allDocs.docs.length;
      String videoUrl = await uploadVideoToStorage("Video $len", videoPath);
      //tumbnail
      String thumbnail = await uploadImagetoStorage("Video $len", videoPath);

      String postId = const Uuid().v1();

      // create video model
      ReelsModel video = ReelsModel(
          name: (userDoc.data()! as Map<String, dynamic>)['name'],
          lastName: (userDoc.data()! as Map<String, dynamic>)['lastName'],
          uid: uid,
          id: postId,
          //"Video $len",
          datePublished: DateTime.now(),
          likes: [],
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePhoto:
              (userDoc.data()! as Map<String, dynamic>)['profilePic']);
      //save in collection
      await firestore.collection('reels').doc(postId).set(video.toJson());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
