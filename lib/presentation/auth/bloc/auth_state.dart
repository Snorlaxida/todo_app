abstract class AuthState {}

class Unauthorized extends AuthState {}

class LoggingIn extends AuthState {}

class Authorized extends AuthState {}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}
