import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<bool> {
  NavigationCubit() : super(false) {
    checkIfUserAuthorized();
  }

  void checkIfUserAuthorized() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        emit(false);
      } else {
        emit(true);
      }
    });
  }
}
