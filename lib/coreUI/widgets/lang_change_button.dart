import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LangChangeButton extends StatelessWidget {
  const LangChangeButton({
    super.key,
    required this.onLocaleChanged,
  });

  final VoidCallback onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        context.locale.toString() == 'en'
            ? await context.setLocale(const Locale('ru'))
            : await context.setLocale(const Locale('en'));
        onLocaleChanged();
      },
      icon: const Icon(Icons.language),
    );
  }
}
