import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String lastName;
  final String uid;
  final String profilePic;
  final String banner;
  final List friends;

  UserModel({
    required this.name,
    required this.lastName,
    required this.uid,
    required this.profilePic,
    required this.banner,
    required this.friends,
  });

//////////////////////////////////////////////////////////
  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      name: snapshot['name'],
      uid: snapshot['uid'],
      lastName: snapshot['lastName'],
      profilePic: snapshot['profilePic'],
      banner: snapshot['banner'],
      friends: snapshot['friends'],
    );
  }
  //////////////////////////////////////////////////////////

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lastName': lastName,
      'uid': uid,
      'profilePic': profilePic,
      'banner': banner,
      'friends': friends,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        lastName: map['lastName'] ?? '',
        uid: map['uid'] ?? '',
        profilePic: map['profilePic'] ?? '',
        banner: map['banner'] ?? '',
        friends: List<String>.from(
          (map['friends']),
        ));
  }
}
