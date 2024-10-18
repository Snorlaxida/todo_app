import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/localization/generated/codegen_loader.g.dart';

class LocalizationWrapper extends StatelessWidget {
  final Widget Function(BuildContext context) builder;

  const LocalizationWrapper({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: Builder(
        builder: builder,
      ),
    );
  }
}
