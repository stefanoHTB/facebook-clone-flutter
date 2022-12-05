import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String uid;
  final String name;
  final String lastName;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const PostModel(
      {required this.description,
      required this.uid,
      required this.name,
      required this.lastName,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      required this.likes});

  //methods
  //this method converts everthing to object file to we dont have to write everthing again
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "name": name,
        "lastName": lastName,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes,
        "postUrl": postUrl,
      };

  // method to convert a doc snapshot to user model (this is used for get user details in ui)

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      name: snapshot['name'],
      lastName: snapshot['lastName'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
      postUrl: snapshot['postUrl'],
    );
  }
}
