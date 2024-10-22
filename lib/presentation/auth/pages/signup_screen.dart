import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/localization/generated/locale_keys.g.dart';
import 'package:todo_app/coreUI/widgets/lang_change_button.dart';
import 'package:todo_app/coreUI/widgets/theme_change_button.dart';
import 'package:todo_app/model/user.dart';
import 'package:todo_app/presentation/auth/bloc/signup_cubit.dart';
import 'package:todo_app/presentation/auth/bloc/signup_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  void dispose() {
    _emailCon.dispose();
    _passwordCon.dispose();
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signin(context),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const ThemeChangeButton(),
        actions: [
          LangChangeButton(
            onLocaleChanged: _onLocaleChanged,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.common_signUp_title.tr(),
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 40),
                _emailAddress(_emailCon),
                const SizedBox(height: 20),
                _password(_passwordCon),
                const SizedBox(height: 40),
                SignUpButton(
                  emailCon: _emailCon,
                  passwordCon: _passwordCon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required TextEditingController emailCon,
    required TextEditingController passwordCon,
  })  : _emailCon = emailCon,
        _passwordCon = passwordCon;

  final TextEditingController _emailCon;
  final TextEditingController _passwordCon;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is Registered) {
          context.goNamed('SignIn');
        }
        if (state is RegisterFailure) {
          Fluttertoast.showToast(
            msg: state.errorMessage,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 14,
          );
        }
      },
      child: ElevatedButton(
        onPressed: () async {
          context.read<SignUpCubit>().signUp(UserModel(
                email: _emailCon.text,
                password: _passwordCon.text,
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff0D6EFD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(double.infinity, 60),
          elevation: 0,
        ),
        child: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            if (state is Registering) {
              return const CircularProgressIndicator();
            } else {
              return Text(
                LocaleKeys.common_signUp_signUpText.tr(),
                style: const TextStyle(color: Colors.white),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _emailAddress(TextEditingController email) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        LocaleKeys.common_signUp_email.tr(),
        style: const TextStyle(fontSize: 15),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: email,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          hintText: LocaleKeys.common_signUp_emailHint.tr(),
          hintStyle: const TextStyle(
            color: Color(0xff6A6A6A),
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
          fillColor: const Color(0xffF7F7F9),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    ],
  );
}

Widget _password(TextEditingController password) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        LocaleKeys.common_signUp_password.tr(),
        style: const TextStyle(fontSize: 15),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: password,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          hintText: LocaleKeys.common_signUp_passwordHint.tr(),
          hintStyle: const TextStyle(
            color: Color(0xff6A6A6A),
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
          fillColor: const Color(0xffF7F7F9),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      )
    ],
  );
}

Widget _signin(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: LocaleKeys.common_signUp_alreadyHaveAccount.tr(),
            style: const TextStyle(
                color: Color(0xff6A6A6A),
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
          TextSpan(
              text: LocaleKeys.common_signUp_signInText.tr(),
              style: const TextStyle(
                  color: Color(0xff1A1D1E),
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.goNamed('SignIn');
                }),
        ])),
  );
}
