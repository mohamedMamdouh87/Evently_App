import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/show_dialogue_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class GoogleAuthUtils {
  final FirebaseAuth _auth = FirebaseAuth.instance;
static  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      await GoogleSignIn.instance.initialize();
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
          .authenticate();
      if (googleUser == null) {
        ShowDialogueUtils.showMessage(
            context, 'google_sign_in_aborted_by_user'.tr());
        return null;
      }
      final GoogleSignInAuthentication? googleAuth = await googleUser
          ?.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
          credential);
      final user = userCredential.user;
      return user;
    }
    on FirebaseAuthException catch (e) {
      ShowDialogueUtils.showMessage(context, e.message ?? 'something_went_wrong'.tr());

    }
  }
}
