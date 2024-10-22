import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/navigation/bloc/navigation_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, bool>(
      listener: (context, isAuthorized) {
        if (isAuthorized) {
          context.goNamed('Tasks');
        } else {
          context.goNamed('SignIn');
        }
      },
      child: const Scaffold(
        body: Center(),
      ),
    );
  }
}
