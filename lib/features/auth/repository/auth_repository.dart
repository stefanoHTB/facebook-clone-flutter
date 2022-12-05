import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/models/user_mode.dart';
import 'package:facebook_clone/others/constants/constants.dart';
import 'package:facebook_clone/others/failure.dart';
import 'package:facebook_clone/others/providers/firebase_providers.dart';
import 'package:facebook_clone/others/repository/firebase_repository.dart';
import 'package:facebook_clone/others/type_defs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

//--------------------Firebase providers ------------

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
  ),
);

//------------------------------------------------
//
//
//
//
//
//
//-------------------- AUTH REPOSITORY------------------------------------------

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _auth = auth,
        _firestore = firestore;

  //---------------------------get state getter

  Stream<User?> get authStateChange => _auth.authStateChanges();

  //-------------------------- get data function

  Stream<UserModel> getUserData(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  //------------------------------------------------ register function

  FutureEither<UserModel> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      var userCredentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel userModel;

      userModel = UserModel(
          name: '',
          lastName: '',
          uid: userCredentials.user!.uid,
          profilePic: '',
          banner: '',
          friends: []);

      _firestore
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set(userModel.toMap());

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //-------------------------------------------------- login function

  FutureEither<UserModel> loginUser(String email, String password) async {
    try {
      var userCredentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel userModel;

      userModel = await getUserData(userCredentials.user!.uid).first;

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //-------------------------------------------------  save user data function

  FutureEither<UserModel> saveUserDataToFirebase(
    String name,
    String lastName,
    File? profilePic,
  ) async {
    try {
      String uid = _auth.currentUser!.uid;
      String photoUrl = Constants.avatarDefault;

      if (profilePic != null) {
        photoUrl = await CommonFirebaseStorageRepository(
                firebaseStorage: FirebaseStorage.instance,
                auth: FirebaseAuth.instance)
            .storeFileToFirebase('profilePic/$uid', profilePic, false);
      }
      UserModel userModel;

      userModel = UserModel(
          name: name,
          lastName: lastName,
          uid: uid,
          profilePic: photoUrl,
          banner: '',
          friends: []);

      await _firestore.collection('users').doc(uid).update(userModel.toMap());

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  //--------------------------------------------------------------------
}
