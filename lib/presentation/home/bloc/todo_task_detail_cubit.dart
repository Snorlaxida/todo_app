import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/todo_task.dart';
import 'package:todo_app/presentation/home/bloc/todo_task_detail_state.dart';
import 'package:todo_app/service/firestore_service.dart';

class TodoTaskDetailCubit extends Cubit<TodoTaskDetailState> {
  TodoTaskDetailCubit({required this.firestoreService}) : super(Initial());

  final FirestoreService firestoreService;

  void createTodoTask(TodoTask task) async {
    try {
      emit(Loading());
      if (task.title == '' || task.description == '' || task.deadline == null) {
        throw Exception('Enter correct data!');
      }
      await firestoreService.addTask(task);
      emit(TodoTaskReady());
    } catch (e) {
      emit(TodoTaskFailure(errorMessage: e.toString()));
    }
  }

  void updateTodoTask(TodoTask task) async {
    try {
      emit(Loading());
      if (task.title == '' || task.description == '' || task.deadline == null) {
        throw Exception('Enter correct data!');
      }
      await firestoreService.updateTask(task.docId!, task);
      emit(TodoTaskReady());
    } catch (e) {
      emit(TodoTaskFailure(errorMessage: e.toString()));
    }
  }
}
