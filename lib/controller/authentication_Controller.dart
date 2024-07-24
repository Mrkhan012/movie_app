import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_apk/utils/color.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      print('User is null, navigating to login');
      Get.offAllNamed('/login');
    } else {
      print('User is authenticated, navigating to home');
      Get.offAllNamed('/home');
    }
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Show a success snackbar after successful sign-in
      Get.snackbar(
        'Login Success',
        'You have successfully logged in with Google!',
        backgroundColor: kDefaultBlueColor, // Blue background
        colorText: Colors.white, // White text
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } catch (e) {
      // Show an error snackbar if something goes wrong
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red, // Red background for error
        colorText: Colors.white, // White text
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
