import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_app/core/localization/localization_wrapper.dart';
import 'package:todo_app/core/theme/app_theme.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/navigation/app_navigation.dart';
import 'package:todo_app/coreUI/bloc/theme_cubit.dart';
import 'package:todo_app/service/background_service.dart';
import 'package:todo_app/service/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getPermissions();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  // await BackgroundService.initializeService();
  // tz.initializeTimeZones();
  // await NotificationService.initializeNotifications();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return LocalizationWrapper(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ThemeCubit(),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: AppTheme.lightMode,
                darkTheme: AppTheme.darkMode,
                themeMode: themeMode,
                routerConfig: AppNavigation.router,
              );
            },
          ),
        );
      },
    );
  }
}

void getPermissions() async {
  var alarmStatus = await Permission.scheduleExactAlarm.status;
  if (alarmStatus.isDenied) {
    await Permission.scheduleExactAlarm.request();
  }

  var notificationStatus = await Permission.notification.status;
  if (notificationStatus.isDenied) {
    await Permission.notification.request();
  }
}
