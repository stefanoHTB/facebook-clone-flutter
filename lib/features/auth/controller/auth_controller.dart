import 'dart:io';

import 'package:facebook_clone/features/auth/repository/auth_repository.dart';
import 'package:facebook_clone/models/user_mode.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//--------------------------Repository Provider -------------------------------

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

//-------------------------------------------------- get user state -----------

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

//--------------------------------------------------- get user data -----------

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final userProvider = StateProvider<UserModel?>((ref) => null); //store data

//
//
//
//
//
//
//

//----------------------------AUTH CONTROLLER ----------------------------------

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  //-------- get user state -----

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  //-------- get user data ------

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  //------------------------------------------------------ login function

  void loginUser(BuildContext context, String email, String password) async {
    state = true;
    final user = await _authRepository.loginUser(email, password);
    state = false;
    user.fold(
        (l) => showSnackBar(context: context, content: l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  //------------------------------------------------------- register function

  void registerUser(BuildContext context, String email, String password) async {
    state = true;
    final newUser =
        await _authRepository.registerWithEmailPassword(email, password);
    state = false;
    newUser.fold(
        (l) => showSnackBar(context: context, content: l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  //------------------------------------------------------ save user data func

  void saveUserDataToFirebase(BuildContext context, String name,
      String lastName, File? profilePic) async {
    state = true;
    final userInfo = await _authRepository.saveUserDataToFirebase(
        name, lastName, profilePic);
    state = false;
    userInfo.fold(
        (l) => showSnackBar(context: context, content: l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  //--------------------------------------------------------
}
