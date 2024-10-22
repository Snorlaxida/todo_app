import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/coreUI/bloc/theme_cubit.dart';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = context.watch<ThemeCubit>().state;
    return IconButton(
      onPressed: () {
        currentThemeMode == ThemeMode.light
            ? context.read<ThemeCubit>().updateThemeMode(ThemeMode.dark)
            : context.read<ThemeCubit>().updateThemeMode(ThemeMode.light);
      },
      icon: const Icon(Icons.sunny),
    );
  }
}
