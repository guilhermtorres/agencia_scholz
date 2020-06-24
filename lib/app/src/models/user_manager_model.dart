import 'package:agencia_scholz/app/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManager {
  final FirebaseAuth auth = FirebaseAuth.instance;
  void signIn(User user) {
    auth.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }
}
