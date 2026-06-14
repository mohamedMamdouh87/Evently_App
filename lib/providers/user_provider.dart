import 'package:evently/models/myuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/firebase_utils.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;
  void setUser(MyUser? newUser) {
    currentUser = newUser;
    notifyListeners();
  }
  Future<void> initUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) return;

    final user = await FirebaseUtils.readUser(firebaseUser.uid);

    if (user != null) {
      currentUser = user;
      notifyListeners();
    }
  }

}