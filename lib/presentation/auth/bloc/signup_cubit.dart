import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/user.dart';
import 'package:todo_app/presentation/auth/bloc/signup_state.dart';
import 'package:todo_app/service/auth_service.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authService}) : super(Unregistered());

  final AuthService authService;

  void signUp(UserModel user) async {
    try {
      emit(Registering());
      final UserCredential? userCredential =
          await authService.signUp(user: user);
      if (userCredential != null) {
        emit(Registered());
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account is already exists with this email';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email';
      } else {
        message = 'Error!';
      }
      emit(RegisterFailure(errorMessage: message));
    }
  }
}
