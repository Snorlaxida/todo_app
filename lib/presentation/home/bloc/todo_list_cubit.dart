import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/todo_task.dart';
import 'package:todo_app/presentation/home/bloc/todo_list_state.dart';
import 'package:todo_app/service/auth_service.dart';
import 'package:todo_app/service/firestore_service.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit({
    required this.authService,
    required this.firestoreService,
  }) : super(Initial());

  final FirestoreService firestoreService;
  final AuthService authService;

  void getTodoList() async {
    try {
      emit(LoadingTodoList());
      final tasksStream = firestoreService.getTasksStream();

      tasksStream.listen(
        (snapshot) {
          final List<TodoTask> taskList = [];
          for (var doc in snapshot.docs) {
            final taskData = doc.data() as Map<String, dynamic>;
            final task = TodoTask(
              docId: doc.id,
              userId: taskData['userId'],
              title: taskData['title'],
              description: taskData['description'],
              deadline: (taskData['deadline'] as Timestamp).toDate(),
              isCompleted: taskData['isComplited'],
            );
            taskList.add(task);
          }
          taskList.isNotEmpty
              ? emit(TodoListReady(todoTasks: taskList))
              : emit(TodoListEmpty());
        },
      );
    } catch (e) {
      emit(TodoListFailure(errorMessage: e.toString()));
    }
  }

  void updateIsCompleted(String docId, bool newValue) async {
    try {
      await firestoreService.updateIsCompleted(docId, newValue);
    } catch (e) {
      emit(TodoListFailure(errorMessage: e.toString()));
    }
  }

  void deleteTodoTask(String docId) async {
    await firestoreService.deleteTask(docId);
  }

  Future<void> logout() async {
    emit(LoadingTodoList());
    await authService.signOut();
  }
}
