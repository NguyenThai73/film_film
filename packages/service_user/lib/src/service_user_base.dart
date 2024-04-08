// ignore_for_file: empty_catches, deprecated_member_use
// import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'model/user.model.dart';

class ServiceUser {
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;
  static User get user => auth.currentUser!;
  // for getting firebase messaging token
  // for accessing firebase messaging (Push Notification)
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // Đăng ký bằng email và mật khẩu
  Future<UserModel?> signUpWithEmailAndPassword({
    String? displayName,
    required String email,
    required String password,
    String? photoURL,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      // User? user = auth.currentUser;
      await user!.updateProfile(displayName: displayName, photoURL: photoURL);
      print("=======${user.toString()}");
      var userNew = UserModel(
        id: user.uid,
        email: email,
        name: displayName,
        image: photoURL,
      );

      return userNew;
    } catch (e) {
      print("Loi: $e");
      return null;
    }
  }

// Đăng nhập bằng email và mật khẩu
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      print(user?.uid.toString());
      return UserModel(
        id: user?.uid,
        email: user?.email,
        name: user?.displayName,
        image: user?.photoURL,
      );
    } catch (e) {
      print("Loi: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {}
  }

  Future<bool> changePass(String password) async {
    try {
      await auth.currentUser?.updatePassword(password);
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> deteteAccount(UserModel userModel) async {
    try {
      auth.currentUser?.delete();
      return true;
    } catch (e) {
      print("Loi delete: $e");
      return false;
    }
  }

  Future<UserModel?> updateImage({String? imageUrl}) async {
    var userrr = auth.currentUser;
    if (userrr != null) {
      try {
        await userrr.updatePhotoURL(imageUrl);
      } catch (e) {}
      return UserModel(
        id: userrr.uid,
        email: userrr.email,
        name: userrr.displayName,
        image: userrr.photoURL,
      );
    }
    return null;
  }

  Future<UserModel?> updateName({required String name}) async {
    var userrr = auth.currentUser;
    if (userrr != null) {
      try {
        await userrr.updateDisplayName(name);
      } catch (e) {}
      return UserModel(
        id: userrr.uid,
        email: userrr.email,
        name: userrr.displayName,
        image: userrr.photoURL,
      );
    }
    return null;
  }
}
