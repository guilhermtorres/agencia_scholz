import 'package:agencia_scholz/app/src/models/user_model.dart';
import 'package:agencia_scholz/app/src/utils/firebase_erros_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  FirebaseUser user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn({User user, Function onFail, Function onSucess}) async {
    _loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      this.user = result.user;

      onSucess();
    } on PlatformException catch (e) {
      debugPrint(getErrorString(e.code));
      onFail(getErrorString(e.code));
    }
    _loading = false;
  }

  Future<void> signUp({User user, Function onFail, Function onSucess}) async {
    _loading = true;
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      user.id = result.user.uid;
      await user.saveData();

      onSucess();
    } on PlatformException catch (e) {
      debugPrint(getErrorString(e.code));
      onFail(getErrorString(e.code));
    }
    _loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    final FirebaseUser currentUser = await auth.currentUser();
    if (currentUser != null) {
      final DocumentSnapshot docUser = await firestore.collection('users').document(currentUser.uid).get();
    }
    notifyListeners();
  }
}
