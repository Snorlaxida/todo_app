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
      "title": "Sign in now",
      "subtitle": "Please sign in to continue our app",
      "forgetPassword": "Forget password?",
      "signInText": "Sign in",
      "noAccount": "Don't have an account? ",
      "signUpText": "Sign up",
      "orConnect": "Or connect"
    },
    "signUp": {
      "title": "Sign up now",
      "subtitle": "Please fill the details and create account",
      "passwordMust": "Password must be 8 character",
      "signUpText": "Sign up",
      "alreadyHaveAccount": "Already have an account? ",
      "signInText": "Sign in",
      "orConnect": "Or connect"
    }
  }
};
static const Map<String,dynamic> ru = {
  "common": {
    "signIn": {
      "title": "Войти",
      "subtitle": "Пожалуйста войдите для продолжения",
      "forgetPassword": "Забыли пароль? ",
      "signInText": "Войти",
      "noAccount": "Нет аккаунта?",
      "signUpText": "Зарегистрироваться",
      "orConnect": "Или войти через"
    },
    "signUp": {
      "title": "Регистрация",
      "subtitle": "Введите информацию и создайте аккаунт",
      "passwordMust": "Пароль должен иметь 8 символов",
      "signUpText": "Зарегистрироваться",
      "alreadyHaveAccount": "Уже есть аккаунт? ",
      "signInText": "Войти",
      "orConnect": "Или войти через"
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
