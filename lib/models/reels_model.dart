import 'package:cloud_firestore/cloud_firestore.dart';

class ReelsModel {
  String name;
  String lastName;
  final datePublished;
  String uid;
  String id;
  List likes;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  ReelsModel(
      {required this.name,
      required this.lastName,
      required this.uid,
      required this.id,
      required this.datePublished,
      required this.likes,
      required this.videoUrl,
      required this.thumbnail,
      required this.profilePhoto});

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "uid": uid,
        "datePublished": datePublished,
        "profilePhoto": profilePhoto,
        "id": id,
        "likes": likes,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail
      };

  static ReelsModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReelsModel(
        name: snapshot['name'],
        lastName: snapshot['lastname'],
        uid: snapshot['uid'],
        id: snapshot['uid'],
        datePublished: snapshot['datePublished'],
        likes: snapshot['likes'],
        videoUrl: snapshot['videoUrl'],
        thumbnail: snapshot['thumbnail'],
        profilePhoto: snapshot['profilePhoto']);
  }
}
