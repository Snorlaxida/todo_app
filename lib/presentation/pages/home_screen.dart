import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/localization/generated/locale_keys.g.dart';
import 'package:todo_app/core/theme/app_theme.dart';
import 'package:todo_app/presentation/bloc/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.common_signIn_title.tr()),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // context.read<ThemeCubit>().updateThemeMode(ThemeMode.dark);
            currentThemeMode == ThemeMode.light
                ? context.read<ThemeCubit>().updateThemeMode(ThemeMode.dark)
                : context.read<ThemeCubit>().updateThemeMode(ThemeMode.light);
            // context.locale.toString() == 'en'
            //     ? context.setLocale(const Locale('ru'))
            //     : context.setLocale(const Locale('en'));
          },
          child: Text(LocaleKeys.common_signIn_forgetPassword.tr()),
        ),
      ),
    );
  }
}
