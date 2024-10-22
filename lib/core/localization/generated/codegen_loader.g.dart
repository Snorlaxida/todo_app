// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "common": {
    "signIn": {
      "title": "Sign in",
      "email": "Email",
      "emailHint": "Enter your email",
      "password": "Password",
      "passwordHint": "Enter your password",
      "signInText": "Sign in",
      "noAccount": "Don't have account? ",
      "signUpText": "Sign up"
    },
    "signUp": {
      "title": "Sign Up",
      "email": "Email",
      "password": "Password",
      "emailHint": "Enter your email",
      "passwordHint": "Enter your password",
      "signUpText": "Sign up",
      "alreadyHaveAccount": "Already have account? ",
      "signInText": "Sign in"
    }
  }
};
static const Map<String,dynamic> ru = {
  "common": {
    "signIn": {
      "title": "Авторизация",
      "email": "Почта",
      "emailHint": "Введите почту",
      "password": "Пароль",
      "passwordHint": "Введите пароль",
      "signInText": "Войти",
      "noAccount": "Нет аккаунта? ",
      "signUpText": "Зарегистрироваться"
    },
    "signUp": {
      "title": "Регистрация",
      "email": "Почта",
      "emailHint": "Введите почту",
      "password": "Пароль",
      "passwordHint": "Введите пароль",
      "signUpText": "Зарегистрироваться",
      "alreadyHaveAccount": "Уже есть аккаунт? ",
      "signInText": "Войти"
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
