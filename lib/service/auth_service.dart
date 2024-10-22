import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/model/user.dart';

class AuthService {
  Future<UserCredential?> signUp({required UserModel user}) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  Future<UserCredential?> signIn({required UserModel user}) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
