import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/user.dart';
import 'package:todo_app/presentation/auth/bloc/auth_state.dart';
import 'package:todo_app/service/auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authService}) : super(Unauthorized());

  final AuthService authService;

  void signIn(UserModel user) async {
    try {
      emit(LoggingIn());
      final UserCredential? userCredential =
          await authService.signIn(user: user);
      if (userCredential != null) {
        emit(Authorized());
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for this email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for this user';
      } else {
        message = 'Error!';
      }
      emit(AuthFailure(errorMessage: message));
    }
  }
}
