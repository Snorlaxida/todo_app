import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/navigation/bloc/navigation_cubit.dart';
import 'package:todo_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:todo_app/presentation/auth/bloc/signup_cubit.dart';
import 'package:todo_app/presentation/auth/pages/signin_screen.dart';
import 'package:todo_app/presentation/auth/pages/signup_screen.dart';
import 'package:todo_app/presentation/home/bloc/todo_list_cubit.dart';
import 'package:todo_app/presentation/home/bloc/todo_task_detail_cubit.dart';
import 'package:todo_app/presentation/home/pages/todo_detail_screen.dart';
import 'package:todo_app/presentation/home/pages/todo_detail_screen_update.dart';
import 'package:todo_app/presentation/home/pages/todo_screen.dart';
import 'package:todo_app/presentation/splash/screen/splash_screen.dart';
import 'package:todo_app/service/auth_service.dart';
import 'package:todo_app/service/firestore_service.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = '/splash';

  static final GoRouter router = GoRouter(
      initialLocation: initR,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          path: '/splash',
          name: 'Splash',
          routes: const [],
          builder: (context, state) => BlocProvider(
            create: (context) => NavigationCubit(),
            child: const SplashScreen(),
          ),
        ),
        GoRoute(
          path: '/signin',
          name: 'SignIn',
          routes: const [],
          builder: (context, state) => BlocProvider(
            create: (context) => AuthCubit(authService: AuthService()),
            child: const SigninScreen(),
          ),
        ),
        GoRoute(
          path: '/signup',
          name: 'SignUp',
          routes: const [],
          builder: (context, state) => BlocProvider(
            create: (context) => SignUpCubit(authService: AuthService()),
            child: const SignupScreen(),
          ),
        ),
        GoRoute(
          path: '/tasks',
          name: 'Tasks',
          builder: (context, state) => BlocProvider(
            create: (context) => TodoListCubit(
                firestoreService: FirestoreService(),
                authService: AuthService()),
            child: const ToDoScreen(),
          ),
          routes: [
            GoRoute(
              path: 'details',
              name: 'Details',
              routes: const [],
              builder: (context, state) => BlocProvider(
                create: (context) =>
                    TodoTaskDetailCubit(firestoreService: FirestoreService()),
                child: const TodoDetailScreen(),
              ),
            ),
            GoRoute(
                path: 'update',
                name: 'UpdateDetails',
                routes: const [],
                builder: (context, state) {
                  final args = state.extra as Map<String, dynamic>?;
                  final oldTitle = args!['oldTitle'];
                  final oldDateTime = args['oldDateTime'];
                  final docId = args['docId'];
                  final isCompleted = args['isCompleted'];
                  final oldDescription = args['oldDescription'];
                  return BlocProvider(
                    create: (context) => TodoTaskDetailCubit(
                        firestoreService: FirestoreService()),
                    child: TodoDetailScreenUpdate(
                      oldTitle: oldTitle,
                      oldDateTime: oldDateTime,
                      docId: docId,
                      isCompleted: isCompleted,
                      oldDescription: oldDescription,
                    ),
                  );
                }),
          ],
        )
      ]);
}
