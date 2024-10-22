abstract class SignUpState {}

class Unregistered extends SignUpState {}

class Registering extends SignUpState {}

class Registered extends SignUpState {}

class RegisterFailure extends SignUpState {
  final String errorMessage;

  RegisterFailure({required this.errorMessage});
}
